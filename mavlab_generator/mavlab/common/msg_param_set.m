classdef msg_param_set < mavlink_message
	%MSG_PARAM_SET: MAVLINK Message ID = 23
    %Description:
    %    Set a parameter value TEMPORARILY to RAM. It will be reset to default on system reboot. Send the ACTION MAV_ACTION_STORAGE_WRITE to PERMANENTLY write the RAM contents to EEPROM. IMPORTANT: The receiving component should acknowledge the new parameter value by sending a param_value message to all communication partners. This will also ensure that multiple GCS all have an up-to-date list of all parameters. If the sending GCS did not receive a PARAM_VALUE message within its timeout time, it should re-send the PARAM_SET message.
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    param_value(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    param_value(single): Onboard parameter value
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
    %    param_id(uint8[16]): Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string
    %    param_type(uint8): Onboard parameter type: see the MAV_PARAM_TYPE enum for supported data types.
	
	properties(Constant)
		ID = 23
		LEN = 23
	end
	
	properties
        param_value	%Onboard parameter value	|	(single)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
        param_id	%Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string	|	(uint8[16])
        param_type	%Onboard parameter type: see the MAV_PARAM_TYPE enum for supported data types.	|	(uint8)
    end

    methods

        function obj = msg_param_set(param_value,target_system,target_component,param_id,param_type,varargin)
        %Create a new param_set message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(param_value,'mavlink_packet')
                    packet = param_value;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('param_value','mavlink_packet');
                end
            
            elseif nargin == 5
                obj.param_value = param_value;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.param_id = param_id;
                obj.param_type = param_type;
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

                packet = mavlink_packet(msg_param_set.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_param_set.ID;
                
                packet.payload.putSINGLE(obj.param_value);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                for i=1:1:16
                    packet.payload.putUINT8(obj.param_id(i));
                end
                packet.payload.putUINT8(obj.param_type);

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
            
            obj.param_value = payload.getSINGLE();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            for i=1:1:16
                obj.param_id(i) = payload.getUINT8();
            end
            obj.param_type = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.param_value,2) ~= 1
                result = 'param_value';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';
            elseif size(obj.param_id,2) ~= 16
                result = 'param_id';
            elseif size(obj.param_type,2) ~= 1
                result = 'param_type';

            else
                result = 0;
            end
        end

        function set.param_value(obj,value)
            obj.param_value = single(value);
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
        
        function set.param_type(obj,value)
            if value == uint8(value)
                obj.param_type = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end