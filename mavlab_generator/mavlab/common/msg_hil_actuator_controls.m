classdef msg_hil_actuator_controls < mavlink_handle
	%MSG_HIL_ACTUATOR_CONTROLS(packet,time_usec,flags,controls,mode): MAVLINK Message ID = 93
    %Description:
    %    Sent from autopilot to simulation. Hardware in the loop control outputs (replacement for HIL_CONTROLS)
    %    If constructing from fields, packet argument should be set to []
	%Fields:
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

        %Constructor: msg_hil_actuator_controls
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_hil_actuator_controls(packet,time_usec,flags,controls,mode)
        
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
            
            elseif nargin-1 == 4
                obj.time_usec = time_usec;
                obj.flags = flags;
                obj.controls = controls;
                obj.mode = mode;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

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

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.time_usec = payload.getUINT64();
            obj.flags = payload.getUINT64();
            for i=1:1:16
                obj.controls(i) = payload.getSINGLE();
            end
            obj.mode = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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