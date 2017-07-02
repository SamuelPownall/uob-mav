classdef msg_mission_item_reached < mavlink_message
    %MAVLINK Message Class
    %Name: mission_item_reached	ID: 46
    %Description: A certain mission item has been reached. The system will either hold this position (or circle on the orbit) or (if the autocontinue on the WP was set) continue to the next MISSION.
            
    properties(Constant)
        ID = 46
        LEN = 2
    end
    
    properties        
		seq	%Sequence (uint16[1])
	end

    
    methods
        
        %Constructor: msg_mission_item_reached
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_mission_item_reached(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_mission_item_reached.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_mission_item_reached.ID;
                
			packet.payload.putUINT16(obj.seq);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.seq = payload.getUINT16();

		end
            
        function set.seq(obj,value)
            if value == uint16(value)
                obj.seq = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_item_reached.set.seq()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                        
	end
end