classdef msg_led_control < mavlink_message
    %MAVLINK Message Class
    %Name: led_control	ID: 186
    %Description: Control vehicle LEDs
            
    properties(Constant)
        ID = 186
        LEN = 29
    end
    
    properties        
		target_system	%System ID (uint8)
		target_component	%Component ID (uint8)
		instance	%Instance (LED instance to control or 255 for all LEDs) (uint8)
		pattern	%Pattern (see LED_PATTERN_ENUM) (uint8)
		custom_len	%Custom Byte Length (uint8)
		custom_bytes	%Custom Bytes (uint8[24])
	end
    
    methods
        
        %Constructor: msg_led_control
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_led_control(packet,target_system,target_component,instance,pattern,custom_len,custom_bytes)
        
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
                
            elseif nargin == 7
                
				obj.target_system = target_system;
				obj.target_component = target_component;
				obj.instance = instance;
				obj.pattern = pattern;
				obj.custom_len = custom_len;
				obj.custom_bytes = custom_bytes;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
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
            
                for i = 1:24
                    packet.payload.putUINT8(obj.custom_bytes(i));
                end
                                        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

			obj.instance = payload.getUINT8();

			obj.pattern = payload.getUINT8();

			obj.custom_len = payload.getUINT8();
            
            for i = 1:24
                obj.custom_bytes(i) = payload.getUINT8();
            end
                            
		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.target_system,2) ~= 1
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