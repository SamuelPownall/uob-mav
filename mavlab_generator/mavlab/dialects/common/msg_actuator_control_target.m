classdef msg_actuator_control_target < MAVLinkMessage
	%MSG_ACTUATOR_CONTROL_TARGET: MAVLink Message ID = 140
    %Description:
    %    Set the vehicle attitude and body angular rates.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_usec(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    time_usec(uint64): Timestamp (micros since boot or Unix epoch)
    %    controls(single[8]): Actuator controls. Normed to -1..+1 where 0 is neutral position. Throttle for single rotation direction motors is 0..1, negative range for reverse direction. Standard mapping for attitude controls (group 0): (index 0-7): roll, pitch, yaw, throttle, flaps, spoilers, airbrakes, landing gear. Load a pass-through mixer to repurpose them as generic outputs.
    %    group_mlx(uint8): Actuator group. The "_mlx" indicates this is a multi-instance message and a MAVLink parser should use this field to difference between instances.
	
	properties(Constant)
		ID = 140
		LEN = 41
	end
	
	properties
        time_usec	%Timestamp (micros since boot or Unix epoch)	|	(uint64)
        controls	%Actuator controls. Normed to -1..+1 where 0 is neutral position. Throttle for single rotation direction motors is 0..1, negative range for reverse direction. Standard mapping for attitude controls (group 0): (index 0-7): roll, pitch, yaw, throttle, flaps, spoilers, airbrakes, landing gear. Load a pass-through mixer to repurpose them as generic outputs.	|	(single[8])
        group_mlx	%Actuator group. The "_mlx" indicates this is a multi-instance message and a MAVLink parser should use this field to difference between instances.	|	(uint8)
    end

    methods(Static)

        function send(out,time_usec,controls,group_mlx,varargin)

            if nargin == 3 + 1
                msg = msg_actuator_control_target(time_usec,controls,group_mlx,varargin);
            elseif nargin == 2
                msg = msg_actuator_control_target(time_usec);
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

        function obj = msg_actuator_control_target(time_usec,controls,group_mlx,varargin)
        %MSG_ACTUATOR_CONTROL_TARGET: Create a new actuator_control_target message object
        
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
            elseif nargin >= 3 && isempty(varargin{1})
                obj.time_usec = time_usec;
                obj.controls = controls;
                obj.group_mlx = group_mlx;
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

                packet = MAVLinkPacket(msg_actuator_control_target.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_actuator_control_target.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                for i=1:1:8
                    packet.payload.putSINGLE(obj.controls(i));
                end
                packet.payload.putUINT8(obj.group_mlx);

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
            for i=1:1:8
                obj.controls(i) = payload.getSINGLE();
            end
            obj.group_mlx = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.controls,2) ~= 8
                result = 'controls';
            elseif size(obj.group_mlx,2) ~= 1
                result = 'group_mlx';

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
        
        function set.controls(obj,value)
            obj.controls = single(value);
        end
        
        function set.group_mlx(obj,value)
            if value == uint8(value)
                obj.group_mlx = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end