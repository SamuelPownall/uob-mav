classdef msg_param_map_rc < mavlink_message
	%MSG_PARAM_MAP_RC(packet,param_value0,scale,param_value_min,param_value_max,param_index,target_system,target_component,param_id,parameter_rc_channel_index): MAVLINK Message ID = 50
    %Description:
    %    Bind a RC channel to a parameter. The parameter should change accoding to the RC channel value.
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    param_value0(single): Initial parameter value
    %    scale(single): Scale, maps the RC range [-1, 1] to a parameter value
    %    param_value_min(single): Minimum param value. The protocol does not define if this overwrites an onboard minimum value. (Depends on implementation)
    %    param_value_max(single): Maximum param value. The protocol does not define if this overwrites an onboard maximum value. (Depends on implementation)
    %    param_index(int16): Parameter index. Send -1 to use the param ID field as identifier (else the param id will be ignored), send -2 to disable any existing map for this rc_channel_index.
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
    %    param_id(uint8[16]): Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string
    %    parameter_rc_channel_index(uint8): Index of parameter RC channel. Not equal to the RC channel id. Typically correpsonds to a potentiometer-knob on the RC.
	
	properties(Constant)
		ID = 50
		LEN = 37
	end
	
	properties
        param_value0	%Initial parameter value	|	(single)
        scale	%Scale, maps the RC range [-1, 1] to a parameter value	|	(single)
        param_value_min	%Minimum param value. The protocol does not define if this overwrites an onboard minimum value. (Depends on implementation)	|	(single)
        param_value_max	%Maximum param value. The protocol does not define if this overwrites an onboard maximum value. (Depends on implementation)	|	(single)
        param_index	%Parameter index. Send -1 to use the param ID field as identifier (else the param id will be ignored), send -2 to disable any existing map for this rc_channel_index.	|	(int16)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
        param_id	%Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string	|	(uint8[16])
        parameter_rc_channel_index	%Index of parameter RC channel. Not equal to the RC channel id. Typically correpsonds to a potentiometer-knob on the RC.	|	(uint8)
    end

    methods

        %Constructor: msg_param_map_rc
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_param_map_rc(packet,param_value0,scale,param_value_min,param_value_max,param_index,target_system,target_component,param_id,parameter_rc_channel_index)
        
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
            
            elseif nargin-1 == 9
                obj.param_value0 = param_value0;
                obj.scale = scale;
                obj.param_value_min = param_value_min;
                obj.param_value_max = param_value_max;
                obj.param_index = param_index;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.param_id = param_id;
                obj.parameter_rc_channel_index = parameter_rc_channel_index;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_param_map_rc.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_param_map_rc.ID;
                
                packet.payload.putSINGLE(obj.param_value0);
                packet.payload.putSINGLE(obj.scale);
                packet.payload.putSINGLE(obj.param_value_min);
                packet.payload.putSINGLE(obj.param_value_max);
                packet.payload.putINT16(obj.param_index);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                for i=1:1:16
                    packet.payload.putUINT8(obj.param_id(i));
                end
                packet.payload.putUINT8(obj.parameter_rc_channel_index);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.param_value0 = payload.getSINGLE();
            obj.scale = payload.getSINGLE();
            obj.param_value_min = payload.getSINGLE();
            obj.param_value_max = payload.getSINGLE();
            obj.param_index = payload.getINT16();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            for i=1:1:16
                obj.param_id(i) = payload.getUINT8();
            end
            obj.parameter_rc_channel_index = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.param_value0,2) ~= 1
                result = 'param_value0';
            elseif size(obj.scale,2) ~= 1
                result = 'scale';
            elseif size(obj.param_value_min,2) ~= 1
                result = 'param_value_min';
            elseif size(obj.param_value_max,2) ~= 1
                result = 'param_value_max';
            elseif size(obj.param_index,2) ~= 1
                result = 'param_index';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';
            elseif size(obj.param_id,2) ~= 16
                result = 'param_id';
            elseif size(obj.parameter_rc_channel_index,2) ~= 1
                result = 'parameter_rc_channel_index';

            else
                result = 0;
            end
        end

        function set.param_value0(obj,value)
            obj.param_value0 = single(value);
        end
        
        function set.scale(obj,value)
            obj.scale = single(value);
        end
        
        function set.param_value_min(obj,value)
            obj.param_value_min = single(value);
        end
        
        function set.param_value_max(obj,value)
            obj.param_value_max = single(value);
        end
        
        function set.param_index(obj,value)
            if value == int16(value)
                obj.param_index = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
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
        
        function set.param_id(obj,value)
            if value == uint8(value)
                obj.param_id = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.parameter_rc_channel_index(obj,value)
            if value == uint8(value)
                obj.parameter_rc_channel_index = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end