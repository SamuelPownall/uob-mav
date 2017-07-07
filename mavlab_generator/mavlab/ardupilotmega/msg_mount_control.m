classdef msg_mount_control < mavlink_message
    %MAVLINK Message Class
    %Name: mount_control	ID: 157
    %Description: Message to control a camera mount, directional antenna, etc.
            
    properties(Constant)
        ID = 157
        LEN = 15
    end
    
    properties        
		input_a	%pitch(deg*100) or lat, depending on mount mode (int32)
		input_b	%roll(deg*100) or lon depending on mount mode (int32)
		input_c	%yaw(deg*100) or alt (in cm) depending on mount mode (int32)
		target_system	%System ID (uint8)
		target_component	%Component ID (uint8)
		save_position	%if "1" it will save current trimmed position on EEPROM (just valid for NEUTRAL and LANDING) (uint8)
	end
    
    methods
        
        %Constructor: msg_mount_control
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_mount_control(packet,input_a,input_b,input_c,target_system,target_component,save_position)
        
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
                
				obj.input_a = input_a;
				obj.input_b = input_b;
				obj.input_c = input_c;
				obj.target_system = target_system;
				obj.target_component = target_component;
				obj.save_position = save_position;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_mount_control.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_mount_control.ID;
                
				packet.payload.putINT32(obj.input_a);

				packet.payload.putINT32(obj.input_b);

				packet.payload.putINT32(obj.input_c);

				packet.payload.putUINT8(obj.target_system);

				packet.payload.putUINT8(obj.target_component);

				packet.payload.putUINT8(obj.save_position);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.input_a = payload.getINT32();

			obj.input_b = payload.getINT32();

			obj.input_c = payload.getINT32();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

			obj.save_position = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.input_a,2) ~= 1
                result = 'input_a';                                        
            elseif size(obj.input_b,2) ~= 1
                result = 'input_b';                                        
            elseif size(obj.input_c,2) ~= 1
                result = 'input_c';                                        
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';                                        
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';                                        
            elseif size(obj.save_position,2) ~= 1
                result = 'save_position';                            
            else
                result = 0;
            end
            
        end
                                
        function set.input_a(obj,value)
            if value == int32(value)
                obj.input_a = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                                    
        function set.input_b(obj,value)
            if value == int32(value)
                obj.input_b = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                                    
        function set.input_c(obj,value)
            if value == int32(value)
                obj.input_c = int32(value);
            else
                mavlink.throwTypeError('value','int32');
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
                                    
        function set.save_position(obj,value)
            if value == uint8(value)
                obj.save_position = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end