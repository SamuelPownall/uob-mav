classdef msg_param_set < MAVLinkMessage
	%MSG_PARAM_SET: MAVLink Message ID = 23
    %Description:
    %    Set a parameter value TEMPORARILY to RAM. It will be reset to default on system reboot. Send the ACTION MAV_ACTION_STORAGE_WRITE to PERMANENTLY write the RAM contents to EEPROM. IMPORTANT: The receiving component should acknowledge the new parameter value by sending a param_value message to all communication partners. This will also ensure that multiple GCS all have an up-to-date list of all parameters. If the sending GCS did not receive a PARAM_VALUE message within its timeout time, it should re-send the PARAM_SET message.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    param_value(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,param_value,target_system,target_component,param_id,param_type,varargin)

            if nargin == 5 + 1
                msg = msg_param_set(param_value,target_system,target_component,param_id,param_type,varargin);
            elseif nargin == 2
                msg = msg_param_set(param_value);
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

        function obj = msg_param_set(param_value,target_system,target_component,param_id,param_type,varargin)
        %MSG_PARAM_SET: Create a new param_set message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(param_value,'MAVLinkPacket')
                    packet = param_value;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('param_value','MAVLinkPacket');
                end
            elseif nargin >= 5 && isempty(varargin{1})
                obj.param_value = param_value;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.param_id = param_id;
                obj.param_type = param_type;
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

                packet = MAVLinkPacket(msg_param_set.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
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
        
        function set.param_id(obj,value)
            if value == uint8(value)
                obj.param_id = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.param_type(obj,value)
            if value == uint8(value)
                obj.param_type = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end