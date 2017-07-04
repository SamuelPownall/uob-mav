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
        
        %Header for error messages which don't stop execution
        function throwError()
            fprintf(2,'\nMAVLAB: WARNING\n');
            dbstack(2)
            fprintf(2,'Description: ');
        end
        
        %Header for error messages which halt execution
        function throwFatalError()
            fprintf(2,'\nMAVLAB: FATAL ERROR\n');
            dbstack(2)
            fprintf(2,'Description: ');
        end
       
        %Error for missing fields during message packing
        function throwPackingError(emptyField)
            mavlink.throwError();
            fprintf(2,'Message data in %s is not valid\n\n',emptyField);
        end
        
        %Error when passing the incorrect data type to a function
        function throwTypeError(inputName, requiredType)
            mavlink.throwError();
            fprintf(2,'Input variable "%s" is not of data type "%s"\n\n',inputName,requiredType);
        end
        
        %Error for an index that is out of bounds
        function throwIndexError()
            mavlink.throwError();
            fprintf(2,'Requested operation leads to a fatal "index out of bounds" error\n\n');
        end
        
        %Error for when a mavlink message is not supported
        function throwUnsupportedMessageError(msgid)
            mavlink.throwError();
            fprintf(2,'Message (ID = %d) is not supported by this instance of MAVLAB\n\n',msgid);
        end
        
        %Used for custom errors that occur in specific circumstances
        function throwCustomError(description)
           mavlink.throwError();
           fprintf(2,'%s\n\n',description)
        end
             
    end
    
end

