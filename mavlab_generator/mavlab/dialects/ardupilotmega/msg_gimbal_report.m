classdef msg_gimbal_report < MAVLinkMessage
	%MSG_GIMBAL_REPORT: MAVLink Message ID = 200
    %Description:
    %    3 axis gimbal mesuraments
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    delta_time(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    delta_time(single): Time since last update (seconds)
    %    delta_angle_x(single): Delta angle X (radians)
    %    delta_angle_y(single): Delta angle Y (radians)
    %    delta_angle_z(single): Delta angle X (radians)
    %    delta_velocity_x(single): Delta velocity X (m/s)
    %    delta_velocity_y(single): Delta velocity Y (m/s)
    %    delta_velocity_z(single): Delta velocity Z (m/s)
    %    joint_roll(single): Joint ROLL (radians)
    %    joint_el(single): Joint EL (radians)
    %    joint_az(single): Joint AZ (radians)
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
        joint_roll	%Joint ROLL (radians)	|	(single)
        joint_el	%Joint EL (radians)	|	(single)
        joint_az	%Joint AZ (radians)	|	(single)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
    end

    methods(Static)

        function send(out,delta_time,delta_angle_x,delta_angle_y,delta_angle_z,delta_velocity_x,delta_velocity_y,delta_velocity_z,joint_roll,joint_el,joint_az,target_system,target_component,varargin)

            if nargin == 12 + 1
                msg = msg_gimbal_report(delta_time,delta_angle_x,delta_angle_y,delta_angle_z,delta_velocity_x,delta_velocity_y,delta_velocity_z,joint_roll,joint_el,joint_az,target_system,target_component,varargin);
            elseif nargin == 2
                msg = msg_gimbal_report(delta_time);
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

        function obj = msg_gimbal_report(delta_time,delta_angle_x,delta_angle_y,delta_angle_z,delta_velocity_x,delta_velocity_y,delta_velocity_z,joint_roll,joint_el,joint_az,target_system,target_component,varargin)
        %MSG_GIMBAL_REPORT: Create a new gimbal_report message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(delta_time,'MAVLinkPacket')
                    packet = delta_time;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('delta_time','MAVLinkPacket');
                end
            elseif nargin >= 12 && isempty(varargin{1})
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

                packet = MAVLinkPacket(msg_gimbal_report.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
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
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end