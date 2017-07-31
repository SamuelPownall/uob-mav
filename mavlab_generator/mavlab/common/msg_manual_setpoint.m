classdef msg_manual_setpoint < mavlink_message
	%MSG_MANUAL_SETPOINT: MAVLINK Message ID = 81
    %Description:
    %    Setpoint in roll, pitch, yaw and thrust from the operator
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    time_boot_ms(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    time_boot_ms(uint32): Timestamp in milliseconds since system boot
    %    roll(single): Desired roll rate in radians per second
    %    pitch(single): Desired pitch rate in radians per second
    %    yaw(single): Desired yaw rate in radians per second
    %    thrust(single): Collective thrust, normalized to 0 .. 1
    %    mode_switch(uint8): Flight mode switch position, 0.. 255
    %    manual_override_switch(uint8): Override mode switch position, 0.. 255
	
	properties(Constant)
		ID = 81
		LEN = 22
	end
	
	properties
        time_boot_ms	%Timestamp in milliseconds since system boot	|	(uint32)
        roll	%Desired roll rate in radians per second	|	(single)
        pitch	%Desired pitch rate in radians per second	|	(single)
        yaw	%Desired yaw rate in radians per second	|	(single)
        thrust	%Collective thrust, normalized to 0 .. 1	|	(single)
        mode_switch	%Flight mode switch position, 0.. 255	|	(uint8)
        manual_override_switch	%Override mode switch position, 0.. 255	|	(uint8)
    end

    methods

        function obj = msg_manual_setpoint(time_boot_ms,roll,pitch,yaw,thrust,mode_switch,manual_override_switch,varargin)
        %Create a new manual_setpoint message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(time_boot_ms,'mavlink_packet')
                    packet = time_boot_ms;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('time_boot_ms','mavlink_packet');
                end
            
            elseif nargin == 7
                obj.time_boot_ms = time_boot_ms;
                obj.roll = roll;
                obj.pitch = pitch;
                obj.yaw = yaw;
                obj.thrust = thrust;
                obj.mode_switch = mode_switch;
                obj.manual_override_switch = manual_override_switch;
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

                packet = mavlink_packet(msg_manual_setpoint.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_manual_setpoint.ID;
                
                packet.payload.putUINT32(obj.time_boot_ms);
                packet.payload.putSINGLE(obj.roll);
                packet.payload.putSINGLE(obj.pitch);
                packet.payload.putSINGLE(obj.yaw);
                packet.payload.putSINGLE(obj.thrust);
                packet.payload.putUINT8(obj.mode_switch);
                packet.payload.putUINT8(obj.manual_override_switch);

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
            
            obj.time_boot_ms = payload.getUINT32();
            obj.roll = payload.getSINGLE();
            obj.pitch = payload.getSINGLE();
            obj.yaw = payload.getSINGLE();
            obj.thrust = payload.getSINGLE();
            obj.mode_switch = payload.getUINT8();
            obj.manual_override_switch = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';
            elseif size(obj.roll,2) ~= 1
                result = 'roll';
            elseif size(obj.pitch,2) ~= 1
                result = 'pitch';
            elseif size(obj.yaw,2) ~= 1
                result = 'yaw';
            elseif size(obj.thrust,2) ~= 1
                result = 'thrust';
            elseif size(obj.mode_switch,2) ~= 1
                result = 'mode_switch';
            elseif size(obj.manual_override_switch,2) ~= 1
                result = 'manual_override_switch';

            else
                result = 0;
            end
        end

        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
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
        
        function set.thrust(obj,value)
            obj.thrust = single(value);
        end
        
        function set.mode_switch(obj,value)
            if value == uint8(value)
                obj.mode_switch = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.manual_override_switch(obj,value)
            if value == uint8(value)
                obj.manual_override_switch = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end