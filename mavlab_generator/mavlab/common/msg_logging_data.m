classdef msg_logging_data < mavlink_message
    %MAVLINK Message Class
    %Name: logging_data	ID: 266
    %Description: A message containing logged data (see also MAV_CMD_LOGGING_START)
            
    properties(Constant)
        ID = 266
        LEN = 255
    end
    
    properties        
		sequence	%sequence number (can wrap) (uint16)
		target_system	%system ID of the target (uint8)
		target_component	%component ID of the target (uint8)
		length	%data length (uint8)
		first_message_offset	%offset into data where first message starts. This can be used for recovery, when a previous message got lost (set to 255 if no start exists). (uint8)
		data	%logged data (uint8[249])
	end
    
    methods
        
        %Constructor: msg_logging_data
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_logging_data(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            emptyField = obj.verify();
            if emptyField == 0
        
                packet = mavlink_packet(msg_logging_data.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_logging_data.ID;
                
				packet.payload.putUINT16(obj.sequence);

				packet.payload.putUINT8(obj.target_system);

				packet.payload.putUINT8(obj.target_component);

				packet.payload.putUINT8(obj.length);

				packet.payload.putUINT8(obj.first_message_offset);
            
                for i = 1:249
                    packet.payload.putUINT8(obj.data(i));
                end
                                        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_logging_data.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
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
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.sequence,2) ~= 1
                result = 'sequence';                                        
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';                                        
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';                                        
            elseif size(obj.length,2) ~= 1
                result = 'length';                                        
            elseif size(obj.first_message_offset,2) ~= 1
                result = 'first_message_offset';                                        
            elseif size(obj.data,2) ~= 249
                result = 'data';                            
            else
                result = 0;
            end
            
        end
                                
        function set.sequence(obj,value)
            if value == uint16(value)
                obj.sequence = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | logging_data.set.sequence()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | logging_data.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | logging_data.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.length(obj,value)
            if value == uint8(value)
                obj.length = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | logging_data.set.length()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.first_message_offset(obj,value)
            if value == uint8(value)
                obj.first_message_offset = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | logging_data.set.first_message_offset()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.data(obj,value)
            if value == uint8(value)
                obj.data = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | logging_data.set.data()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end