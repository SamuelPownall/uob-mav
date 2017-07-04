classdef msg_data_transmission_handshake < mavlink_message
    %MAVLINK Message Class
    %Name: data_transmission_handshake	ID: 130
    %Description: None
            
    properties(Constant)
        ID = 130
        LEN = 13
    end
    
    properties        
		size	%total data size in bytes (set on ACK only) (uint32)
		width	%Width of a matrix or image (uint16)
		height	%Height of a matrix or image (uint16)
		packets	%number of packets beeing sent (set on ACK only) (uint16)
		type	%type of requested/acknowledged data (as defined in ENUM DATA_TYPES in mavlink/include/mavlink_types.h) (uint8)
		payload	%payload size per packet (normally 253 byte, see DATA field size in message ENCAPSULATED_DATA) (set on ACK only) (uint8)
		jpg_quality	%JPEG quality out of [1,100] (uint8)
	end
    
    methods
        
        %Constructor: msg_data_transmission_handshake
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_data_transmission_handshake(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_data_transmission_handshake.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_data_transmission_handshake.ID;
                
				packet.payload.putUINT32(obj.size);

				packet.payload.putUINT16(obj.width);

				packet.payload.putUINT16(obj.height);

				packet.payload.putUINT16(obj.packets);

				packet.payload.putUINT8(obj.type);

				packet.payload.putUINT8(obj.payload);

				packet.payload.putUINT8(obj.jpg_quality);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.size = payload.getUINT32();

			obj.width = payload.getUINT16();

			obj.height = payload.getUINT16();

			obj.packets = payload.getUINT16();

			obj.type = payload.getUINT8();

			obj.payload = payload.getUINT8();

			obj.jpg_quality = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.size,2) ~= 1
                result = 'size';                                        
            elseif size(obj.width,2) ~= 1
                result = 'width';                                        
            elseif size(obj.height,2) ~= 1
                result = 'height';                                        
            elseif size(obj.packets,2) ~= 1
                result = 'packets';                                        
            elseif size(obj.type,2) ~= 1
                result = 'type';                                        
            elseif size(obj.payload,2) ~= 1
                result = 'payload';                                        
            elseif size(obj.jpg_quality,2) ~= 1
                result = 'jpg_quality';                            
            else
                result = 0;
            end
            
        end
                                
        function set.size(obj,value)
            if value == uint32(value)
                obj.size = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
                                    
        function set.width(obj,value)
            if value == uint16(value)
                obj.width = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.height(obj,value)
            if value == uint16(value)
                obj.height = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.packets(obj,value)
            if value == uint16(value)
                obj.packets = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.type(obj,value)
            if value == uint8(value)
                obj.type = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.payload(obj,value)
            if value == uint8(value)
                obj.payload = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.jpg_quality(obj,value)
            if value == uint8(value)
                obj.jpg_quality = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end