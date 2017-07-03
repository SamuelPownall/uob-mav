classdef msg_v2_extension < mavlink_message
    %MAVLINK Message Class
    %Name: v2_extension	ID: 248
    %Description: Message implementing parts of the V2 payload specs in V1 frames for transitional support.
            
    properties(Constant)
        ID = 248
        LEN = 254
    end
    
    properties        
		message_type	%A code that identifies the software component that understands this message (analogous to usb device classes or mime type strings).  If this code is less than 32768, it is considered a 'registered' protocol extension and the corresponding entry should be added to https://github.com/mavlink/mavlink/extension-message-ids.xml.  Software creators can register blocks of message IDs as needed (useful for GCS specific metadata, etc...). Message_types greater than 32767 are considered local experiments and should not be checked in to any widely distributed codebase. (uint16)
		target_network	%Network ID (0 for broadcast) (uint8)
		target_system	%System ID (0 for broadcast) (uint8)
		target_component	%Component ID (0 for broadcast) (uint8)
		payload	%Variable length payload. The length is defined by the remaining message length when subtracting the header and other fields.  The entire content of this block is opaque unless you understand any the encoding message_type.  The particular encoding used can be extension specific and might not always be documented as part of the mavlink specification. (uint8[249])
	end
    
    methods
        
        %Constructor: msg_v2_extension
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_v2_extension(packet)
        
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
        
                packet = mavlink_packet(msg_v2_extension.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_v2_extension.ID;
                
				packet.payload.putUINT16(obj.message_type);

				packet.payload.putUINT8(obj.target_network);

				packet.payload.putUINT8(obj.target_system);

				packet.payload.putUINT8(obj.target_component);
            
                for i = 1:249
                    packet.payload.putUINT8(obj.payload(i));
                end
                                        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_v2_extension.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.message_type = payload.getUINT16();

			obj.target_network = payload.getUINT8();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();
            
            for i = 1:249
                obj.payload(i) = payload.getUINT8();
            end
                            
		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.message_type,2) ~= 1
                result = 'message_type';                                        
            elseif size(obj.target_network,2) ~= 1
                result = 'target_network';                                        
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';                                        
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';                                        
            elseif size(obj.payload,2) ~= 249
                result = 'payload';                            
            else
                result = 0;
            end
            
        end
                                
        function set.message_type(obj,value)
            if value == uint16(value)
                obj.message_type = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | v2_extension.set.message_type()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.target_network(obj,value)
            if value == uint8(value)
                obj.target_network = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | v2_extension.set.target_network()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | v2_extension.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | v2_extension.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.payload(obj,value)
            if value == uint8(value)
                obj.payload = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | v2_extension.set.payload()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end