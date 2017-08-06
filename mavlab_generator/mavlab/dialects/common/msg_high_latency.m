classdef msg_high_latency < MAVLinkMessage
	%MSG_HIGH_LATENCY: MAVLink Message ID = 234
    %Description:
    %    Message appropriate for high latency connections like Iridium
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    custom_mode(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    custom_mode(uint32): A bitfield for use for autopilot-specific flags.
    %    latitude(int32): Latitude, expressed as degrees * 1E7
    %    longitude(int32): Longitude, expressed as degrees * 1E7
    %    roll(int16): roll (centidegrees)
    %    pitch(int16): pitch (centidegrees)
    %    heading(uint16): heading (centidegrees)
    %    heading_sp(int16): heading setpoint (centidegrees)
    %    altitude_amsl(int16): Altitude above mean sea level (meters)
    %    altitude_sp(int16): Altitude setpoint relative to the home position (meters)
    %    wp_distance(uint16): distance to target (meters)
    %    base_mode(uint8): System mode bitfield, see MAV_MODE_FLAG ENUM in mavlink/include/mavlink_types.h
    %    landed_state(uint8): The landed state. Is set to MAV_LANDED_STATE_UNDEFINED if landed state is unknown.
    %    throttle(int8): throttle (percentage)
    %    airspeed(uint8): airspeed (m/s)
    %    airspeed_sp(uint8): airspeed setpoint (m/s)
    %    groundspeed(uint8): groundspeed (m/s)
    %    climb_rate(int8): climb rate (m/s)
    %    gps_nsat(uint8): Number of satellites visible. If unknown, set to 255
    %    gps_fix_type(uint8): See the GPS_FIX_TYPE enum.
    %    battery_remaining(uint8): Remaining battery (percentage)
    %    temperature(int8): Autopilot temperature (degrees C)
    %    temperature_air(int8): Air temperature (degrees C) from airspeed sensor
    %    failsafe(uint8): failsafe (each bit represents a failsafe where 0=ok, 1=failsafe active (bit0:RC, bit1:batt, bit2:GPS, bit3:GCS, bit4:fence)
    %    wp_num(uint8): current waypoint number
	
	properties(Constant)
		ID = 234
		LEN = 40
	end
	
	properties
        custom_mode	%A bitfield for use for autopilot-specific flags.	|	(uint32)
        latitude	%Latitude, expressed as degrees * 1E7	|	(int32)
        longitude	%Longitude, expressed as degrees * 1E7	|	(int32)
        roll	%roll (centidegrees)	|	(int16)
        pitch	%pitch (centidegrees)	|	(int16)
        heading	%heading (centidegrees)	|	(uint16)
        heading_sp	%heading setpoint (centidegrees)	|	(int16)
        altitude_amsl	%Altitude above mean sea level (meters)	|	(int16)
        altitude_sp	%Altitude setpoint relative to the home position (meters)	|	(int16)
        wp_distance	%distance to target (meters)	|	(uint16)
        base_mode	%System mode bitfield, see MAV_MODE_FLAG ENUM in mavlink/include/mavlink_types.h	|	(uint8)
        landed_state	%The landed state. Is set to MAV_LANDED_STATE_UNDEFINED if landed state is unknown.	|	(uint8)
        throttle	%throttle (percentage)	|	(int8)
        airspeed	%airspeed (m/s)	|	(uint8)
        airspeed_sp	%airspeed setpoint (m/s)	|	(uint8)
        groundspeed	%groundspeed (m/s)	|	(uint8)
        climb_rate	%climb rate (m/s)	|	(int8)
        gps_nsat	%Number of satellites visible. If unknown, set to 255	|	(uint8)
        gps_fix_type	%See the GPS_FIX_TYPE enum.	|	(uint8)
        battery_remaining	%Remaining battery (percentage)	|	(uint8)
        temperature	%Autopilot temperature (degrees C)	|	(int8)
        temperature_air	%Air temperature (degrees C) from airspeed sensor	|	(int8)
        failsafe	%failsafe (each bit represents a failsafe where 0=ok, 1=failsafe active (bit0:RC, bit1:batt, bit2:GPS, bit3:GCS, bit4:fence)	|	(uint8)
        wp_num	%current waypoint number	|	(uint8)
    end

    methods(Static)

        function send(out,custom_mode,latitude,longitude,roll,pitch,heading,heading_sp,altitude_amsl,altitude_sp,wp_distance,base_mode,landed_state,throttle,airspeed,airspeed_sp,groundspeed,climb_rate,gps_nsat,gps_fix_type,battery_remaining,temperature,temperature_air,failsafe,wp_num,varargin)

            if nargin == 24 + 1
                msg = msg_high_latency(custom_mode,latitude,longitude,roll,pitch,heading,heading_sp,altitude_amsl,altitude_sp,wp_distance,base_mode,landed_state,throttle,airspeed,airspeed_sp,groundspeed,climb_rate,gps_nsat,gps_fix_type,battery_remaining,temperature,temperature_air,failsafe,wp_num,varargin);
            elseif nargin == 2
                msg = msg_high_latency(custom_mode);
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

        function obj = msg_high_latency(custom_mode,latitude,longitude,roll,pitch,heading,heading_sp,altitude_amsl,altitude_sp,wp_distance,base_mode,landed_state,throttle,airspeed,airspeed_sp,groundspeed,climb_rate,gps_nsat,gps_fix_type,battery_remaining,temperature,temperature_air,failsafe,wp_num,varargin)
        %MSG_HIGH_LATENCY: Create a new high_latency message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(custom_mode,'MAVLinkPacket')
                    packet = custom_mode;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('custom_mode','MAVLinkPacket');
                end
            elseif nargin >= 24 && isempty(varargin{1})
                obj.custom_mode = custom_mode;
                obj.latitude = latitude;
                obj.longitude = longitude;
                obj.roll = roll;
                obj.pitch = pitch;
                obj.heading = heading;
                obj.heading_sp = heading_sp;
                obj.altitude_amsl = altitude_amsl;
                obj.altitude_sp = altitude_sp;
                obj.wp_distance = wp_distance;
                obj.base_mode = base_mode;
                obj.landed_state = landed_state;
                obj.throttle = throttle;
                obj.airspeed = airspeed;
                obj.airspeed_sp = airspeed_sp;
                obj.groundspeed = groundspeed;
                obj.climb_rate = climb_rate;
                obj.gps_nsat = gps_nsat;
                obj.gps_fix_type = gps_fix_type;
                obj.battery_remaining = battery_remaining;
                obj.temperature = temperature;
                obj.temperature_air = temperature_air;
                obj.failsafe = failsafe;
                obj.wp_num = wp_num;
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

                packet = MAVLinkPacket(msg_high_latency.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_high_latency.ID;
                
                packet.payload.putUINT32(obj.custom_mode);
                packet.payload.putINT32(obj.latitude);
                packet.payload.putINT32(obj.longitude);
                packet.payload.putINT16(obj.roll);
                packet.payload.putINT16(obj.pitch);
                packet.payload.putUINT16(obj.heading);
                packet.payload.putINT16(obj.heading_sp);
                packet.payload.putINT16(obj.altitude_amsl);
                packet.payload.putINT16(obj.altitude_sp);
                packet.payload.putUINT16(obj.wp_distance);
                packet.payload.putUINT8(obj.base_mode);
                packet.payload.putUINT8(obj.landed_state);
                packet.payload.putINT8(obj.throttle);
                packet.payload.putUINT8(obj.airspeed);
                packet.payload.putUINT8(obj.airspeed_sp);
                packet.payload.putUINT8(obj.groundspeed);
                packet.payload.putINT8(obj.climb_rate);
                packet.payload.putUINT8(obj.gps_nsat);
                packet.payload.putUINT8(obj.gps_fix_type);
                packet.payload.putUINT8(obj.battery_remaining);
                packet.payload.putINT8(obj.temperature);
                packet.payload.putINT8(obj.temperature_air);
                packet.payload.putUINT8(obj.failsafe);
                packet.payload.putUINT8(obj.wp_num);

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
            
            obj.custom_mode = payload.getUINT32();
            obj.latitude = payload.getINT32();
            obj.longitude = payload.getINT32();
            obj.roll = payload.getINT16();
            obj.pitch = payload.getINT16();
            obj.heading = payload.getUINT16();
            obj.heading_sp = payload.getINT16();
            obj.altitude_amsl = payload.getINT16();
            obj.altitude_sp = payload.getINT16();
            obj.wp_distance = payload.getUINT16();
            obj.base_mode = payload.getUINT8();
            obj.landed_state = payload.getUINT8();
            obj.throttle = payload.getINT8();
            obj.airspeed = payload.getUINT8();
            obj.airspeed_sp = payload.getUINT8();
            obj.groundspeed = payload.getUINT8();
            obj.climb_rate = payload.getINT8();
            obj.gps_nsat = payload.getUINT8();
            obj.gps_fix_type = payload.getUINT8();
            obj.battery_remaining = payload.getUINT8();
            obj.temperature = payload.getINT8();
            obj.temperature_air = payload.getINT8();
            obj.failsafe = payload.getUINT8();
            obj.wp_num = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.custom_mode,2) ~= 1
                result = 'custom_mode';
            elseif size(obj.latitude,2) ~= 1
                result = 'latitude';
            elseif size(obj.longitude,2) ~= 1
                result = 'longitude';
            elseif size(obj.roll,2) ~= 1
                result = 'roll';
            elseif size(obj.pitch,2) ~= 1
                result = 'pitch';
            elseif size(obj.heading,2) ~= 1
                result = 'heading';
            elseif size(obj.heading_sp,2) ~= 1
                result = 'heading_sp';
            elseif size(obj.altitude_amsl,2) ~= 1
                result = 'altitude_amsl';
            elseif size(obj.altitude_sp,2) ~= 1
                result = 'altitude_sp';
            elseif size(obj.wp_distance,2) ~= 1
                result = 'wp_distance';
            elseif size(obj.base_mode,2) ~= 1
                result = 'base_mode';
            elseif size(obj.landed_state,2) ~= 1
                result = 'landed_state';
            elseif size(obj.throttle,2) ~= 1
                result = 'throttle';
            elseif size(obj.airspeed,2) ~= 1
                result = 'airspeed';
            elseif size(obj.airspeed_sp,2) ~= 1
                result = 'airspeed_sp';
            elseif size(obj.groundspeed,2) ~= 1
                result = 'groundspeed';
            elseif size(obj.climb_rate,2) ~= 1
                result = 'climb_rate';
            elseif size(obj.gps_nsat,2) ~= 1
                result = 'gps_nsat';
            elseif size(obj.gps_fix_type,2) ~= 1
                result = 'gps_fix_type';
            elseif size(obj.battery_remaining,2) ~= 1
                result = 'battery_remaining';
            elseif size(obj.temperature,2) ~= 1
                result = 'temperature';
            elseif size(obj.temperature_air,2) ~= 1
                result = 'temperature_air';
            elseif size(obj.failsafe,2) ~= 1
                result = 'failsafe';
            elseif size(obj.wp_num,2) ~= 1
                result = 'wp_num';

            else
                result = 0;
            end
        end

        function set.custom_mode(obj,value)
            if value == uint32(value)
                obj.custom_mode = uint32(value);
            else
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.latitude(obj,value)
            if value == int32(value)
                obj.latitude = int32(value);
            else
                MAVLink.throwTypeError('value','int32');
            end
        end
        
        function set.longitude(obj,value)
            if value == int32(value)
                obj.longitude = int32(value);
            else
                MAVLink.throwTypeError('value','int32');
            end
        end
        
        function set.roll(obj,value)
            if value == int16(value)
                obj.roll = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.pitch(obj,value)
            if value == int16(value)
                obj.pitch = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.heading(obj,value)
            if value == uint16(value)
                obj.heading = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.heading_sp(obj,value)
            if value == int16(value)
                obj.heading_sp = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.altitude_amsl(obj,value)
            if value == int16(value)
                obj.altitude_amsl = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.altitude_sp(obj,value)
            if value == int16(value)
                obj.altitude_sp = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.wp_distance(obj,value)
            if value == uint16(value)
                obj.wp_distance = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.base_mode(obj,value)
            if value == uint8(value)
                obj.base_mode = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.landed_state(obj,value)
            if value == uint8(value)
                obj.landed_state = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.throttle(obj,value)
            if value == int8(value)
                obj.throttle = int8(value);
            else
                MAVLink.throwTypeError('value','int8');
            end
        end
        
        function set.airspeed(obj,value)
            if value == uint8(value)
                obj.airspeed = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.airspeed_sp(obj,value)
            if value == uint8(value)
                obj.airspeed_sp = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.groundspeed(obj,value)
            if value == uint8(value)
                obj.groundspeed = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.climb_rate(obj,value)
            if value == int8(value)
                obj.climb_rate = int8(value);
            else
                MAVLink.throwTypeError('value','int8');
            end
        end
        
        function set.gps_nsat(obj,value)
            if value == uint8(value)
                obj.gps_nsat = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.gps_fix_type(obj,value)
            if value == uint8(value)
                obj.gps_fix_type = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.battery_remaining(obj,value)
            if value == uint8(value)
                obj.battery_remaining = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.temperature(obj,value)
            if value == int8(value)
                obj.temperature = int8(value);
            else
                MAVLink.throwTypeError('value','int8');
            end
        end
        
        function set.temperature_air(obj,value)
            if value == int8(value)
                obj.temperature_air = int8(value);
            else
                MAVLink.throwTypeError('value','int8');
            end
        end
        
        function set.failsafe(obj,value)
            if value == uint8(value)
                obj.failsafe = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.wp_num(obj,value)
            if value == uint8(value)
                obj.wp_num = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end