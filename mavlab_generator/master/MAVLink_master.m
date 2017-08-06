classdef MAVLink
    %MAVLINK: Contains settings and error handling for MAVLAB
    %Description:
    %    This class is used to store the system ID and component ID to be used when communicating with
    %    other MAVLink devices. It also contains functions that are used by other MAVLAB classes to
    %    throw errors.
    
    %System and component ID used for all transmissions
    properties(Constant)
        SYSID = 255;
        COMPID = 1;
    end
    
    %Error handling functions
    methods(Static)
       
        function throwPackingError(emptyField)
            %THROWPACKINGERROR: Error for missing fields during message packing
            %Arguments:
            %    emptyField(string): Name of the field that was found empty during packing
            MAVLink.throwError();
            fprintf(2,'Message data in %s is not valid\n\n',emptyField);
        end
        
        function throwTypeError(inputName, requiredType)
            %THROWTYPEERROR: Error when passing the incorrect data type to a function
            %Arguments:
            %    inputName(string): Name of the variable to which data was being assigned
            %    requiredType(string): Type of data required by the variable
            MAVLink.throwError();
            fprintf(2,'Input variable "%s" is not of data type "%s"\n\n',inputName,requiredType);
        end
        
        function throwIndexError()
            %THROWINDEXERROR: Error for an index that is out of bounds
            MAVLink.throwError();
            fprintf(2,'Requested operation leads to a fatal "index out of bounds" error\n\n');
        end
        
        function throwUnsupportedMessageError(msgid)
            %THROWUNSUPPORTEDMESSAGEERROR: Error for when a MAVLink message is not supported
            %Arguments:
            %    msgid(double): Unsupported message ID that was requested
            MAVLink.throwError();
            fprintf(2,'Message (ID = %d) is not supported by this instance of MAVLAB\n\n',msgid);
        end
        
        function throwCustomError(description)
           %THROWCUSTOMERROR: Used for custom errors that occur in specific circumstances
           %Arguments:
           %    description(string): Custom string to be displayed as the error description
           MAVLink.throwError();
           fprintf(2,'%s\n\n',description)
        end
        
        function MAVStats = stats()
            %STATS: Holds a persistent stat object
            %Description:
            %    This method is used in order to store persistant statistics whilst maintaining the
            %    static nature of the MAVLink class.
            persistent stats;
            if isempty(stats)
                stats = MAVLinkStats();
            end
            MAVStats = stats;
        end
             
    end
    
    methods(Static,Access=private)
        
        function throwError()
            %THROWERROR: Header for error messages which don't stop execution
            fprintf(2,'\nMAVLAB: WARNING\n');
            dbstack(2)
            fprintf(2,'Description: ');
        end
        
        function throwFatalError()
            %THROWFATALERROR: Header for error messages which halt execution
            fprintf(2,'\nMAVLAB: FATAL ERROR\n');
            dbstack(2)
            fprintf(2,'Description: ');
        end
        
    end
    
end

