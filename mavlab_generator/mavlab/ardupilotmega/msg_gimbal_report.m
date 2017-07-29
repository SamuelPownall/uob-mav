classdef msg_gimbal_report < mavlink_message
	%MSG_GIMBAL_REPORT: MAVLINK Message ID = 200
    %Description:
    %    3 axis gimbal mesuraments
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
    %    delta_time(single): Time since last update (seconds)
    %    delta_angle_x(single): Delta angle X (radians)
    %    delta_angle_y(single): Delta angle Y (radians)
    %    delta_angle_z(single): Delta angle X (radians)
    %    delta_velocity_x(single): Delta velocity X (m/s)
    %    delta_velocity_y(single): Delta velocity Y (m/s)
    %    delta_velocity_z(single): Delta velocity Z (m/s)
    %    joint_roll(single):  Joint ROLL (radians)
    %    joint_el(single):  Joint EL (radians)
    %    joint_az(single):  Joint AZ (radians)
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
	
	properties(Constant)
		ID = 200
		LEN = 42
	end
	
	properties
        delta_time	%Time since last update (seconds)	|	(single)
        delta_angle_x	%Delta angle X (radians)	|	(single)
        delta_angle_y	%Delta angle Y (radians)	|	(single)
        delta_angle_z	%Delta angle X (radians)	|	(single)
        delta_velocity_x	%Delta velocity X (m/s)	|	(single)
        delta_velocity_y	%Delta velocity Y (m/s)	|	(single)
        delta_velocity_z	%Delta velocity Z (m/s)	|	(single)
        joint_roll	% Joint ROLL (radians)	|	(single)
        joint_el	% Joint EL (radians)	|	(single)
        joint_az	% Joint AZ (radians)	|	(single)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
    end

    methods

        function obj = msg_gimbal_report(packet,delta_time,delta_angle_x,delta_angle_y,delta_angle_z,delta_velocity_x,delta_velocity_y,delta_velocity_z,joint_roll,joint_el,joint_az,target_system,target_component)
        %Create a new gimbal_report message
        
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
            
            elseif nargin-1 == 12
                obj.delta_time = delta_time;
                obj.delta_angle_x = delta_angle_x;
                obj.delta_angle_y = delta_angle_y;
                obj.delta_angle_z = delta_angle_z;
                obj.delta_velocity_x = delta_velocity_x;
                obj.delta_velocity_y = delta_velocity_y;
                obj.delta_velocity_z = delta_velocity_z;
                obj.joint_roll = joint_roll;
                obj.joint_el = joint_el;
                obj.joint_az = joint_az;
                obj.target_system = target_system;
                obj.target_component = target_component;
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

                packet = mavlink_packet(msg_gimbal_report.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_gimbal_report.ID;
                
                packet.payload.putSINGLE(obj.delta_time);
                packet.payload.putSINGLE(obj.delta_angle_x);
                packet.payload.putSINGLE(obj.delta_angle_y);
                packet.payload.putSINGLE(obj.delta_angle_z);
                packet.payload.putSINGLE(obj.delta_velocity_x);
                packet.payload.putSINGLE(obj.delta_velocity_y);
                packet.payload.putSINGLE(obj.delta_velocity_z);
                packet.payload.putSINGLE(obj.joint_roll);
                packet.payload.putSINGLE(obj.joint_el);
                packet.payload.putSINGLE(obj.joint_az);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);

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
            
            obj.delta_time = payload.getSINGLE();
            obj.delta_angle_x = payload.getSINGLE();
            obj.delta_angle_y = payload.getSINGLE();
            obj.delta_angle_z = payload.getSINGLE();
            obj.delta_velocity_x = payload.getSINGLE();
            obj.delta_velocity_y = payload.getSINGLE();
            obj.delta_velocity_z = payload.getSINGLE();
            obj.joint_roll = payload.getSINGLE();
            obj.joint_el = payload.getSINGLE();
            obj.joint_az = payload.getSINGLE();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.delta_time,2) ~= 1
                result = 'delta_time';
            elseif size(obj.delta_angle_x,2) ~= 1
                result = 'delta_angle_x';
            elseif size(obj.delta_angle_y,2) ~= 1
                result = 'delta_angle_y';
            elseif size(obj.delta_angle_z,2) ~= 1
                result = 'delta_angle_z';
            elseif size(obj.delta_velocity_x,2) ~= 1
                result = 'delta_velocity_x';
            elseif size(obj.delta_velocity_y,2) ~= 1
                result = 'delta_velocity_y';
            elseif size(obj.delta_velocity_z,2) ~= 1
                result = 'delta_velocity_z';
            elseif size(obj.joint_roll,2) ~= 1
                result = 'joint_roll';
            elseif size(obj.joint_el,2) ~= 1
                result = 'joint_el';
            elseif size(obj.joint_az,2) ~= 1
                result = 'joint_az';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';

            else
                result = 0;
            end
        end

        function set.delta_time(obj,value)
            obj.delta_time = single(value);
        end
        
        function set.delta_angle_x(obj,value)
            obj.delta_angle_x = single(value);
        end
        
        function set.delta_angle_y(obj,value)
            obj.delta_angle_y = single(value);
        end
        
        function set.delta_angle_z(obj,value)
            obj.delta_angle_z = single(value);
        end
        
        function set.delta_velocity_x(obj,value)
            obj.delta_velocity_x = single(value);
        end
        
        function set.delta_velocity_y(obj,value)
            obj.delta_velocity_y = single(value);
        end
        
        function set.delta_velocity_z(obj,value)
            obj.delta_velocity_z = single(value);
        end
        
        function set.joint_roll(obj,value)
            obj.joint_roll = single(value);
        end
        
        function set.joint_el(obj,value)
            obj.joint_el = single(value);
        end
        
        function set.joint_az(obj,value)
            obj.joint_az = single(value);
        end
        
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end