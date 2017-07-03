classdef mavlink_message < handle
    %MAVLINK_MSG Class
    %Common interface for all MAVLINK messages
    
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
                fprintf(2,'MAVLAB-ERROR | mavlink_message.set.sysid()\n\t Input "value" is not of type "uint8"\n');
            end
        end
        
        function set.compid(obj,value)
            if value == uint8(value)
                obj.compid = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | mavlink_message.set.compid()\n\t Input "value" is not of type "uint8"\n');
            end
        end
        
        function set.msgid(obj,value)
            if value == uint8(value)
                obj.msgid = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | mavlink_message.set.msgid()\n\t Input "value" is not of type "uint8"\n');
            end
        end
        
    end
          
end

