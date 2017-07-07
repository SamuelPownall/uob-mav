classdef mavlink_stats < handle
    %MAVLINK_STATS Class
    %Contains information such as error counts and packet drops
    
    properties
        packetsDropped = 0;
        packetsReceived = 0;
        packetLoss = 0;
    end
    
    methods
        
        %Increment packet drop counter
        function incrementPacketsDropped(obj, incr)
            if nargin == 2
                obj.packetsDropped = obj.packetsDropped + incr; 
            else
                obj.packetsDropped = obj.packetsDropped + 1; 
            end
        end
        
        %Increment packet received counter
        function incrementPacketsReceived(obj, incr)
            if nargin == 2
                obj.packetsReceived = obj.packetsReceived + incr; 
            else
                obj.packetsReceived = obj.packetsReceived + 1; 
            end
        end
        
        %Calculate current packet loss
        function packetLoss = get.packetLoss(obj)
            if obj.packetsReceived > 0
                packetLoss = 100 * obj.packetsDropped / (obj.packetsDropped + obj.packetsReceived);
            else
                packetLoss = -1;
            end
        end
        
    end
    
end

