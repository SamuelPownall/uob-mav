classdef msg_led_control < mavlink_message
	%MSG_LED_CONTROL: MAVLINK Message ID = 186
    %Description:
    %    Control vehicle LEDs
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    target_system(mavlink_packet): Alternative way to construct a message using a mavlink_packet
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

    methods

        function obj = msg_led_control(target_system,target_component,instance,pattern,custom_len,custom_bytes,varargin)
        %Create a new led_control message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(target_system,'mavlink_packet')
                    packet = target_system;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('target_system','mavlink_packet');
                end
            
            elseif nargin == 6
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.instance = instance;
                obj.pattern = pattern;
                obj.custom_len = custom_len;
                obj.custom_bytes = custom_bytes;
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

                packet = mavlink_packet(msg_led_control.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
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
        
        function set.instance(obj,value)
            if value == uint8(value)
                obj.instance = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.pattern(obj,value)
            if value == uint8(value)
                obj.pattern = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.custom_len(obj,value)
            if value == uint8(value)
                obj.custom_len = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.custom_bytes(obj,value)
            if value == uint8(value)
                obj.custom_bytes = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end