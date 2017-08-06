classdef msg_global_position_int < MAVLinkMessage
	%MSG_GLOBAL_POSITION_INT: MAVLink Message ID = 33
    %Description:
    %    The filtered global position (e.g. fused GPS and accelerometers). The position is in GPS-frame (right-handed, Z-up). It
               is designed as scaled integer message since the resolution of float is not sufficient.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_boot_ms(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    time_boot_ms(uint32): Timestamp (milliseconds since system boot)
    %    lat(int32): Latitude, expressed as degrees * 1E7
    %    lon(int32): Longitude, expressed as degrees * 1E7
    %    alt(int32): Altitude in meters, expressed as * 1000 (millimeters), AMSL (not WGS84 - note that virtually all GPS modules provide the AMSL as well)
    %    relative_alt(int32): Altitude above ground in meters, expressed as * 1000 (millimeters)
    %    vx(int16): Ground X Speed (Latitude, positive north), expressed as m/s * 100
    %    vy(int16): Ground Y Speed (Longitude, positive east), expressed as m/s * 100
    %    vz(int16): Ground Z Speed (Altitude, positive down), expressed as m/s * 100
    %    hdg(uint16): Vehicle heading (yaw angle) in degrees * 100, 0.0..359.99 degrees. If unknown, set to: UINT16_MAX
	
	properties(Constant)
		ID = 33
		LEN = 28
	end
	
	properties
        time_boot_ms	%Timestamp (milliseconds since system boot)	|	(uint32)
        lat	%Latitude, expressed as degrees * 1E7	|	(int32)
        lon	%Longitude, expressed as degrees * 1E7	|	(int32)
        alt	%Altitude in meters, expressed as * 1000 (millimeters), AMSL (not WGS84 - note that virtually all GPS modules provide the AMSL as well)	|	(int32)
        relative_alt	%Altitude above ground in meters, expressed as * 1000 (millimeters)	|	(int32)
        vx	%Ground X Speed (Latitude, positive north), expressed as m/s * 100	|	(int16)
        vy	%Ground Y Speed (Longitude, positive east), expressed as m/s * 100	|	(int16)
        vz	%Ground Z Speed (Altitude, positive down), expressed as m/s * 100	|	(int16)
        hdg	%Vehicle heading (yaw angle) in degrees * 100, 0.0..359.99 degrees. If unknown, set to: UINT16_MAX	|	(uint16)
    end

    methods(Static)

        function send(out,time_boot_ms,lat,lon,alt,relative_alt,vx,vy,vz,hdg,varargin)

            if nargin == 9 + 1
                msg = msg_global_position_int(time_boot_ms,lat,lon,alt,relative_alt,vx,vy,vz,hdg,varargin);
            elseif nargin == 2
                msg = msg_global_position_int(time_boot_ms);
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

        function obj = msg_global_position_int(time_boot_ms,lat,lon,alt,relative_alt,vx,vy,vz,hdg,varargin)
        %MSG_GLOBAL_POSITION_INT: Create a new global_position_int message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(time_boot_ms,'MAVLinkPacket')
                    packet = time_boot_ms;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('time_boot_ms','MAVLinkPacket');
                end
            elseif nargin >= 9 && isempty(varargin{1})
                obj.time_boot_ms = time_boot_ms;
                obj.lat = lat;
                obj.lon = lon;
                obj.alt = alt;
                obj.relative_alt = relative_alt;
                obj.vx = vx;
                obj.vy = vy;
                obj.vz = vz;
                obj.hdg = hdg;
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

                packet = MAVLinkPacket(msg_global_position_int.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_global_position_int.ID;
                
                packet.payload.putUINT32(obj.time_boot_ms);
                packet.payload.putINT32(obj.lat);
                packet.payload.putINT32(obj.lon);
                packet.payload.putINT32(obj.alt);
                packet.payload.putINT32(obj.relative_alt);
                packet.payload.putINT16(obj.vx);
                packet.payload.putINT16(obj.vy);
                packet.payload.putINT16(obj.vz);
                packet.payload.putUINT16(obj.hdg);

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
            
            obj.time_boot_ms = payload.getUINT32();
            obj.lat = payload.getINT32();
            obj.lon = payload.getINT32();
            obj.alt = payload.getINT32();
            obj.relative_alt = payload.getINT32();
            obj.vx = payload.getINT16();
            obj.vy = payload.getINT16();
            obj.vz = payload.getINT16();
            obj.hdg = payload.getUINT16();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
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
            elseif size(obj.vx,2) ~= 1
                result = 'vx';
            elseif size(obj.vy,2) ~= 1
                result = 'vy';
            elseif size(obj.vz,2) ~= 1
                result = 'vz';
            elseif size(obj.hdg,2) ~= 1
                result = 'hdg';

            else
                result = 0;
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
        
        function set.vx(obj,value)
            if value == int16(value)
                obj.vx = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.vy(obj,value)
            if value == int16(value)
                obj.vy = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.vz(obj,value)
            if value == int16(value)
                obj.vz = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.hdg(obj,value)
            if value == uint16(value)
                obj.hdg = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
    end

end