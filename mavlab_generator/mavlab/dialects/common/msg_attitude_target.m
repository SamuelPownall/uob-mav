classdef msg_attitude_target < MAVLinkMessage
	%MSG_ATTITUDE_TARGET: MAVLink Message ID = 83
    %Description:
    %    Reports the current commanded attitude of the vehicle as specified by the autopilot. This should match the commands sent in a SET_ATTITUDE_TARGET message if the vehicle is being controlled this way.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_boot_ms(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    time_boot_ms(uint32): Timestamp in milliseconds since system boot
    %    q(single[4]): Attitude quaternion (w, x, y, z order, zero-rotation is 1, 0, 0, 0)
    %    body_roll_rate(single): Body roll rate in radians per second
    %    body_pitch_rate(single): Body roll rate in radians per second
    %    body_yaw_rate(single): Body roll rate in radians per second
    %    thrust(single): Collective thrust, normalized to 0 .. 1 (-1 .. 1 for vehicles capable of reverse trust)
    %    type_mask(uint8): Mappings: If any of these bits are set, the corresponding input should be ignored: bit 1: body roll rate, bit 2: body pitch rate, bit 3: body yaw rate. bit 4-bit 7: reserved, bit 8: attitude
	
	properties(Constant)
		ID = 83
		LEN = 37
	end
	
	properties
        time_boot_ms	%Timestamp in milliseconds since system boot	|	(uint32)
        q	%Attitude quaternion (w, x, y, z order, zero-rotation is 1, 0, 0, 0)	|	(single[4])
        body_roll_rate	%Body roll rate in radians per second	|	(single)
        body_pitch_rate	%Body roll rate in radians per second	|	(single)
        body_yaw_rate	%Body roll rate in radians per second	|	(single)
        thrust	%Collective thrust, normalized to 0 .. 1 (-1 .. 1 for vehicles capable of reverse trust)	|	(single)
        type_mask	%Mappings: If any of these bits are set, the corresponding input should be ignored: bit 1: body roll rate, bit 2: body pitch rate, bit 3: body yaw rate. bit 4-bit 7: reserved, bit 8: attitude	|	(uint8)
    end

    methods(Static)

        function send(out,time_boot_ms,q,body_roll_rate,body_pitch_rate,body_yaw_rate,thrust,type_mask,varargin)

            if nargin == 7 + 1
                msg = msg_attitude_target(time_boot_ms,q,body_roll_rate,body_pitch_rate,body_yaw_rate,thrust,type_mask,varargin);
            elseif nargin == 2
                msg = msg_attitude_target(time_boot_ms);
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

        function obj = msg_attitude_target(time_boot_ms,q,body_roll_rate,body_pitch_rate,body_yaw_rate,thrust,type_mask,varargin)
        %MSG_ATTITUDE_TARGET: Create a new attitude_target message object
        
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
            elseif nargin >= 7 && isempty(varargin{1})
                obj.time_boot_ms = time_boot_ms;
                obj.q = q;
                obj.body_roll_rate = body_roll_rate;
                obj.body_pitch_rate = body_pitch_rate;
                obj.body_yaw_rate = body_yaw_rate;
                obj.thrust = thrust;
                obj.type_mask = type_mask;
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

                packet = MAVLinkPacket(msg_attitude_target.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_attitude_target.ID;
                
                packet.payload.putUINT32(obj.time_boot_ms);
                for i=1:1:4
                    packet.payload.putSINGLE(obj.q(i));
                end
                packet.payload.putSINGLE(obj.body_roll_rate);
                packet.payload.putSINGLE(obj.body_pitch_rate);
                packet.payload.putSINGLE(obj.body_yaw_rate);
                packet.payload.putSINGLE(obj.thrust);
                packet.payload.putUINT8(obj.type_mask);

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
            for i=1:1:4
                obj.q(i) = payload.getSINGLE();
            end
            obj.body_roll_rate = payload.getSINGLE();
            obj.body_pitch_rate = payload.getSINGLE();
            obj.body_yaw_rate = payload.getSINGLE();
            obj.thrust = payload.getSINGLE();
            obj.type_mask = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';
            elseif size(obj.q,2) ~= 4
                result = 'q';
            elseif size(obj.body_roll_rate,2) ~= 1
                result = 'body_roll_rate';
            elseif size(obj.body_pitch_rate,2) ~= 1
                result = 'body_pitch_rate';
            elseif size(obj.body_yaw_rate,2) ~= 1
                result = 'body_yaw_rate';
            elseif size(obj.thrust,2) ~= 1
                result = 'thrust';
            elseif size(obj.type_mask,2) ~= 1
                result = 'type_mask';

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
        
        function set.q(obj,value)
            obj.q = single(value);
        end
        
        function set.body_roll_rate(obj,value)
            obj.body_roll_rate = single(value);
        end
        
        function set.body_pitch_rate(obj,value)
            obj.body_pitch_rate = single(value);
        end
        
        function set.body_yaw_rate(obj,value)
            obj.body_yaw_rate = single(value);
        end
        
        function set.thrust(obj,value)
            obj.thrust = single(value);
        end
        
        function set.type_mask(obj,value)
            if value == uint8(value)
                obj.type_mask = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end