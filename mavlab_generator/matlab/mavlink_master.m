classdef mavlink
    %mavlink Class
    %Contains settings for the MATLAB MAVLINK implementation
    
    %System and component ID used for all transmissions
    properties(Constant)
        SYSID = 255;
        COMPID = 1;
    end
    
    %Error handling functions
    methods(Static)
        
        %Header for every error message
        function throwError()
            fprintf(2,'MAVLAB-ERROR |');
            dbstack(2)
        end
       
        %Error for missing fields during message packing
        function throwPackingError(emptyField)
            mavlink.throwError();
            fprintf(2,'\tMessage data in %s is not valid\n',emptyField);
        end
        
        %Error when passing the incorrect data type to a function
        function throwTypeError(inputName, requiredType)
            mavlink.throwError();
            fprintf(2,'\tInput variable "%s" is not of data type "%s"\n',inputName,requiredType);
        end
        
        %Error for an index that is out of bounds
        function throwIndexError()
            mavlink.throwError();
            fprintf(2,'\tRequested operation leads to a fatal "index out of bounds" error\n');
        end
        
        %Used for custom errors that occur in specific circumstances
        function throwCustomError(description)
           mavlink.throwError();
           fprintf(2,'\t%s\n',description)
        end
             
    end
    
end

