classdef msg_logging_data_acked < mavlink_message
    %MAVLINK Message Class
    %Name: logging_data_acked	ID: 267
    %Description: A message containing logged data which requires a LOGGING_ACK to be sent back
            
    properties(Constant)
        ID = 267
        LEN = 255
    end
    
    properties        
		sequence	%sequence number (can wrap) (uint16[1])
		target_system	%system ID of the target (uint8[1])
		target_component	%component ID of the target (uint8[1])
		length	%data length (uint8[1])
		first_message_offset	%offset into data where first message starts. This can be used for recovery, when a previous message got lost (set to 255 if no start exists). (uint8[1])
		data	%logged data (uint8[249])
	end

    
    methods
        
        %Constructor: msg_logging_data_acked
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_logging_data_acked(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_logging_data_acked.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_logging_data_acked.ID;
                
			packet.payload.putUINT16(obj.sequence);

			packet.payload.putUINT8(obj.target_system);

			packet.payload.putUINT8(obj.target_component);

			packet.payload.putUINT8(obj.length);

			packet.payload.putUINT8(obj.first_message_offset);
            
            for i = 1:249
                packet.payload.putUINT8(obj.data(i));
            end
                            
		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.sequence = payload.getUINT16();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

			obj.length = payload.getUINT8();

			obj.first_message_offset = payload.getUINT8();
            
            for i = 1:249
                obj.data(i) = payload.getUINT8();
            end
                            
		end
            
        function set.sequence(obj,value)
            if value == uint16(value)
                obj.sequence = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | logging_data_acked.set.sequence()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | logging_data_acked.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | logging_data_acked.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.length(obj,value)
            if value == uint8(value)
                obj.length = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | logging_data_acked.set.length()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.first_message_offset(obj,value)
            if value == uint8(value)
                obj.first_message_offset = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | logging_data_acked.set.first_message_offset()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.data(obj,value)
            if value == uint8(value)
                obj.data = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | logging_data_acked.set.data()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end