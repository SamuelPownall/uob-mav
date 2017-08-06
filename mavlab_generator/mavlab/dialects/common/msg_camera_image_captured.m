classdef msg_camera_image_captured < MAVLinkMessage
	%MSG_CAMERA_IMAGE_CAPTURED: MAVLink Message ID = 263
    %Description:
    %    WIP: Information about a captured image
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_utc(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    time_utc(uint64): Timestamp (microseconds since UNIX epoch) in UTC. 0 for unknown.
    %    time_boot_ms(uint32): Timestamp (milliseconds since system boot)
    %    lat(int32): Latitude, expressed as degrees * 1E7 where image was taken
    %    lon(int32): Longitude, expressed as degrees * 1E7 where capture was taken
    %    alt(int32): Altitude in meters, expressed as * 1E3 (AMSL, not WGS84) where image was taken
    %    relative_alt(int32): Altitude above ground in meters, expressed as * 1E3 where image was taken
    %    q(single[4]): Quaternion of camera orientation (w, x, y, z order, zero-rotation is 0, 0, 0, 0)
    %    camera_id(uint8): Camera ID if there are multiple
    %    file_path(uint8[127]): File path of image taken.
	
	properties(Constant)
		ID = 263
		LEN = 127
	end
	
	properties
        time_utc	%Timestamp (microseconds since UNIX epoch) in UTC. 0 for unknown.	|	(uint64)
        time_boot_ms	%Timestamp (milliseconds since system boot)	|	(uint32)
        lat	%Latitude, expressed as degrees * 1E7 where image was taken	|	(int32)
        lon	%Longitude, expressed as degrees * 1E7 where capture was taken	|	(int32)
        alt	%Altitude in meters, expressed as * 1E3 (AMSL, not WGS84) where image was taken	|	(int32)
        relative_alt	%Altitude above ground in meters, expressed as * 1E3 where image was taken	|	(int32)
        q	%Quaternion of camera orientation (w, x, y, z order, zero-rotation is 0, 0, 0, 0)	|	(single[4])
        camera_id	%Camera ID if there are multiple	|	(uint8)
        file_path	%File path of image taken.	|	(uint8[127])
    end

    methods(Static)

        function send(out,time_utc,time_boot_ms,lat,lon,alt,relative_alt,q,camera_id,file_path,varargin)

            if nargin == 9 + 1
                msg = msg_camera_image_captured(time_utc,time_boot_ms,lat,lon,alt,relative_alt,q,camera_id,file_path,varargin);
            elseif nargin == 2
                msg = msg_camera_image_captured(time_utc);
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

        function obj = msg_camera_image_captured(time_utc,time_boot_ms,lat,lon,alt,relative_alt,q,camera_id,file_path,varargin)
        %MSG_CAMERA_IMAGE_CAPTURED: Create a new camera_image_captured message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(time_utc,'MAVLinkPacket')
                    packet = time_utc;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('time_utc','MAVLinkPacket');
                end
            elseif nargin >= 9 && isempty(varargin{1})
                obj.time_utc = time_utc;
                obj.time_boot_ms = time_boot_ms;
                obj.lat = lat;
                obj.lon = lon;
                obj.alt = alt;
                obj.relative_alt = relative_alt;
                obj.q = q;
                obj.camera_id = camera_id;
                obj.file_path = file_path;
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

                packet = MAVLinkPacket(msg_camera_image_captured.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_camera_image_captured.ID;
                
                packet.payload.putUINT64(obj.time_utc);
                packet.payload.putUINT32(obj.time_boot_ms);
                packet.payload.putINT32(obj.lat);
                packet.payload.putINT32(obj.lon);
                packet.payload.putINT32(obj.alt);
                packet.payload.putINT32(obj.relative_alt);
                for i=1:1:4
                    packet.payload.putSINGLE(obj.q(i));
                end
                packet.payload.putUINT8(obj.camera_id);
                for i=1:1:127
                    packet.payload.putUINT8(obj.file_path(i));
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
            
            obj.time_utc = payload.getUINT64();
            obj.time_boot_ms = payload.getUINT32();
            obj.lat = payload.getINT32();
            obj.lon = payload.getINT32();
            obj.alt = payload.getINT32();
            obj.relative_alt = payload.getINT32();
            for i=1:1:4
                obj.q(i) = payload.getSINGLE();
            end
            obj.camera_id = payload.getUINT8();
            for i=1:1:127
                obj.file_path(i) = payload.getUINT8();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_utc,2) ~= 1
                result = 'time_utc';
            elseif size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';
            elseif size(obj.lat,2) ~= 1
                result = 'lat';
            elseif size(obj.lon,2) ~= 1
                result = 'lon';
            elseif size(obj.alt,2) ~= 1
                result = 'alt';
            elseif size(obj.relative_alt,2) ~= 1
                result = 'relative_alt';
            elseif size(obj.q,2) ~= 4
                result = 'q';
            elseif size(obj.camera_id,2) ~= 1
                result = 'camera_id';
            elseif size(obj.file_path,2) ~= 127
                result = 'file_path';

            else
                result = 0;
            end
        end

        function set.time_utc(obj,value)
            if value == uint64(value)
                obj.time_utc = uint64(value);
            else
                MAVLink.throwTypeError('value','uint64');
            end
        end
        
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.lat(obj,value)
            if value == int32(value)
                obj.lat = int32(value);
            else
                MAVLink.throwTypeError('value','int32');
            end
        end
        
        function set.lon(obj,value)
            if value == int32(value)
                obj.lon = int32(value);
            else
                MAVLink.throwTypeError('value','int32');
            end
        end
        
        function set.alt(obj,value)
            if value == int32(value)
                obj.alt = int32(value);
            else
                MAVLink.throwTypeError('value','int32');
            end
        end
        
        function set.relative_alt(obj,value)
            if value == int32(value)
                obj.relative_alt = int32(value);
            else
                MAVLink.throwTypeError('value','int32');
            end
        end
        
        function set.q(obj,value)
            obj.q = single(value);
        end
        
        function set.camera_id(obj,value)
            if value == uint8(value)
                obj.camera_id = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.file_path(obj,value)
            if value == uint8(value)
                obj.file_path = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end