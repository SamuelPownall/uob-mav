classdef mavlink_message < handle
    %MAVLINK_MSG Class
    %Common interface for all MAVLINK messages
    
    properties
        sysid;  %ID of the sending system
        compid; %ID of the sending component
        msgid;  %ID representing the message type
    end
    
    methods
        
    end
          
end

