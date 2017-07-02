classdef msg_mission_current < mavlink_message
    %MAVLINK Message Class
    %Name: mission_current	ID: 42
    %Description: Message that announces the sequence number of the current active mission item. The MAV will fly towards this mission item.
            
    properties(Constant)
        ID = 42
        LEN = 2
    end
    
    properties        
		seq	%Sequence (uint16[1])
	end

    
    methods
        
        %Constructor: msg_mission_current
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_mission_current(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_mission_current.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_mission_current.ID;
                
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
                fprintf(2,'MAVLAB-ERROR | mission_current.set.seq()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                        
	end
end