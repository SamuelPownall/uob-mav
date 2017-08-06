classdef msg_led_control < MAVLinkMessage
	%MSG_LED_CONTROL: MAVLink Message ID = 186
    %Description:
    %    Control vehicle LEDs
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    target_system(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
    %    instance(uint8): Instance (LED instance to control or 255 for all LEDs)
    %    pattern(uint8): Pattern (see LED_PATTERN_ENUM)
    %    custom_len(uint8): Custom Byte Length
    %    custom_bytes(uint8[24]): Custom Bytes
	
	properties(Constant)
		ID = 186
		LEN = 29
	end
	
	properties
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
        instance	%Instance (LED instance to control or 255 for all LEDs)	|	(uint8)
        pattern	%Pattern (see LED_PATTERN_ENUM)	|	(uint8)
        custom_len	%Custom Byte Length	|	(uint8)
        custom_bytes	%Custom Bytes	|	(uint8[24])
    end

    methods(Static)

        function send(out,target_system,target_component,instance,pattern,custom_len,custom_bytes,varargin)

            if nargin == 6 + 1
                msg = msg_led_control(target_system,target_component,instance,pattern,custom_len,custom_bytes,varargin);
            elseif nargin == 2
                msg = msg_led_control(target_system);
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

        function obj = msg_led_control(target_system,target_component,instance,pattern,custom_len,custom_bytes,varargin)
        %MSG_LED_CONTROL: Create a new led_control message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(target_system,'MAVLinkPacket')
                    packet = target_system;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('target_system','MAVLinkPacket');
                end
            elseif nargin >= 6 && isempty(varargin{1})
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.instance = instance;
                obj.pattern = pattern;
                obj.custom_len = custom_len;
                obj.custom_bytes = custom_bytes;
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

                packet = MAVLinkPacket(msg_led_control.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_led_control.ID;
                
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                packet.payload.putUINT8(obj.instance);
                packet.payload.putUINT8(obj.pattern);
                packet.payload.putUINT8(obj.custom_len);
                for i=1:1:24
                    packet.payload.putUINT8(obj.custom_bytes(i));
                end

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
            
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            obj.instance = payload.getUINT8();
            obj.pattern = payload.getUINT8();
            obj.custom_len = payload.getUINT8();
            for i=1:1:24
                obj.custom_bytes(i) = payload.getUINT8();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';
            elseif size(obj.instance,2) ~= 1
                result = 'instance';
            elseif size(obj.pattern,2) ~= 1
                result = 'pattern';
            elseif size(obj.custom_len,2) ~= 1
                result = 'custom_len';
            elseif size(obj.custom_bytes,2) ~= 24
                result = 'custom_bytes';

            else
                result = 0;
            end
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
        
        function set.instance(obj,value)
            if value == uint8(value)
                obj.instance = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.pattern(obj,value)
            if value == uint8(value)
                obj.pattern = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.custom_len(obj,value)
            if value == uint8(value)
                obj.custom_len = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.custom_bytes(obj,value)
            if value == uint8(value)
                obj.custom_bytes = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end