classdef msg_hil_state_quaternion < mavlink_handle
	%MSG_HIL_STATE_QUATERNION(packet,time_usec,attitude_quaternion,rollspeed,pitchspeed,yawspeed,lat,lon,alt,vx,vy,vz,ind_airspeed,true_airspeed,xacc,yacc,zacc): MAVLINK Message ID = 115
    %Description:
    %    Sent from simulation to autopilot, avoids in contrast to HIL_STATE singularities. This packet is useful for high throughput applications such as hardware in the loop simulations.
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    time_usec(uint64): Timestamp (microseconds since UNIX epoch or microseconds since system boot)
    %    attitude_quaternion(single[4]): Vehicle attitude expressed as normalized quaternion in w, x, y, z order (with 1 0 0 0 being the null-rotation)
    %    rollspeed(single): Body frame roll / phi angular speed (rad/s)
    %    pitchspeed(single): Body frame pitch / theta angular speed (rad/s)
    %    yawspeed(single): Body frame yaw / psi angular speed (rad/s)
    %    lat(int32): Latitude, expressed as * 1E7
    %    lon(int32): Longitude, expressed as * 1E7
    %    alt(int32): Altitude in meters, expressed as * 1000 (millimeters)
    %    vx(int16): Ground X Speed (Latitude), expressed as m/s * 100
    %    vy(int16): Ground Y Speed (Longitude), expressed as m/s * 100
    %    vz(int16): Ground Z Speed (Altitude), expressed as m/s * 100
    %    ind_airspeed(uint16): Indicated airspeed, expressed as m/s * 100
    %    true_airspeed(uint16): True airspeed, expressed as m/s * 100
    %    xacc(int16): X acceleration (mg)
    %    yacc(int16): Y acceleration (mg)
    %    zacc(int16): Z acceleration (mg)
	
	properties(Constant)
		ID = 115
		LEN = 64
	end
	
	properties
        time_usec	%Timestamp (microseconds since UNIX epoch or microseconds since system boot)	|	(uint64)
        attitude_quaternion	%Vehicle attitude expressed as normalized quaternion in w, x, y, z order (with 1 0 0 0 being the null-rotation)	|	(single[4])
        rollspeed	%Body frame roll / phi angular speed (rad/s)	|	(single)
        pitchspeed	%Body frame pitch / theta angular speed (rad/s)	|	(single)
        yawspeed	%Body frame yaw / psi angular speed (rad/s)	|	(single)
        lat	%Latitude, expressed as * 1E7	|	(int32)
        lon	%Longitude, expressed as * 1E7	|	(int32)
        alt	%Altitude in meters, expressed as * 1000 (millimeters)	|	(int32)
        vx	%Ground X Speed (Latitude), expressed as m/s * 100	|	(int16)
        vy	%Ground Y Speed (Longitude), expressed as m/s * 100	|	(int16)
        vz	%Ground Z Speed (Altitude), expressed as m/s * 100	|	(int16)
        ind_airspeed	%Indicated airspeed, expressed as m/s * 100	|	(uint16)
        true_airspeed	%True airspeed, expressed as m/s * 100	|	(uint16)
        xacc	%X acceleration (mg)	|	(int16)
        yacc	%Y acceleration (mg)	|	(int16)
        zacc	%Z acceleration (mg)	|	(int16)
    end

    methods

        %Constructor: msg_hil_state_quaternion
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_hil_state_quaternion(packet,time_usec,attitude_quaternion,rollspeed,pitchspeed,yawspeed,lat,lon,alt,vx,vy,vz,ind_airspeed,true_airspeed,xacc,yacc,zacc)
        
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
            
            elseif nargin-1 == 16
                obj.time_usec = time_usec;
                obj.attitude_quaternion = attitude_quaternion;
                obj.rollspeed = rollspeed;
                obj.pitchspeed = pitchspeed;
                obj.yawspeed = yawspeed;
                obj.lat = lat;
                obj.lon = lon;
                obj.alt = alt;
                obj.vx = vx;
                obj.vy = vy;
                obj.vz = vz;
                obj.ind_airspeed = ind_airspeed;
                obj.true_airspeed = true_airspeed;
                obj.xacc = xacc;
                obj.yacc = yacc;
                obj.zacc = zacc;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_hil_state_quaternion.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_hil_state_quaternion.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                for i=1:1:4
                    packet.payload.putSINGLE(obj.attitude_quaternion(i));
                end
                packet.payload.putSINGLE(obj.rollspeed);
                packet.payload.putSINGLE(obj.pitchspeed);
                packet.payload.putSINGLE(obj.yawspeed);
                packet.payload.putINT32(obj.lat);
                packet.payload.putINT32(obj.lon);
                packet.payload.putINT32(obj.alt);
                packet.payload.putINT16(obj.vx);
                packet.payload.putINT16(obj.vy);
                packet.payload.putINT16(obj.vz);
                packet.payload.putUINT16(obj.ind_airspeed);
                packet.payload.putUINT16(obj.true_airspeed);
                packet.payload.putINT16(obj.xacc);
                packet.payload.putINT16(obj.yacc);
                packet.payload.putINT16(obj.zacc);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.time_usec = payload.getUINT64();
            for i=1:1:4
                obj.attitude_quaternion(i) = payload.getSINGLE();
            end
            obj.rollspeed = payload.getSINGLE();
            obj.pitchspeed = payload.getSINGLE();
            obj.yawspeed = payload.getSINGLE();
            obj.lat = payload.getINT32();
            obj.lon = payload.getINT32();
            obj.alt = payload.getINT32();
            obj.vx = payload.getINT16();
            obj.vy = payload.getINT16();
            obj.vz = payload.getINT16();
            obj.ind_airspeed = payload.getUINT16();
            obj.true_airspeed = payload.getUINT16();
            obj.xacc = payload.getINT16();
            obj.yacc = payload.getINT16();
            obj.zacc = payload.getINT16();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.attitude_quaternion,2) ~= 4
                result = 'attitude_quaternion';
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
            elseif size(obj.ind_airspeed,2) ~= 1
                result = 'ind_airspeed';
            elseif size(obj.true_airspeed,2) ~= 1
                result = 'true_airspeed';
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
        
        function set.attitude_quaternion(obj,value)
            obj.attitude_quaternion = single(value);
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
        
        function set.ind_airspeed(obj,value)
            if value == uint16(value)
                obj.ind_airspeed = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.true_airspeed(obj,value)
            if value == uint16(value)
                obj.true_airspeed = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
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