classdef msg_sys_status < mavlink_message
    %MAVLINK Message Class
    %Name: sys_status	ID: 1
    %Description: The general system state. If the system is following the MAVLink standard, the system state is mainly defined by three orthogonal states/modes: The system mode, which is either LOCKED (motors shut down and locked), MANUAL (system under RC control), GUIDED (system with autonomous position control, position setpoint controlled manually) or AUTO (system guided by path/waypoint planner). The NAV_MODE defined the current flight state: LIFTOFF (often an open-loop maneuver), LANDING, WAYPOINTS or VECTOR. This represents the internal navigation state machine. The system status shows wether the system is currently active or not and if an emergency occured. During the CRITICAL and EMERGENCY states the MAV is still considered to be active, but should start emergency procedures autonomously. After a failure occured it should first move from active to critical to allow manual intervention and then move to emergency after a certain timeout.
            
    properties(Constant)
        ID = 1
        LEN = 31
    end
    
    properties        
		onboard_control_sensors_present	%Bitmask showing which onboard controllers and sensors are present. Value of 0: not present. Value of 1: present. Indices defined by ENUM MAV_SYS_STATUS_SENSOR (uint32)
		onboard_control_sensors_enabled	%Bitmask showing which onboard controllers and sensors are enabled:  Value of 0: not enabled. Value of 1: enabled. Indices defined by ENUM MAV_SYS_STATUS_SENSOR (uint32)
		onboard_control_sensors_health	%Bitmask showing which onboard controllers and sensors are operational or have an error:  Value of 0: not enabled. Value of 1: enabled. Indices defined by ENUM MAV_SYS_STATUS_SENSOR (uint32)
		load	%Maximum usage in percent of the mainloop time, (0%: 0, 100%: 1000) should be always below 1000 (uint16)
		voltage_battery	%Battery voltage, in millivolts (1 = 1 millivolt) (uint16)
		current_battery	%Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current (int16)
		drop_rate_comm	%Communication drops in percent, (0%: 0, 100%: 10'000), (UART, I2C, SPI, CAN), dropped packets on all links (packets that were corrupted on reception on the MAV) (uint16)
		errors_comm	%Communication errors (UART, I2C, SPI, CAN), dropped packets on all links (packets that were corrupted on reception on the MAV) (uint16)
		errors_count1	%Autopilot-specific errors (uint16)
		errors_count2	%Autopilot-specific errors (uint16)
		errors_count3	%Autopilot-specific errors (uint16)
		errors_count4	%Autopilot-specific errors (uint16)
		battery_remaining	%Remaining battery energy: (0%: 0, 100%: 100), -1: autopilot estimate the remaining battery (int8)
	end
    
    methods
        
        %Constructor: msg_sys_status
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_sys_status(packet,onboard_control_sensors_present,onboard_control_sensors_enabled,onboard_control_sensors_health,load,voltage_battery,current_battery,drop_rate_comm,errors_comm,errors_count1,errors_count2,errors_count3,errors_count4,battery_remaining)
        
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
                
            elseif nargin == 14
                
				obj.onboard_control_sensors_present = onboard_control_sensors_present;
				obj.onboard_control_sensors_enabled = onboard_control_sensors_enabled;
				obj.onboard_control_sensors_health = onboard_control_sensors_health;
				obj.load = load;
				obj.voltage_battery = voltage_battery;
				obj.current_battery = current_battery;
				obj.drop_rate_comm = drop_rate_comm;
				obj.errors_comm = errors_comm;
				obj.errors_count1 = errors_count1;
				obj.errors_count2 = errors_count2;
				obj.errors_count3 = errors_count3;
				obj.errors_count4 = errors_count4;
				obj.battery_remaining = battery_remaining;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_sys_status.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_sys_status.ID;
                
				packet.payload.putUINT32(obj.onboard_control_sensors_present);

				packet.payload.putUINT32(obj.onboard_control_sensors_enabled);

				packet.payload.putUINT32(obj.onboard_control_sensors_health);

				packet.payload.putUINT16(obj.load);

				packet.payload.putUINT16(obj.voltage_battery);

				packet.payload.putINT16(obj.current_battery);

				packet.payload.putUINT16(obj.drop_rate_comm);

				packet.payload.putUINT16(obj.errors_comm);

				packet.payload.putUINT16(obj.errors_count1);

				packet.payload.putUINT16(obj.errors_count2);

				packet.payload.putUINT16(obj.errors_count3);

				packet.payload.putUINT16(obj.errors_count4);

				packet.payload.putINT8(obj.battery_remaining);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.onboard_control_sensors_present = payload.getUINT32();

			obj.onboard_control_sensors_enabled = payload.getUINT32();

			obj.onboard_control_sensors_health = payload.getUINT32();

			obj.load = payload.getUINT16();

			obj.voltage_battery = payload.getUINT16();

			obj.current_battery = payload.getINT16();

			obj.drop_rate_comm = payload.getUINT16();

			obj.errors_comm = payload.getUINT16();

			obj.errors_count1 = payload.getUINT16();

			obj.errors_count2 = payload.getUINT16();

			obj.errors_count3 = payload.getUINT16();

			obj.errors_count4 = payload.getUINT16();

			obj.battery_remaining = payload.getINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.onboard_control_sensors_present,2) ~= 1
                result = 'onboard_control_sensors_present';                                        
            elseif size(obj.onboard_control_sensors_enabled,2) ~= 1
                result = 'onboard_control_sensors_enabled';                                        
            elseif size(obj.onboard_control_sensors_health,2) ~= 1
                result = 'onboard_control_sensors_health';                                        
            elseif size(obj.load,2) ~= 1
                result = 'load';                                        
            elseif size(obj.voltage_battery,2) ~= 1
                result = 'voltage_battery';                                        
            elseif size(obj.current_battery,2) ~= 1
                result = 'current_battery';                                        
            elseif size(obj.drop_rate_comm,2) ~= 1
                result = 'drop_rate_comm';                                        
            elseif size(obj.errors_comm,2) ~= 1
                result = 'errors_comm';                                        
            elseif size(obj.errors_count1,2) ~= 1
                result = 'errors_count1';                                        
            elseif size(obj.errors_count2,2) ~= 1
                result = 'errors_count2';                                        
            elseif size(obj.errors_count3,2) ~= 1
                result = 'errors_count3';                                        
            elseif size(obj.errors_count4,2) ~= 1
                result = 'errors_count4';                                        
            elseif size(obj.battery_remaining,2) ~= 1
                result = 'battery_remaining';                            
            else
                result = 0;
            end
            
        end
                                
        function set.onboard_control_sensors_present(obj,value)
            if value == uint32(value)
                obj.onboard_control_sensors_present = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
                                    
        function set.onboard_control_sensors_enabled(obj,value)
            if value == uint32(value)
                obj.onboard_control_sensors_enabled = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
                                    
        function set.onboard_control_sensors_health(obj,value)
            if value == uint32(value)
                obj.onboard_control_sensors_health = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
                                    
        function set.load(obj,value)
            if value == uint16(value)
                obj.load = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.voltage_battery(obj,value)
            if value == uint16(value)
                obj.voltage_battery = uint16(value);
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
                                    
        function set.drop_rate_comm(obj,value)
            if value == uint16(value)
                obj.drop_rate_comm = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.errors_comm(obj,value)
            if value == uint16(value)
                obj.errors_comm = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.errors_count1(obj,value)
            if value == uint16(value)
                obj.errors_count1 = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.errors_count2(obj,value)
            if value == uint16(value)
                obj.errors_count2 = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.errors_count3(obj,value)
            if value == uint16(value)
                obj.errors_count3 = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.errors_count4(obj,value)
            if value == uint16(value)
                obj.errors_count4 = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
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