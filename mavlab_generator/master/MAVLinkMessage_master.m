classdef MAVLinkMessage < MAVLinkHandle
    %MAVLINKMESSAGE: Superclass for all generated MAVLink message classes
    %Description:
    %    Contains properties and methods which are present in all MAVLink message classes.
    
    properties
        sysid;  %ID of the sending system
        compid; %ID of the sending component
        msgid;  %ID representing the message type
    end
    
    methods
        
        function set.sysid(obj,value)
            if value == uint8(value)
                obj.sysid = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.compid(obj,value)
            if value == uint8(value)
                obj.compid = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.msgid(obj,value)
            if value == uint8(value)
                obj.msgid = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end
          
end

