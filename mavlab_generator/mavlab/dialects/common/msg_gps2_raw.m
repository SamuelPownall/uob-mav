classdef msg_gps2_raw < MAVLinkMessage
	%MSG_GPS2_RAW: MAVLink Message ID = 124
    %Description:
    %    Second GPS data. Coordinate frame is right-handed, Z-axis up (GPS frame).
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_usec(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    time_usec(uint64): Timestamp (microseconds since UNIX epoch or microseconds since system boot)
    %    lat(int32): Latitude (WGS84), in degrees * 1E7
    %    lon(int32): Longitude (WGS84), in degrees * 1E7
    %    alt(int32): Altitude (AMSL, not WGS84), in meters * 1000 (positive for up)
    %    dgps_age(uint32): Age of DGPS info
    %    eph(uint16): GPS HDOP horizontal dilution of position in cm (m*100). If unknown, set to: UINT16_MAX
    %    epv(uint16): GPS VDOP vertical dilution of position in cm (m*100). If unknown, set to: UINT16_MAX
    %    vel(uint16): GPS ground speed (m/s * 100). If unknown, set to: UINT16_MAX
    %    cog(uint16): Course over ground (NOT heading, but direction of movement) in degrees * 100, 0.0..359.99 degrees. If unknown, set to: UINT16_MAX
    %    fix_type(uint8): See the GPS_FIX_TYPE enum.
    %    satellites_visible(uint8): Number of satellites visible. If unknown, set to 255
    %    dgps_numch(uint8): Number of DGPS satellites
	
	properties(Constant)
		ID = 124
		LEN = 35
	end
	
	properties
        time_usec	%Timestamp (microseconds since UNIX epoch or microseconds since system boot)	|	(uint64)
        lat	%Latitude (WGS84), in degrees * 1E7	|	(int32)
        lon	%Longitude (WGS84), in degrees * 1E7	|	(int32)
        alt	%Altitude (AMSL, not WGS84), in meters * 1000 (positive for up)	|	(int32)
        dgps_age	%Age of DGPS info	|	(uint32)
        eph	%GPS HDOP horizontal dilution of position in cm (m*100). If unknown, set to: UINT16_MAX	|	(uint16)
        epv	%GPS VDOP vertical dilution of position in cm (m*100). If unknown, set to: UINT16_MAX	|	(uint16)
        vel	%GPS ground speed (m/s * 100). If unknown, set to: UINT16_MAX	|	(uint16)
        cog	%Course over ground (NOT heading, but direction of movement) in degrees * 100, 0.0..359.99 degrees. If unknown, set to: UINT16_MAX	|	(uint16)
        fix_type	%See the GPS_FIX_TYPE enum.	|	(uint8)
        satellites_visible	%Number of satellites visible. If unknown, set to 255	|	(uint8)
        dgps_numch	%Number of DGPS satellites	|	(uint8)
    end

    methods(Static)

        function send(out,time_usec,lat,lon,alt,dgps_age,eph,epv,vel,cog,fix_type,satellites_visible,dgps_numch,varargin)

            if nargin == 12 + 1
                msg = msg_gps2_raw(time_usec,lat,lon,alt,dgps_age,eph,epv,vel,cog,fix_type,satellites_visible,dgps_numch,varargin);
            elseif nargin == 2
                msg = msg_gps2_raw(time_usec);
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

        function obj = msg_gps2_raw(time_usec,lat,lon,alt,dgps_age,eph,epv,vel,cog,fix_type,satellites_visible,dgps_numch,varargin)
        %MSG_GPS2_RAW: Create a new gps2_raw message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(time_usec,'MAVLinkPacket')
                    packet = time_usec;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('time_usec','MAVLinkPacket');
                end
            elseif nargin >= 12 && isempty(varargin{1})
                obj.time_usec = time_usec;
                obj.lat = lat;
                obj.lon = lon;
                obj.alt = alt;
                obj.dgps_age = dgps_age;
                obj.eph = eph;
                obj.epv = epv;
                obj.vel = vel;
                obj.cog = cog;
                obj.fix_type = fix_type;
                obj.satellites_visible = satellites_visible;
                obj.dgps_numch = dgps_numch;
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

                packet = MAVLinkPacket(msg_gps2_raw.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_gps2_raw.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                packet.payload.putINT32(obj.lat);
                packet.payload.putINT32(obj.lon);
                packet.payload.putINT32(obj.alt);
                packet.payload.putUINT32(obj.dgps_age);
                packet.payload.putUINT16(obj.eph);
                packet.payload.putUINT16(obj.epv);
                packet.payload.putUINT16(obj.vel);
                packet.payload.putUINT16(obj.cog);
                packet.payload.putUINT8(obj.fix_type);
                packet.payload.putUINT8(obj.satellites_visible);
                packet.payload.putUINT8(obj.dgps_numch);

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
            
            obj.time_usec = payload.getUINT64();
            obj.lat = payload.getINT32();
            obj.lon = payload.getINT32();
            obj.alt = payload.getINT32();
            obj.dgps_age = payload.getUINT32();
            obj.eph = payload.getUINT16();
            obj.epv = payload.getUINT16();
            obj.vel = payload.getUINT16();
            obj.cog = payload.getUINT16();
            obj.fix_type = payload.getUINT8();
            obj.satellites_visible = payload.getUINT8();
            obj.dgps_numch = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.lat,2) ~= 1
                result = 'lat';
            elseif size(obj.lon,2) ~= 1
                result = 'lon';
            elseif size(obj.alt,2) ~= 1
                result = 'alt';
            elseif size(obj.dgps_age,2) ~= 1
                result = 'dgps_age';
            elseif size(obj.eph,2) ~= 1
                result = 'eph';
            elseif size(obj.epv,2) ~= 1
                result = 'epv';
            elseif size(obj.vel,2) ~= 1
                result = 'vel';
            elseif size(obj.cog,2) ~= 1
                result = 'cog';
            elseif size(obj.fix_type,2) ~= 1
                result = 'fix_type';
            elseif size(obj.satellites_visible,2) ~= 1
                result = 'satellites_visible';
            elseif size(obj.dgps_numch,2) ~= 1
                result = 'dgps_numch';

            else
                result = 0;
            end
        end

        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                MAVLink.throwTypeError('value','uint64');
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
        
        function set.dgps_age(obj,value)
            if value == uint32(value)
                obj.dgps_age = uint32(value);
            else
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.eph(obj,value)
            if value == uint16(value)
                obj.eph = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.epv(obj,value)
            if value == uint16(value)
                obj.epv = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.vel(obj,value)
            if value == uint16(value)
                obj.vel = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.cog(obj,value)
            if value == uint16(value)
                obj.cog = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.fix_type(obj,value)
            if value == uint8(value)
                obj.fix_type = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.satellites_visible(obj,value)
            if value == uint8(value)
                obj.satellites_visible = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.dgps_numch(obj,value)
            if value == uint8(value)
                obj.dgps_numch = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end