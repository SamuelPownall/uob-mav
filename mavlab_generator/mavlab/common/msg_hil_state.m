classdef msg_hil_state < mavlink_message
	%MSG_HIL_STATE: MAVLINK Message ID = 90
    %Description:
    %    DEPRECATED PACKET! Suffers from missing airspeed fields and singularities due to Euler angles. Please use HIL_STATE_QUATERNION instead. Sent from simulation to autopilot. This packet is useful for high throughput applications such as hardware in the loop simulations.
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    time_usec(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    time_usec(uint64): Timestamp (microseconds since UNIX epoch or microseconds since system boot)
    %    roll(single): Roll angle (rad)
    %    pitch(single): Pitch angle (rad)
    %    yaw(single): Yaw angle (rad)
    %    rollspeed(single): Body frame roll / phi angular speed (rad/s)
    %    pitchspeed(single): Body frame pitch / theta angular speed (rad/s)
    %    yawspeed(single): Body frame yaw / psi angular speed (rad/s)
    %    lat(int32): Latitude, expressed as * 1E7
    %    lon(int32): Longitude, expressed as * 1E7
    %    alt(int32): Altitude in meters, expressed as * 1000 (millimeters)
    %    vx(int16): Ground X Speed (Latitude), expressed as m/s * 100
    %    vy(int16): Ground Y Speed (Longitude), expressed as m/s * 100
    %    vz(int16): Ground Z Speed (Altitude), expressed as m/s * 100
    %    xacc(int16): X acceleration (mg)
    %    yacc(int16): Y acceleration (mg)
    %    zacc(int16): Z acceleration (mg)
	
	properties(Constant)
		ID = 90
		LEN = 56
	end
	
	properties
        time_usec	%Timestamp (microseconds since UNIX epoch or microseconds since system boot)	|	(uint64)
        roll	%Roll angle (rad)	|	(single)
        pitch	%Pitch angle (rad)	|	(single)
        yaw	%Yaw angle (rad)	|	(single)
        rollspeed	%Body frame roll / phi angular speed (rad/s)	|	(single)
        pitchspeed	%Body frame pitch / theta angular speed (rad/s)	|	(single)
        yawspeed	%Body frame yaw / psi angular speed (rad/s)	|	(single)
        lat	%Latitude, expressed as * 1E7	|	(int32)
        lon	%Longitude, expressed as * 1E7	|	(int32)
        alt	%Altitude in meters, expressed as * 1000 (millimeters)	|	(int32)
        vx	%Ground X Speed (Latitude), expressed as m/s * 100	|	(int16)
        vy	%Ground Y Speed (Longitude), expressed as m/s * 100	|	(int16)
        vz	%Ground Z Speed (Altitude), expressed as m/s * 100	|	(int16)
        xacc	%X acceleration (mg)	|	(int16)
        yacc	%Y acceleration (mg)	|	(int16)
        zacc	%Z acceleration (mg)	|	(int16)
    end

    methods

        function obj = msg_hil_state(time_usec,roll,pitch,yaw,rollspeed,pitchspeed,yawspeed,lat,lon,alt,vx,vy,vz,xacc,yacc,zacc,varargin)
        %MSG_HIL_STATE: Create a new hil_state message object
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1 
                if isa(time_usec,'mavlink_packet')
                    packet = time_usec;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('time_usec','mavlink_packet');
                end
            elseif nargin == 16
                obj.time_usec = time_usec;
                obj.roll = roll;
                obj.pitch = pitch;
                obj.yaw = yaw;
                obj.rollspeed = rollspeed;
                obj.pitchspeed = pitchspeed;
                obj.yawspeed = yawspeed;
                obj.lat = lat;
                obj.lon = lon;
                obj.alt = alt;
                obj.vx = vx;
                obj.vy = vy;
                obj.vz = vz;
                obj.xacc = xacc;
                obj.yacc = yacc;
                obj.zacc = zacc;
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

                packet = mavlink_packet(msg_hil_state.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_hil_state.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                packet.payload.putSINGLE(obj.roll);
                packet.payload.putSINGLE(obj.pitch);
                packet.payload.putSINGLE(obj.yaw);
                packet.payload.putSINGLE(obj.rollspeed);
                packet.payload.putSINGLE(obj.pitchspeed);
                packet.payload.putSINGLE(obj.yawspeed);
                packet.payload.putINT32(obj.lat);
                packet.payload.putINT32(obj.lon);
                packet.payload.putINT32(obj.alt);
                packet.payload.putINT16(obj.vx);
                packet.payload.putINT16(obj.vy);
                packet.payload.putINT16(obj.vz);
                packet.payload.putINT16(obj.xacc);
                packet.payload.putINT16(obj.yacc);
                packet.payload.putINT16(obj.zacc);

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
            
            obj.time_usec = payload.getUINT64();
            obj.roll = payload.getSINGLE();
            obj.pitch = payload.getSINGLE();
            obj.yaw = payload.getSINGLE();
            obj.rollspeed = payload.getSINGLE();
            obj.pitchspeed = payload.getSINGLE();
            obj.yawspeed = payload.getSINGLE();
            obj.lat = payload.getINT32();
            obj.lon = payload.getINT32();
            obj.alt = payload.getINT32();
            obj.vx = payload.getINT16();
            obj.vy = payload.getINT16();
            obj.vz = payload.getINT16();
            obj.xacc = payload.getINT16();
            obj.yacc = payload.getINT16();
            obj.zacc = payload.getINT16();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.roll,2) ~= 1
                result = 'roll';
            elseif size(obj.pitch,2) ~= 1
                result = 'pitch';
            elseif size(obj.yaw,2) ~= 1
                result = 'yaw';
            elseif size(obj.rollspeed,2) ~= 1
                result = 'rollspeed';
            elseif size(obj.pitchspeed,2) ~= 1
                result = 'pitchspeed';
            elseif size(obj.yawspeed,2) ~= 1
                result = 'yawspeed';
            elseif size(obj.lat,2) ~= 1
                result = 'lat';
            elseif size(obj.lon,2) ~= 1
                result = 'lon';
            elseif size(obj.alt,2) ~= 1
                result = 'alt';
            elseif size(obj.vx,2) ~= 1
                result = 'vx';
            elseif size(obj.vy,2) ~= 1
                result = 'vy';
            elseif size(obj.vz,2) ~= 1
                result = 'vz';
            elseif size(obj.xacc,2) ~= 1
                result = 'xacc';
            elseif size(obj.yacc,2) ~= 1
                result = 'yacc';
            elseif size(obj.zacc,2) ~= 1
                result = 'zacc';

            else
                result = 0;
            end
        end

        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                mavlink.throwTypeError('value','uint64');
            end
        end
        
        function set.roll(obj,value)
            obj.roll = single(value);
        end
        
        function set.pitch(obj,value)
            obj.pitch = single(value);
        end
        
        function set.yaw(obj,value)
            obj.yaw = single(value);
        end
        
        function set.rollspeed(obj,value)
            obj.rollspeed = single(value);
        end
        
        function set.pitchspeed(obj,value)
            obj.pitchspeed = single(value);
        end
        
        function set.yawspeed(obj,value)
            obj.yawspeed = single(value);
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
        
        function set.vx(obj,value)
            if value == int16(value)
                obj.vx = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.vy(obj,value)
            if value == int16(value)
                obj.vy = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.vz(obj,value)
            if value == int16(value)
                obj.vz = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.xacc(obj,value)
            if value == int16(value)
                obj.xacc = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.yacc(obj,value)
            if value == int16(value)
                obj.yacc = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.zacc(obj,value)
            if value == int16(value)
                obj.zacc = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
    end

end