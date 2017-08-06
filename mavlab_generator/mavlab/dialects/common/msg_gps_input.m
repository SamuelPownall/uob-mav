classdef msg_gps_input < MAVLinkMessage
	%MSG_GPS_INPUT: MAVLink Message ID = 232
    %Description:
    %    GPS sensor input message.  This is a raw sensor value sent by the GPS. This is NOT the global position estimate of the sytem.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_usec(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    time_usec(uint64): Timestamp (micros since boot or Unix epoch)
    %    time_week_ms(uint32): GPS time (milliseconds from start of GPS week)
    %    lat(int32): Latitude (WGS84), in degrees * 1E7
    %    lon(int32): Longitude (WGS84), in degrees * 1E7
    %    alt(single): Altitude (AMSL, not WGS84), in m (positive for up)
    %    hdop(single): GPS HDOP horizontal dilution of position in m
    %    vdop(single): GPS VDOP vertical dilution of position in m
    %    vn(single): GPS velocity in m/s in NORTH direction in earth-fixed NED frame
    %    ve(single): GPS velocity in m/s in EAST direction in earth-fixed NED frame
    %    vd(single): GPS velocity in m/s in DOWN direction in earth-fixed NED frame
    %    speed_accuracy(single): GPS speed accuracy in m/s
    %    horiz_accuracy(single): GPS horizontal accuracy in m
    %    vert_accuracy(single): GPS vertical accuracy in m
    %    ignore_flags(uint16): Flags indicating which fields to ignore (see GPS_INPUT_IGNORE_FLAGS enum).  All other fields must be provided.
    %    time_week(uint16): GPS week number
    %    gps_id(uint8): ID of the GPS for multiple GPS inputs
    %    fix_type(uint8): 0-1: no fix, 2: 2D fix, 3: 3D fix. 4: 3D with DGPS. 5: 3D with RTK
    %    satellites_visible(uint8): Number of satellites visible.
	
	properties(Constant)
		ID = 232
		LEN = 63
	end
	
	properties
        time_usec	%Timestamp (micros since boot or Unix epoch)	|	(uint64)
        time_week_ms	%GPS time (milliseconds from start of GPS week)	|	(uint32)
        lat	%Latitude (WGS84), in degrees * 1E7	|	(int32)
        lon	%Longitude (WGS84), in degrees * 1E7	|	(int32)
        alt	%Altitude (AMSL, not WGS84), in m (positive for up)	|	(single)
        hdop	%GPS HDOP horizontal dilution of position in m	|	(single)
        vdop	%GPS VDOP vertical dilution of position in m	|	(single)
        vn	%GPS velocity in m/s in NORTH direction in earth-fixed NED frame	|	(single)
        ve	%GPS velocity in m/s in EAST direction in earth-fixed NED frame	|	(single)
        vd	%GPS velocity in m/s in DOWN direction in earth-fixed NED frame	|	(single)
        speed_accuracy	%GPS speed accuracy in m/s	|	(single)
        horiz_accuracy	%GPS horizontal accuracy in m	|	(single)
        vert_accuracy	%GPS vertical accuracy in m	|	(single)
        ignore_flags	%Flags indicating which fields to ignore (see GPS_INPUT_IGNORE_FLAGS enum).  All other fields must be provided.	|	(uint16)
        time_week	%GPS week number	|	(uint16)
        gps_id	%ID of the GPS for multiple GPS inputs	|	(uint8)
        fix_type	%0-1: no fix, 2: 2D fix, 3: 3D fix. 4: 3D with DGPS. 5: 3D with RTK	|	(uint8)
        satellites_visible	%Number of satellites visible.	|	(uint8)
    end

    methods(Static)

        function send(out,time_usec,time_week_ms,lat,lon,alt,hdop,vdop,vn,ve,vd,speed_accuracy,horiz_accuracy,vert_accuracy,ignore_flags,time_week,gps_id,fix_type,satellites_visible,varargin)

            if nargin == 18 + 1
                msg = msg_gps_input(time_usec,time_week_ms,lat,lon,alt,hdop,vdop,vn,ve,vd,speed_accuracy,horiz_accuracy,vert_accuracy,ignore_flags,time_week,gps_id,fix_type,satellites_visible,varargin);
            elseif nargin == 2
                msg = msg_gps_input(time_usec);
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

        function obj = msg_gps_input(time_usec,time_week_ms,lat,lon,alt,hdop,vdop,vn,ve,vd,speed_accuracy,horiz_accuracy,vert_accuracy,ignore_flags,time_week,gps_id,fix_type,satellites_visible,varargin)
        %MSG_GPS_INPUT: Create a new gps_input message object
        
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
            elseif nargin >= 18 && isempty(varargin{1})
                obj.time_usec = time_usec;
                obj.time_week_ms = time_week_ms;
                obj.lat = lat;
                obj.lon = lon;
                obj.alt = alt;
                obj.hdop = hdop;
                obj.vdop = vdop;
                obj.vn = vn;
                obj.ve = ve;
                obj.vd = vd;
                obj.speed_accuracy = speed_accuracy;
                obj.horiz_accuracy = horiz_accuracy;
                obj.vert_accuracy = vert_accuracy;
                obj.ignore_flags = ignore_flags;
                obj.time_week = time_week;
                obj.gps_id = gps_id;
                obj.fix_type = fix_type;
                obj.satellites_visible = satellites_visible;
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

                packet = MAVLinkPacket(msg_gps_input.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_gps_input.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                packet.payload.putUINT32(obj.time_week_ms);
                packet.payload.putINT32(obj.lat);
                packet.payload.putINT32(obj.lon);
                packet.payload.putSINGLE(obj.alt);
                packet.payload.putSINGLE(obj.hdop);
                packet.payload.putSINGLE(obj.vdop);
                packet.payload.putSINGLE(obj.vn);
                packet.payload.putSINGLE(obj.ve);
                packet.payload.putSINGLE(obj.vd);
                packet.payload.putSINGLE(obj.speed_accuracy);
                packet.payload.putSINGLE(obj.horiz_accuracy);
                packet.payload.putSINGLE(obj.vert_accuracy);
                packet.payload.putUINT16(obj.ignore_flags);
                packet.payload.putUINT16(obj.time_week);
                packet.payload.putUINT8(obj.gps_id);
                packet.payload.putUINT8(obj.fix_type);
                packet.payload.putUINT8(obj.satellites_visible);

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
            obj.time_week_ms = payload.getUINT32();
            obj.lat = payload.getINT32();
            obj.lon = payload.getINT32();
            obj.alt = payload.getSINGLE();
            obj.hdop = payload.getSINGLE();
            obj.vdop = payload.getSINGLE();
            obj.vn = payload.getSINGLE();
            obj.ve = payload.getSINGLE();
            obj.vd = payload.getSINGLE();
            obj.speed_accuracy = payload.getSINGLE();
            obj.horiz_accuracy = payload.getSINGLE();
            obj.vert_accuracy = payload.getSINGLE();
            obj.ignore_flags = payload.getUINT16();
            obj.time_week = payload.getUINT16();
            obj.gps_id = payload.getUINT8();
            obj.fix_type = payload.getUINT8();
            obj.satellites_visible = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.time_week_ms,2) ~= 1
                result = 'time_week_ms';
            elseif size(obj.lat,2) ~= 1
                result = 'lat';
            elseif size(obj.lon,2) ~= 1
                result = 'lon';
            elseif size(obj.alt,2) ~= 1
                result = 'alt';
            elseif size(obj.hdop,2) ~= 1
                result = 'hdop';
            elseif size(obj.vdop,2) ~= 1
                result = 'vdop';
            elseif size(obj.vn,2) ~= 1
                result = 'vn';
            elseif size(obj.ve,2) ~= 1
                result = 've';
            elseif size(obj.vd,2) ~= 1
                result = 'vd';
            elseif size(obj.speed_accuracy,2) ~= 1
                result = 'speed_accuracy';
            elseif size(obj.horiz_accuracy,2) ~= 1
                result = 'horiz_accuracy';
            elseif size(obj.vert_accuracy,2) ~= 1
                result = 'vert_accuracy';
            elseif size(obj.ignore_flags,2) ~= 1
                result = 'ignore_flags';
            elseif size(obj.time_week,2) ~= 1
                result = 'time_week';
            elseif size(obj.gps_id,2) ~= 1
                result = 'gps_id';
            elseif size(obj.fix_type,2) ~= 1
                result = 'fix_type';
            elseif size(obj.satellites_visible,2) ~= 1
                result = 'satellites_visible';

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
        
        function set.time_week_ms(obj,value)
            if value == uint32(value)
                obj.time_week_ms = uint32(value);
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
            obj.alt = single(value);
        end
        
        function set.hdop(obj,value)
            obj.hdop = single(value);
        end
        
        function set.vdop(obj,value)
            obj.vdop = single(value);
        end
        
        function set.vn(obj,value)
            obj.vn = single(value);
        end
        
        function set.ve(obj,value)
            obj.ve = single(value);
        end
        
        function set.vd(obj,value)
            obj.vd = single(value);
        end
        
        function set.speed_accuracy(obj,value)
            obj.speed_accuracy = single(value);
        end
        
        function set.horiz_accuracy(obj,value)
            obj.horiz_accuracy = single(value);
        end
        
        function set.vert_accuracy(obj,value)
            obj.vert_accuracy = single(value);
        end
        
        function set.ignore_flags(obj,value)
            if value == uint16(value)
                obj.ignore_flags = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.time_week(obj,value)
            if value == uint16(value)
                obj.time_week = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.gps_id(obj,value)
            if value == uint8(value)
                obj.gps_id = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
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
        
    end

end