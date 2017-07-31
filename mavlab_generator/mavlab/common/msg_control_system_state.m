classdef msg_control_system_state < mavlink_message
	%MSG_CONTROL_SYSTEM_STATE: MAVLINK Message ID = 146
    %Description:
    %    The smoothed, monotonic system state used to feed the control loops of the system.
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    time_usec(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    time_usec(uint64): Timestamp (micros since boot or Unix epoch)
    %    x_acc(single): X acceleration in body frame
    %    y_acc(single): Y acceleration in body frame
    %    z_acc(single): Z acceleration in body frame
    %    x_vel(single): X velocity in body frame
    %    y_vel(single): Y velocity in body frame
    %    z_vel(single): Z velocity in body frame
    %    x_pos(single): X position in local frame
    %    y_pos(single): Y position in local frame
    %    z_pos(single): Z position in local frame
    %    airspeed(single): Airspeed, set to -1 if unknown
    %    vel_variance(single[3]): Variance of body velocity estimate
    %    pos_variance(single[3]): Variance in local position
    %    q(single[4]): The attitude, represented as Quaternion
    %    roll_rate(single): Angular rate in roll axis
    %    pitch_rate(single): Angular rate in pitch axis
    %    yaw_rate(single): Angular rate in yaw axis
	
	properties(Constant)
		ID = 146
		LEN = 100
	end
	
	properties
        time_usec	%Timestamp (micros since boot or Unix epoch)	|	(uint64)
        x_acc	%X acceleration in body frame	|	(single)
        y_acc	%Y acceleration in body frame	|	(single)
        z_acc	%Z acceleration in body frame	|	(single)
        x_vel	%X velocity in body frame	|	(single)
        y_vel	%Y velocity in body frame	|	(single)
        z_vel	%Z velocity in body frame	|	(single)
        x_pos	%X position in local frame	|	(single)
        y_pos	%Y position in local frame	|	(single)
        z_pos	%Z position in local frame	|	(single)
        airspeed	%Airspeed, set to -1 if unknown	|	(single)
        vel_variance	%Variance of body velocity estimate	|	(single[3])
        pos_variance	%Variance in local position	|	(single[3])
        q	%The attitude, represented as Quaternion	|	(single[4])
        roll_rate	%Angular rate in roll axis	|	(single)
        pitch_rate	%Angular rate in pitch axis	|	(single)
        yaw_rate	%Angular rate in yaw axis	|	(single)
    end

    methods

        function obj = msg_control_system_state(time_usec,x_acc,y_acc,z_acc,x_vel,y_vel,z_vel,x_pos,y_pos,z_pos,airspeed,vel_variance,pos_variance,q,roll_rate,pitch_rate,yaw_rate,varargin)
        %Create a new control_system_state message
        
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
            
            elseif nargin == 17
                obj.time_usec = time_usec;
                obj.x_acc = x_acc;
                obj.y_acc = y_acc;
                obj.z_acc = z_acc;
                obj.x_vel = x_vel;
                obj.y_vel = y_vel;
                obj.z_vel = z_vel;
                obj.x_pos = x_pos;
                obj.y_pos = y_pos;
                obj.z_pos = z_pos;
                obj.airspeed = airspeed;
                obj.vel_variance = vel_variance;
                obj.pos_variance = pos_variance;
                obj.q = q;
                obj.roll_rate = roll_rate;
                obj.pitch_rate = pitch_rate;
                obj.yaw_rate = yaw_rate;
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

                packet = mavlink_packet(msg_control_system_state.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_control_system_state.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                packet.payload.putSINGLE(obj.x_acc);
                packet.payload.putSINGLE(obj.y_acc);
                packet.payload.putSINGLE(obj.z_acc);
                packet.payload.putSINGLE(obj.x_vel);
                packet.payload.putSINGLE(obj.y_vel);
                packet.payload.putSINGLE(obj.z_vel);
                packet.payload.putSINGLE(obj.x_pos);
                packet.payload.putSINGLE(obj.y_pos);
                packet.payload.putSINGLE(obj.z_pos);
                packet.payload.putSINGLE(obj.airspeed);
                for i=1:1:3
                    packet.payload.putSINGLE(obj.vel_variance(i));
                end
                for i=1:1:3
                    packet.payload.putSINGLE(obj.pos_variance(i));
                end
                for i=1:1:4
                    packet.payload.putSINGLE(obj.q(i));
                end
                packet.payload.putSINGLE(obj.roll_rate);
                packet.payload.putSINGLE(obj.pitch_rate);
                packet.payload.putSINGLE(obj.yaw_rate);

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
            obj.x_acc = payload.getSINGLE();
            obj.y_acc = payload.getSINGLE();
            obj.z_acc = payload.getSINGLE();
            obj.x_vel = payload.getSINGLE();
            obj.y_vel = payload.getSINGLE();
            obj.z_vel = payload.getSINGLE();
            obj.x_pos = payload.getSINGLE();
            obj.y_pos = payload.getSINGLE();
            obj.z_pos = payload.getSINGLE();
            obj.airspeed = payload.getSINGLE();
            for i=1:1:3
                obj.vel_variance(i) = payload.getSINGLE();
            end
            for i=1:1:3
                obj.pos_variance(i) = payload.getSINGLE();
            end
            for i=1:1:4
                obj.q(i) = payload.getSINGLE();
            end
            obj.roll_rate = payload.getSINGLE();
            obj.pitch_rate = payload.getSINGLE();
            obj.yaw_rate = payload.getSINGLE();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.x_acc,2) ~= 1
                result = 'x_acc';
            elseif size(obj.y_acc,2) ~= 1
                result = 'y_acc';
            elseif size(obj.z_acc,2) ~= 1
                result = 'z_acc';
            elseif size(obj.x_vel,2) ~= 1
                result = 'x_vel';
            elseif size(obj.y_vel,2) ~= 1
                result = 'y_vel';
            elseif size(obj.z_vel,2) ~= 1
                result = 'z_vel';
            elseif size(obj.x_pos,2) ~= 1
                result = 'x_pos';
            elseif size(obj.y_pos,2) ~= 1
                result = 'y_pos';
            elseif size(obj.z_pos,2) ~= 1
                result = 'z_pos';
            elseif size(obj.airspeed,2) ~= 1
                result = 'airspeed';
            elseif size(obj.vel_variance,2) ~= 3
                result = 'vel_variance';
            elseif size(obj.pos_variance,2) ~= 3
                result = 'pos_variance';
            elseif size(obj.q,2) ~= 4
                result = 'q';
            elseif size(obj.roll_rate,2) ~= 1
                result = 'roll_rate';
            elseif size(obj.pitch_rate,2) ~= 1
                result = 'pitch_rate';
            elseif size(obj.yaw_rate,2) ~= 1
                result = 'yaw_rate';

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
        
        function set.x_acc(obj,value)
            obj.x_acc = single(value);
        end
        
        function set.y_acc(obj,value)
            obj.y_acc = single(value);
        end
        
        function set.z_acc(obj,value)
            obj.z_acc = single(value);
        end
        
        function set.x_vel(obj,value)
            obj.x_vel = single(value);
        end
        
        function set.y_vel(obj,value)
            obj.y_vel = single(value);
        end
        
        function set.z_vel(obj,value)
            obj.z_vel = single(value);
        end
        
        function set.x_pos(obj,value)
            obj.x_pos = single(value);
        end
        
        function set.y_pos(obj,value)
            obj.y_pos = single(value);
        end
        
        function set.z_pos(obj,value)
            obj.z_pos = single(value);
        end
        
        function set.airspeed(obj,value)
            obj.airspeed = single(value);
        end
        
        function set.vel_variance(obj,value)
            obj.vel_variance = single(value);
        end
        
        function set.pos_variance(obj,value)
            obj.pos_variance = single(value);
        end
        
        function set.q(obj,value)
            obj.q = single(value);
        end
        
        function set.roll_rate(obj,value)
            obj.roll_rate = single(value);
        end
        
        function set.pitch_rate(obj,value)
            obj.pitch_rate = single(value);
        end
        
        function set.yaw_rate(obj,value)
            obj.yaw_rate = single(value);
        end
        
    end

end