classdef msg_sys_status < mavlink_message
    %MAVLINK Message Class
    %Name: sys_status	ID: 1
    %Description: The general system state. If the system is following the MAVLink standard, the system state is mainly defined by three orthogonal states/modes: The system mode, which is either LOCKED (motors shut down and locked), MANUAL (system under RC control), GUIDED (system with autonomous position control, position setpoint controlled manually) or AUTO (system guided by path/waypoint planner). The NAV_MODE defined the current flight state: LIFTOFF (often an open-loop maneuver), LANDING, WAYPOINTS or VECTOR. This represents the internal navigation state machine. The system status shows wether the system is currently active or not and if an emergency occured. During the CRITICAL and EMERGENCY states the MAV is still considered to be active, but should start emergency procedures autonomously. After a failure occured it should first move from active to critical to allow manual intervention and then move to emergency after a certain timeout.
            
    properties(Constant)
        ID = 1
        LEN = 31
    end
    
    properties        
		onboard_control_sensors_present	%Bitmask showing which onboard controllers and sensors are present. Value of 0: not present. Value of 1: present. Indices defined by ENUM MAV_SYS_STATUS_SENSOR (uint32[1])
		onboard_control_sensors_enabled	%Bitmask showing which onboard controllers and sensors are enabled:  Value of 0: not enabled. Value of 1: enabled. Indices defined by ENUM MAV_SYS_STATUS_SENSOR (uint32[1])
		onboard_control_sensors_health	%Bitmask showing which onboard controllers and sensors are operational or have an error:  Value of 0: not enabled. Value of 1: enabled. Indices defined by ENUM MAV_SYS_STATUS_SENSOR (uint32[1])
		load	%Maximum usage in percent of the mainloop time, (0%: 0, 100%: 1000) should be always below 1000 (uint16[1])
		voltage_battery	%Battery voltage, in millivolts (1 = 1 millivolt) (uint16[1])
		current_battery	%Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current (int16[1])
		drop_rate_comm	%Communication drops in percent, (0%: 0, 100%: 10'000), (UART, I2C, SPI, CAN), dropped packets on all links (packets that were corrupted on reception on the MAV) (uint16[1])
		errors_comm	%Communication errors (UART, I2C, SPI, CAN), dropped packets on all links (packets that were corrupted on reception on the MAV) (uint16[1])
		errors_count1	%Autopilot-specific errors (uint16[1])
		errors_count2	%Autopilot-specific errors (uint16[1])
		errors_count3	%Autopilot-specific errors (uint16[1])
		errors_count4	%Autopilot-specific errors (uint16[1])
		battery_remaining	%Remaining battery energy: (0%: 0, 100%: 100), -1: autopilot estimate the remaining battery (int8[1])
	end

    
    methods
        
        %Constructor: msg_sys_status
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_sys_status(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
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

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
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
            
        function set.onboard_control_sensors_present(obj,value)
            if value == uint32(value)
                obj.onboard_control_sensors_present = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | sys_status.set.onboard_control_sensors_present()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.onboard_control_sensors_enabled(obj,value)
            if value == uint32(value)
                obj.onboard_control_sensors_enabled = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | sys_status.set.onboard_control_sensors_enabled()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.onboard_control_sensors_health(obj,value)
            if value == uint32(value)
                obj.onboard_control_sensors_health = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | sys_status.set.onboard_control_sensors_health()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.load(obj,value)
            if value == uint16(value)
                obj.load = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | sys_status.set.load()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.voltage_battery(obj,value)
            if value == uint16(value)
                obj.voltage_battery = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | sys_status.set.voltage_battery()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.current_battery(obj,value)
            if value == int16(value)
                obj.current_battery = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | sys_status.set.current_battery()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.drop_rate_comm(obj,value)
            if value == uint16(value)
                obj.drop_rate_comm = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | sys_status.set.drop_rate_comm()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.errors_comm(obj,value)
            if value == uint16(value)
                obj.errors_comm = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | sys_status.set.errors_comm()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.errors_count1(obj,value)
            if value == uint16(value)
                obj.errors_count1 = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | sys_status.set.errors_count1()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.errors_count2(obj,value)
            if value == uint16(value)
                obj.errors_count2 = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | sys_status.set.errors_count2()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.errors_count3(obj,value)
            if value == uint16(value)
                obj.errors_count3 = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | sys_status.set.errors_count3()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.errors_count4(obj,value)
            if value == uint16(value)
                obj.errors_count4 = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | sys_status.set.errors_count4()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.battery_remaining(obj,value)
            if value == int8(value)
                obj.battery_remaining = int8(value);
            else
                fprintf(2,'MAVLAB-ERROR | sys_status.set.battery_remaining()\n\t Input "value" is not of type "int8"\n');
            end
        end
                        
	end
end