classdef msg_hil_actuator_controls < MAVLinkMessage
	%MSG_HIL_ACTUATOR_CONTROLS: MAVLink Message ID = 93
    %Description:
    %    Sent from autopilot to simulation. Hardware in the loop control outputs (replacement for HIL_CONTROLS)
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_usec(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,time_usec,flags,controls,mode,varargin)

            if nargin == 4 + 1
                msg = msg_hil_actuator_controls(time_usec,flags,controls,mode,varargin);
            elseif nargin == 2
                msg = msg_hil_actuator_controls(time_usec);
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

        function obj = msg_hil_actuator_controls(time_usec,flags,controls,mode,varargin)
        %MSG_HIL_ACTUATOR_CONTROLS: Create a new hil_actuator_controls message object
        
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
            elseif nargin >= 4 && isempty(varargin{1})
                obj.time_usec = time_usec;
                obj.flags = flags;
                obj.controls = controls;
                obj.mode = mode;
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

                packet = MAVLinkPacket(msg_hil_actuator_controls.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_hil_actuator_controls.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                packet.payload.putUINT64(obj.flags);
                for i=1:1:16
                    packet.payload.putSINGLE(obj.controls(i));
                end
                packet.payload.putUINT8(obj.mode);

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
                MAVLink.throwTypeError('value','uint64');
            end
        end
        
        function set.flags(obj,value)
            if value == uint64(value)
                obj.flags = uint64(value);
            else
                MAVLink.throwTypeError('value','uint64');
            end
        end
        
        function set.controls(obj,value)
            obj.controls = single(value);
        end
        
        function set.mode(obj,value)
            if value == uint8(value)
                obj.mode = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end