classdef msg_data_transmission_handshake < mavlink_message
	%MSG_DATA_TRANSMISSION_HANDSHAKE: MAVLINK Message ID = 130
    %Description:
    %    No description available
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    size(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    size(uint32): total data size in bytes (set on ACK only)
    %    width(uint16): Width of a matrix or image
    %    height(uint16): Height of a matrix or image
    %    packets(uint16): number of packets beeing sent (set on ACK only)
    %    type(uint8): type of requested/acknowledged data (as defined in ENUM DATA_TYPES in mavlink/include/mavlink_types.h)
    %    payload(uint8): payload size per packet (normally 253 byte, see DATA field size in message ENCAPSULATED_DATA) (set on ACK only)
    %    jpg_quality(uint8): JPEG quality out of [1,100]
	
	properties(Constant)
		ID = 130
		LEN = 13
	end
	
	properties
        size	%total data size in bytes (set on ACK only)	|	(uint32)
        width	%Width of a matrix or image	|	(uint16)
        height	%Height of a matrix or image	|	(uint16)
        packets	%number of packets beeing sent (set on ACK only)	|	(uint16)
        type	%type of requested/acknowledged data (as defined in ENUM DATA_TYPES in mavlink/include/mavlink_types.h)	|	(uint8)
        payload	%payload size per packet (normally 253 byte, see DATA field size in message ENCAPSULATED_DATA) (set on ACK only)	|	(uint8)
        jpg_quality	%JPEG quality out of [1,100]	|	(uint8)
    end

    methods

        function obj = msg_data_transmission_handshake(size,width,height,packets,type,payload,jpg_quality,varargin)
        %Create a new data_transmission_handshake message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(size,'mavlink_packet')
                    packet = size;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('size','mavlink_packet');
                end
            
            elseif nargin == 7
                obj.size = size;
                obj.width = width;
                obj.height = height;
                obj.packets = packets;
                obj.type = type;
                obj.payload = payload;
                obj.jpg_quality = jpg_quality;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        function packet = pack(obj)
        %PACK: Packs this MAVLINK message into a mavlink_packet
        %Description:
        %    Packs the fields of a message into a mavlink_packet which can be encoded
        %    for transmission.

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

        function unpack(obj, payload)
        %UNPACK: Unpacks a mavlink_payload into this MAVLINK message
        %Description:
        %    Extracts the data from a mavlink_payload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(mavlink_payload): The payload to be unpacked into this MAVLINK message

            payload.resetIndex();
            
            obj.size = payload.getUINT32();
            obj.width = payload.getUINT16();
            obj.height = payload.getUINT16();
            obj.packets = payload.getUINT16();
            obj.type = payload.getUINT8();
            obj.payload = payload.getUINT8();
            obj.jpg_quality = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.size,2) ~= 1
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