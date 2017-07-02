classdef msg_logging_ack < mavlink_message
    %MAVLINK Message Class
    %Name: logging_ack	ID: 268
    %Description: An ack for a LOGGING_DATA_ACKED message
            
    properties(Constant)
        ID = 268
        LEN = 4
    end
    
    properties        
		sequence	%sequence number (must match the one in LOGGING_DATA_ACKED) (uint16[1])
		target_system	%system ID of the target (uint8[1])
		target_component	%component ID of the target (uint8[1])
	end

    
    methods
        
        %Constructor: msg_logging_ack
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_logging_ack(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_logging_ack.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_logging_ack.ID;
                
			packet.payload.putUINT16(obj.sequence);

			packet.payload.putUINT8(obj.target_system);

			packet.payload.putUINT8(obj.target_component);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.sequence = payload.getUINT16();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

		end
            
        function set.sequence(obj,value)
            if value == uint16(value)
                obj.sequence = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | logging_ack.set.sequence()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | logging_ack.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | logging_ack.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end