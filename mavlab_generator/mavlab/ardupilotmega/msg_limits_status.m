classdef msg_limits_status < mavlink_message
	%MSG_LIMITS_STATUS: MAVLINK Message ID = 167
    %Description:
    %    Status of AP_Limits. Sent in extended
	    status stream when AP_Limits is enabled
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    last_trigger(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    last_trigger(uint32): time of last breach in milliseconds since boot
    %    last_action(uint32): time of last recovery action in milliseconds since boot
    %    last_recovery(uint32): time of last successful recovery in milliseconds since boot
    %    last_clear(uint32): time of last all-clear in milliseconds since boot
    %    breach_count(uint16): number of fence breaches
    %    limits_state(uint8): state of AP_Limits, (see enum LimitState, LIMITS_STATE)
    %    mods_enabled(uint8): AP_Limit_Module bitfield of enabled modules, (see enum moduleid or LIMIT_MODULE)
    %    mods_required(uint8): AP_Limit_Module bitfield of required modules, (see enum moduleid or LIMIT_MODULE)
    %    mods_triggered(uint8): AP_Limit_Module bitfield of triggered modules, (see enum moduleid or LIMIT_MODULE)
	
	properties(Constant)
		ID = 167
		LEN = 22
	end
	
	properties
        last_trigger	%time of last breach in milliseconds since boot	|	(uint32)
        last_action	%time of last recovery action in milliseconds since boot	|	(uint32)
        last_recovery	%time of last successful recovery in milliseconds since boot	|	(uint32)
        last_clear	%time of last all-clear in milliseconds since boot	|	(uint32)
        breach_count	%number of fence breaches	|	(uint16)
        limits_state	%state of AP_Limits, (see enum LimitState, LIMITS_STATE)	|	(uint8)
        mods_enabled	%AP_Limit_Module bitfield of enabled modules, (see enum moduleid or LIMIT_MODULE)	|	(uint8)
        mods_required	%AP_Limit_Module bitfield of required modules, (see enum moduleid or LIMIT_MODULE)	|	(uint8)
        mods_triggered	%AP_Limit_Module bitfield of triggered modules, (see enum moduleid or LIMIT_MODULE)	|	(uint8)
    end

    methods

        function obj = msg_limits_status(last_trigger,last_action,last_recovery,last_clear,breach_count,limits_state,mods_enabled,mods_required,mods_triggered,varargin)
        %Create a new limits_status message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(last_trigger,'mavlink_packet')
                    packet = last_trigger;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('last_trigger','mavlink_packet');
                end
            
            elseif nargin == 9
                obj.last_trigger = last_trigger;
                obj.last_action = last_action;
                obj.last_recovery = last_recovery;
                obj.last_clear = last_clear;
                obj.breach_count = breach_count;
                obj.limits_state = limits_state;
                obj.mods_enabled = mods_enabled;
                obj.mods_required = mods_required;
                obj.mods_triggered = mods_triggered;
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

                packet = mavlink_packet(msg_limits_status.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_limits_status.ID;
                
                packet.payload.putUINT32(obj.last_trigger);
                packet.payload.putUINT32(obj.last_action);
                packet.payload.putUINT32(obj.last_recovery);
                packet.payload.putUINT32(obj.last_clear);
                packet.payload.putUINT16(obj.breach_count);
                packet.payload.putUINT8(obj.limits_state);
                packet.payload.putUINT8(obj.mods_enabled);
                packet.payload.putUINT8(obj.mods_required);
                packet.payload.putUINT8(obj.mods_triggered);

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
            
            obj.last_trigger = payload.getUINT32();
            obj.last_action = payload.getUINT32();
            obj.last_recovery = payload.getUINT32();
            obj.last_clear = payload.getUINT32();
            obj.breach_count = payload.getUINT16();
            obj.limits_state = payload.getUINT8();
            obj.mods_enabled = payload.getUINT8();
            obj.mods_required = payload.getUINT8();
            obj.mods_triggered = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.last_trigger,2) ~= 1
                result = 'last_trigger';
            elseif size(obj.last_action,2) ~= 1
                result = 'last_action';
            elseif size(obj.last_recovery,2) ~= 1
                result = 'last_recovery';
            elseif size(obj.last_clear,2) ~= 1
                result = 'last_clear';
            elseif size(obj.breach_count,2) ~= 1
                result = 'breach_count';
            elseif size(obj.limits_state,2) ~= 1
                result = 'limits_state';
            elseif size(obj.mods_enabled,2) ~= 1
                result = 'mods_enabled';
            elseif size(obj.mods_required,2) ~= 1
                result = 'mods_required';
            elseif size(obj.mods_triggered,2) ~= 1
                result = 'mods_triggered';

            else
                result = 0;
            end
        end

        function set.last_trigger(obj,value)
            if value == uint32(value)
                obj.last_trigger = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.last_action(obj,value)
            if value == uint32(value)
                obj.last_action = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.last_recovery(obj,value)
            if value == uint32(value)
                obj.last_recovery = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.last_clear(obj,value)
            if value == uint32(value)
                obj.last_clear = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.breach_count(obj,value)
            if value == uint16(value)
                obj.breach_count = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.limits_state(obj,value)
            if value == uint8(value)
                obj.limits_state = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.mods_enabled(obj,value)
            if value == uint8(value)
                obj.mods_enabled = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.mods_required(obj,value)
            if value == uint8(value)
                obj.mods_required = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.mods_triggered(obj,value)
            if value == uint8(value)
                obj.mods_triggered = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end