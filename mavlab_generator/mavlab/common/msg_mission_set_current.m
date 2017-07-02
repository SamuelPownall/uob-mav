classdef msg_mission_set_current < mavlink_message
    %MAVLINK Message Class
    %Name: mission_set_current	ID: 41
    %Description: Set the mission item with sequence number seq as current item. This means that the MAV will continue to this mission item on the shortest path (not following the mission items in-between).
            
    properties(Constant)
        ID = 41
        LEN = 4
    end
    
    properties        
		seq	%Sequence (uint16[1])
		target_system	%System ID (uint8[1])
		target_component	%Component ID (uint8[1])
	end

    
    methods
        
        %Constructor: msg_mission_set_current
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_mission_set_current(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_mission_set_current.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_mission_set_current.ID;
                
			packet.payload.putUINT16(obj.seq);

			packet.payload.putUINT8(obj.target_system);

			packet.payload.putUINT8(obj.target_component);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.seq = payload.getUINT16();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

		end
            
        function set.seq(obj,value)
            if value == uint16(value)
                obj.seq = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_set_current.set.seq()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_set_current.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_set_current.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end