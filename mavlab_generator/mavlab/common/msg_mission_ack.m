classdef msg_mission_ack < mavlink_message
    %MAVLINK Message Class
    %Name: mission_ack	ID: 47
    %Description: Ack message during MISSION handling. The type field states if this message is a positive ack (type=0) or if an error happened (type=non-zero).
            
    properties(Constant)
        ID = 47
        LEN = 3
    end
    
    properties        
		target_system	%System ID (uint8[1])
		target_component	%Component ID (uint8[1])
		type	%See MAV_MISSION_RESULT enum (uint8[1])
	end

    
    methods
        
        %Constructor: msg_mission_ack
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_mission_ack(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_mission_ack.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_mission_ack.ID;
                
			packet.payload.putUINT8(obj.target_system);

			packet.payload.putUINT8(obj.target_component);

			packet.payload.putUINT8(obj.type);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

			obj.type = payload.getUINT8();

		end
            
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_ack.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_ack.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.type(obj,value)
            if value == uint8(value)
                obj.type = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_ack.set.type()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end