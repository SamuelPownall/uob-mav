classdef msg_autopilot_version < mavlink_message
	%MSG_AUTOPILOT_VERSION: MAVLINK Message ID = 148
    %Description:
    %    Version and capability of autopilot software
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
    %    capabilities(uint64): bitmask of capabilities (see MAV_PROTOCOL_CAPABILITY enum)
    %    uid(uint64): UID if provided by hardware
    %    flight_sw_version(uint32): Firmware version number
    %    middleware_sw_version(uint32): Middleware version number
    %    os_sw_version(uint32): Operating system version number
    %    board_version(uint32): HW / board version (last 8 bytes should be silicon ID, if any)
    %    vendor_id(uint16): ID of the board vendor
    %    product_id(uint16): ID of the product
    %    flight_custom_version(uint8[8]): Custom version field, commonly the first 8 bytes of the git hash. This is not an unique identifier, but should allow to identify the commit using the main version number even for very large code bases.
    %    middleware_custom_version(uint8[8]): Custom version field, commonly the first 8 bytes of the git hash. This is not an unique identifier, but should allow to identify the commit using the main version number even for very large code bases.
    %    os_custom_version(uint8[8]): Custom version field, commonly the first 8 bytes of the git hash. This is not an unique identifier, but should allow to identify the commit using the main version number even for very large code bases.
	
	properties(Constant)
		ID = 148
		LEN = 60
	end
	
	properties
        capabilities	%bitmask of capabilities (see MAV_PROTOCOL_CAPABILITY enum)	|	(uint64)
        uid	%UID if provided by hardware	|	(uint64)
        flight_sw_version	%Firmware version number	|	(uint32)
        middleware_sw_version	%Middleware version number	|	(uint32)
        os_sw_version	%Operating system version number	|	(uint32)
        board_version	%HW / board version (last 8 bytes should be silicon ID, if any)	|	(uint32)
        vendor_id	%ID of the board vendor	|	(uint16)
        product_id	%ID of the product	|	(uint16)
        flight_custom_version	%Custom version field, commonly the first 8 bytes of the git hash. This is not an unique identifier, but should allow to identify the commit using the main version number even for very large code bases.	|	(uint8[8])
        middleware_custom_version	%Custom version field, commonly the first 8 bytes of the git hash. This is not an unique identifier, but should allow to identify the commit using the main version number even for very large code bases.	|	(uint8[8])
        os_custom_version	%Custom version field, commonly the first 8 bytes of the git hash. This is not an unique identifier, but should allow to identify the commit using the main version number even for very large code bases.	|	(uint8[8])
    end

    methods

        function obj = msg_autopilot_version(packet,capabilities,uid,flight_sw_version,middleware_sw_version,os_sw_version,board_version,vendor_id,product_id,flight_custom_version,middleware_custom_version,os_custom_version)
        %Create a new autopilot_version message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(packet,'mavlink_packet')
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('packet','mavlink_packet');
                end
            
            elseif nargin-1 == 11
                obj.capabilities = capabilities;
                obj.uid = uid;
                obj.flight_sw_version = flight_sw_version;
                obj.middleware_sw_version = middleware_sw_version;
                obj.os_sw_version = os_sw_version;
                obj.board_version = board_version;
                obj.vendor_id = vendor_id;
                obj.product_id = product_id;
                obj.flight_custom_version = flight_custom_version;
                obj.middleware_custom_version = middleware_custom_version;
                obj.os_custom_version = os_custom_version;
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

                packet = mavlink_packet(msg_autopilot_version.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_autopilot_version.ID;
                
                packet.payload.putUINT64(obj.capabilities);
                packet.payload.putUINT64(obj.uid);
                packet.payload.putUINT32(obj.flight_sw_version);
                packet.payload.putUINT32(obj.middleware_sw_version);
                packet.payload.putUINT32(obj.os_sw_version);
                packet.payload.putUINT32(obj.board_version);
                packet.payload.putUINT16(obj.vendor_id);
                packet.payload.putUINT16(obj.product_id);
                for i=1:1:8
                    packet.payload.putUINT8(obj.flight_custom_version(i));
                end
                for i=1:1:8
                    packet.payload.putUINT8(obj.middleware_custom_version(i));
                end
                for i=1:1:8
                    packet.payload.putUINT8(obj.os_custom_version(i));
                end

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
            
            obj.capabilities = payload.getUINT64();
            obj.uid = payload.getUINT64();
            obj.flight_sw_version = payload.getUINT32();
            obj.middleware_sw_version = payload.getUINT32();
            obj.os_sw_version = payload.getUINT32();
            obj.board_version = payload.getUINT32();
            obj.vendor_id = payload.getUINT16();
            obj.product_id = payload.getUINT16();
            for i=1:1:8
                obj.flight_custom_version(i) = payload.getUINT8();
            end
            for i=1:1:8
                obj.middleware_custom_version(i) = payload.getUINT8();
            end
            for i=1:1:8
                obj.os_custom_version(i) = payload.getUINT8();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.capabilities,2) ~= 1
                result = 'capabilities';
            elseif size(obj.uid,2) ~= 1
                result = 'uid';
            elseif size(obj.flight_sw_version,2) ~= 1
                result = 'flight_sw_version';
            elseif size(obj.middleware_sw_version,2) ~= 1
                result = 'middleware_sw_version';
            elseif size(obj.os_sw_version,2) ~= 1
                result = 'os_sw_version';
            elseif size(obj.board_version,2) ~= 1
                result = 'board_version';
            elseif size(obj.vendor_id,2) ~= 1
                result = 'vendor_id';
            elseif size(obj.product_id,2) ~= 1
                result = 'product_id';
            elseif size(obj.flight_custom_version,2) ~= 8
                result = 'flight_custom_version';
            elseif size(obj.middleware_custom_version,2) ~= 8
                result = 'middleware_custom_version';
            elseif size(obj.os_custom_version,2) ~= 8
                result = 'os_custom_version';

            else
                result = 0;
            end
        end

        function set.capabilities(obj,value)
            if value == uint64(value)
                obj.capabilities = uint64(value);
            else
                mavlink.throwTypeError('value','uint64');
            end
        end
        
        function set.uid(obj,value)
            if value == uint64(value)
                obj.uid = uint64(value);
            else
                mavlink.throwTypeError('value','uint64');
            end
        end
        
        function set.flight_sw_version(obj,value)
            if value == uint32(value)
                obj.flight_sw_version = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.middleware_sw_version(obj,value)
            if value == uint32(value)
                obj.middleware_sw_version = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.os_sw_version(obj,value)
            if value == uint32(value)
                obj.os_sw_version = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.board_version(obj,value)
            if value == uint32(value)
                obj.board_version = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.vendor_id(obj,value)
            if value == uint16(value)
                obj.vendor_id = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.product_id(obj,value)
            if value == uint16(value)
                obj.product_id = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.flight_custom_version(obj,value)
            if value == uint8(value)
                obj.flight_custom_version = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.middleware_custom_version(obj,value)
            if value == uint8(value)
                obj.middleware_custom_version = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.os_custom_version(obj,value)
            if value == uint8(value)
                obj.os_custom_version = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end