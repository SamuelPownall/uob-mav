classdef msg_autopilot_version < MAVLinkMessage
	%MSG_AUTOPILOT_VERSION: MAVLink Message ID = 148
    %Description:
    %    Version and capability of autopilot software
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    capabilities(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,capabilities,uid,flight_sw_version,middleware_sw_version,os_sw_version,board_version,vendor_id,product_id,flight_custom_version,middleware_custom_version,os_custom_version,varargin)

            if nargin == 11 + 1
                msg = msg_autopilot_version(capabilities,uid,flight_sw_version,middleware_sw_version,os_sw_version,board_version,vendor_id,product_id,flight_custom_version,middleware_custom_version,os_custom_version,varargin);
            elseif nargin == 2
                msg = msg_autopilot_version(capabilities);
            else
                MAVLink.throwCustomError('The number of function arguments is not valid');
                return;
            end

            packet = msg.pack();
            if ~isempty(packet)
                buffer = packet.encode();
                write(out,buffer);
            else
                MAVLink.throwCustomError('The packet could not be verified');
            end
        
        end

    end

    methods

        function obj = msg_autopilot_version(capabilities,uid,flight_sw_version,middleware_sw_version,os_sw_version,board_version,vendor_id,product_id,flight_custom_version,middleware_custom_version,os_custom_version,varargin)
        %MSG_AUTOPILOT_VERSION: Create a new autopilot_version message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(capabilities,'MAVLinkPacket')
                    packet = capabilities;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('capabilities','MAVLinkPacket');
                end
            elseif nargin >= 11 && isempty(varargin{1})
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
                MAVLink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        function packet = pack(obj)
        %PACK: Packs this MAVLink message into a MAVLinkPacket
        %Description:
        %    Packs the fields of a message into a MAVLinkPacket which can be encoded
        %    for transmission.

            errorField = obj.verify();
            if errorField == 0

                packet = MAVLinkPacket(msg_autopilot_version.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
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
                MAVLink.throwPackingError(errorField);
            end

        end

        function unpack(obj, payload)
        %UNPACK: Unpacks a MAVLinkPayload into this MAVLink message
        %Description:
        %    Extracts the data from a MAVLinkPayload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(MAVLinkPayload): The payload to be unpacked into this MAVLink message

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
                MAVLink.throwTypeError('value','uint64');
            end
        end
        
        function set.uid(obj,value)
            if value == uint64(value)
                obj.uid = uint64(value);
            else
                MAVLink.throwTypeError('value','uint64');
            end
        end
        
        function set.flight_sw_version(obj,value)
            if value == uint32(value)
                obj.flight_sw_version = uint32(value);
            else
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.middleware_sw_version(obj,value)
            if value == uint32(value)
                obj.middleware_sw_version = uint32(value);
            else
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.os_sw_version(obj,value)
            if value == uint32(value)
                obj.os_sw_version = uint32(value);
            else
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.board_version(obj,value)
            if value == uint32(value)
                obj.board_version = uint32(value);
            else
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.vendor_id(obj,value)
            if value == uint16(value)
                obj.vendor_id = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.product_id(obj,value)
            if value == uint16(value)
                obj.product_id = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.flight_custom_version(obj,value)
            if value == uint8(value)
                obj.flight_custom_version = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.middleware_custom_version(obj,value)
            if value == uint8(value)
                obj.middleware_custom_version = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.os_custom_version(obj,value)
            if value == uint8(value)
                obj.os_custom_version = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end