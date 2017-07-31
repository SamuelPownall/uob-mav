classdef msg_hil_actuator_controls < mavlink_message
	%MSG_HIL_ACTUATOR_CONTROLS: MAVLINK Message ID = 93
    %Description:
    %    Sent from autopilot to simulation. Hardware in the loop control outputs (replacement for HIL_CONTROLS)
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    time_usec(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    time_usec(uint64): Timestamp (microseconds since UNIX epoch or microseconds since system boot)
    %    flags(uint64): Flags as bitfield, reserved for future use.
    %    controls(single[16]): Control outputs -1 .. 1. Channel assignment depends on the simulated hardware.
    %    mode(uint8): System mode (MAV_MODE), includes arming state.
	
	properties(Constant)
		ID = 93
		LEN = 81
	end
	
	properties
        time_usec	%Timestamp (microseconds since UNIX epoch or microseconds since system boot)	|	(uint64)
        flags	%Flags as bitfield, reserved for future use.	|	(uint64)
        controls	%Control outputs -1 .. 1. Channel assignment depends on the simulated hardware.	|	(single[16])
        mode	%System mode (MAV_MODE), includes arming state.	|	(uint8)
    end

    methods

        function obj = msg_hil_actuator_controls(time_usec,flags,controls,mode,varargin)
        %MSG_HIL_ACTUATOR_CONTROLS: Create a new hil_actuator_controls message object
        
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
            elseif nargin == 4
                obj.time_usec = time_usec;
                obj.flags = flags;
                obj.controls = controls;
                obj.mode = mode;
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

                packet = mavlink_packet(msg_hil_actuator_controls.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_hil_actuator_controls.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                packet.payload.putUINT64(obj.flags);
                for i=1:1:16
                    packet.payload.putSINGLE(obj.controls(i));
                end
                packet.payload.putUINT8(obj.mode);

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
            obj.flags = payload.getUINT64();
            for i=1:1:16
                obj.controls(i) = payload.getSINGLE();
            end
            obj.mode = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.flags,2) ~= 1
                result = 'flags';
            elseif size(obj.controls,2) ~= 16
                result = 'controls';
            elseif size(obj.mode,2) ~= 1
                result = 'mode';

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
        
        function set.flags(obj,value)
            if value == uint64(value)
                obj.flags = uint64(value);
            else
                mavlink.throwTypeError('value','uint64');
            end
        end
        
        function set.controls(obj,value)
            obj.controls = single(value);
        end
        
        function set.mode(obj,value)
            if value == uint8(value)
                obj.mode = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end