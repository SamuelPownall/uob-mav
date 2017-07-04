classdef msg_battery_status < mavlink_message
    %MAVLINK Message Class
    %Name: battery_status	ID: 147
    %Description: Battery information
            
    properties(Constant)
        ID = 147
        LEN = 36
    end
    
    properties        
		current_consumed	%Consumed charge, in milliampere hours (1 = 1 mAh), -1: autopilot does not provide mAh consumption estimate (int32)
		energy_consumed	%Consumed energy, in 100*Joules (intergrated U*I*dt)  (1 = 100 Joule), -1: autopilot does not provide energy consumption estimate (int32)
		temperature	%Temperature of the battery in centi-degrees celsius. INT16_MAX for unknown temperature. (int16)
		voltages	%Battery voltage of cells, in millivolts (1 = 1 millivolt). Cells above the valid cell count for this battery should have the UINT16_MAX value. (uint16[10])
		current_battery	%Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current (int16)
		id	%Battery ID (uint8)
		battery_function	%Function of the battery (uint8)
		type	%Type (chemistry) of the battery (uint8)
		battery_remaining	%Remaining battery energy: (0%: 0, 100%: 100), -1: autopilot does not estimate the remaining battery (int8)
	end
    
    methods
        
        %Constructor: msg_battery_status
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_battery_status(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_battery_status.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_battery_status.ID;
                
				packet.payload.putINT32(obj.current_consumed);

				packet.payload.putINT32(obj.energy_consumed);

				packet.payload.putINT16(obj.temperature);
            
                for i = 1:10
                    packet.payload.putUINT16(obj.voltages(i));
                end
                                
				packet.payload.putINT16(obj.current_battery);

				packet.payload.putUINT8(obj.id);

				packet.payload.putUINT8(obj.battery_function);

				packet.payload.putUINT8(obj.type);

				packet.payload.putINT8(obj.battery_remaining);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.current_consumed = payload.getINT32();

			obj.energy_consumed = payload.getINT32();

			obj.temperature = payload.getINT16();
            
            for i = 1:10
                obj.voltages(i) = payload.getUINT16();
            end
                            
			obj.current_battery = payload.getINT16();

			obj.id = payload.getUINT8();

			obj.battery_function = payload.getUINT8();

			obj.type = payload.getUINT8();

			obj.battery_remaining = payload.getINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.current_consumed,2) ~= 1
                result = 'current_consumed';                                        
            elseif size(obj.energy_consumed,2) ~= 1
                result = 'energy_consumed';                                        
            elseif size(obj.temperature,2) ~= 1
                result = 'temperature';                                        
            elseif size(obj.voltages,2) ~= 10
                result = 'voltages';                                        
            elseif size(obj.current_battery,2) ~= 1
                result = 'current_battery';                                        
            elseif size(obj.id,2) ~= 1
                result = 'id';                                        
            elseif size(obj.battery_function,2) ~= 1
                result = 'battery_function';                                        
            elseif size(obj.type,2) ~= 1
                result = 'type';                                        
            elseif size(obj.battery_remaining,2) ~= 1
                result = 'battery_remaining';                            
            else
                result = 0;
            end
            
        end
                                
        function set.current_consumed(obj,value)
            if value == int32(value)
                obj.current_consumed = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                                    
        function set.energy_consumed(obj,value)
            if value == int32(value)
                obj.energy_consumed = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                                    
        function set.temperature(obj,value)
            if value == int16(value)
                obj.temperature = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
                                    
        function set.voltages(obj,value)
            if value == uint16(value)
                obj.voltages = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.current_battery(obj,value)
            if value == int16(value)
                obj.current_battery = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
                                    
        function set.id(obj,value)
            if value == uint8(value)
                obj.id = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.battery_function(obj,value)
            if value == uint8(value)
                obj.battery_function = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.type(obj,value)
            if value == uint8(value)
                obj.type = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.battery_remaining(obj,value)
            if value == int8(value)
                obj.battery_remaining = int8(value);
            else
                mavlink.throwTypeError('value','int8');
            end
        end
                        
	end
end