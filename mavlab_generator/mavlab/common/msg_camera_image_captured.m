classdef msg_camera_image_captured < mavlink_message
	%MSG_CAMERA_IMAGE_CAPTURED: MAVLINK Message ID = 263
    %Description:
    %    WIP: Information about a captured image
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    time_utc(mavlink_packet): Alternative way to construct a message using a mavlink_packet
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

    methods

        function obj = msg_camera_image_captured(time_utc,time_boot_ms,lat,lon,alt,relative_alt,q,camera_id,file_path,varargin)
        %MSG_CAMERA_IMAGE_CAPTURED: Create a new camera_image_captured message object
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1 
                if isa(time_utc,'mavlink_packet')
                    packet = time_utc;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('time_utc','mavlink_packet');
                end
            elseif nargin == 9
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

                packet = mavlink_packet(msg_camera_image_captured.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
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
                mavlink.throwTypeError('value','uint64');
            end
        end
        
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.lat(obj,value)
            if value == int32(value)
                obj.lat = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
        
        function set.lon(obj,value)
            if value == int32(value)
                obj.lon = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
        
        function set.alt(obj,value)
            if value == int32(value)
                obj.alt = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
        
        function set.relative_alt(obj,value)
            if value == int32(value)
                obj.relative_alt = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
        
        function set.q(obj,value)
            obj.q = single(value);
        end
        
        function set.camera_id(obj,value)
            if value == uint8(value)
                obj.camera_id = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.file_path(obj,value)
            if value == uint8(value)
                obj.file_path = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end