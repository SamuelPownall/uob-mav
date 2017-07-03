classdef msg_high_latency < mavlink_message
    %MAVLINK Message Class
    %Name: high_latency	ID: 234
    %Description: Message appropriate for high latency connections like Iridium
            
    properties(Constant)
        ID = 234
        LEN = 40
    end
    
    properties        
		custom_mode	%A bitfield for use for autopilot-specific flags. (uint32)
		latitude	%Latitude, expressed as degrees * 1E7 (int32)
		longitude	%Longitude, expressed as degrees * 1E7 (int32)
		roll	%roll (centidegrees) (int16)
		pitch	%pitch (centidegrees) (int16)
		heading	%heading (centidegrees) (uint16)
		heading_sp	%heading setpoint (centidegrees) (int16)
		altitude_amsl	%Altitude above mean sea level (meters) (int16)
		altitude_sp	%Altitude setpoint relative to the home position (meters) (int16)
		wp_distance	%distance to target (meters) (uint16)
		base_mode	%System mode bitfield, see MAV_MODE_FLAG ENUM in mavlink/include/mavlink_types.h (uint8)
		landed_state	%The landed state. Is set to MAV_LANDED_STATE_UNDEFINED if landed state is unknown. (uint8)
		throttle	%throttle (percentage) (int8)
		airspeed	%airspeed (m/s) (uint8)
		airspeed_sp	%airspeed setpoint (m/s) (uint8)
		groundspeed	%groundspeed (m/s) (uint8)
		climb_rate	%climb rate (m/s) (int8)
		gps_nsat	%Number of satellites visible. If unknown, set to 255 (uint8)
		gps_fix_type	%See the GPS_FIX_TYPE enum. (uint8)
		battery_remaining	%Remaining battery (percentage) (uint8)
		temperature	%Autopilot temperature (degrees C) (int8)
		temperature_air	%Air temperature (degrees C) from airspeed sensor (int8)
		failsafe	%failsafe (each bit represents a failsafe where 0=ok, 1=failsafe active (bit0:RC, bit1:batt, bit2:GPS, bit3:GCS, bit4:fence) (uint8)
		wp_num	%current waypoint number (uint8)
	end
    
    methods
        
        %Constructor: msg_high_latency
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_high_latency(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            emptyField = obj.verify();
            if emptyField == 0
        
                packet = mavlink_packet(msg_high_latency.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_high_latency.ID;
                
				packet.payload.putUINT32(obj.custom_mode);

				packet.payload.putINT32(obj.latitude);

				packet.payload.putINT32(obj.longitude);

				packet.payload.putINT16(obj.roll);

				packet.payload.putINT16(obj.pitch);

				packet.payload.putUINT16(obj.heading);

				packet.payload.putINT16(obj.heading_sp);

				packet.payload.putINT16(obj.altitude_amsl);

				packet.payload.putINT16(obj.altitude_sp);

				packet.payload.putUINT16(obj.wp_distance);

				packet.payload.putUINT8(obj.base_mode);

				packet.payload.putUINT8(obj.landed_state);

				packet.payload.putINT8(obj.throttle);

				packet.payload.putUINT8(obj.airspeed);

				packet.payload.putUINT8(obj.airspeed_sp);

				packet.payload.putUINT8(obj.groundspeed);

				packet.payload.putINT8(obj.climb_rate);

				packet.payload.putUINT8(obj.gps_nsat);

				packet.payload.putUINT8(obj.gps_fix_type);

				packet.payload.putUINT8(obj.battery_remaining);

				packet.payload.putINT8(obj.temperature);

				packet.payload.putINT8(obj.temperature_air);

				packet.payload.putUINT8(obj.failsafe);

				packet.payload.putUINT8(obj.wp_num);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_high_latency.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.custom_mode = payload.getUINT32();

			obj.latitude = payload.getINT32();

			obj.longitude = payload.getINT32();

			obj.roll = payload.getINT16();

			obj.pitch = payload.getINT16();

			obj.heading = payload.getUINT16();

			obj.heading_sp = payload.getINT16();

			obj.altitude_amsl = payload.getINT16();

			obj.altitude_sp = payload.getINT16();

			obj.wp_distance = payload.getUINT16();

			obj.base_mode = payload.getUINT8();

			obj.landed_state = payload.getUINT8();

			obj.throttle = payload.getINT8();

			obj.airspeed = payload.getUINT8();

			obj.airspeed_sp = payload.getUINT8();

			obj.groundspeed = payload.getUINT8();

			obj.climb_rate = payload.getINT8();

			obj.gps_nsat = payload.getUINT8();

			obj.gps_fix_type = payload.getUINT8();

			obj.battery_remaining = payload.getUINT8();

			obj.temperature = payload.getINT8();

			obj.temperature_air = payload.getINT8();

			obj.failsafe = payload.getUINT8();

			obj.wp_num = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.custom_mode,2) ~= 1
                result = 'custom_mode';                                        
            elseif size(obj.latitude,2) ~= 1
                result = 'latitude';                                        
            elseif size(obj.longitude,2) ~= 1
                result = 'longitude';                                        
            elseif size(obj.roll,2) ~= 1
                result = 'roll';                                        
            elseif size(obj.pitch,2) ~= 1
                result = 'pitch';                                        
            elseif size(obj.heading,2) ~= 1
                result = 'heading';                                        
            elseif size(obj.heading_sp,2) ~= 1
                result = 'heading_sp';                                        
            elseif size(obj.altitude_amsl,2) ~= 1
                result = 'altitude_amsl';                                        
            elseif size(obj.altitude_sp,2) ~= 1
                result = 'altitude_sp';                                        
            elseif size(obj.wp_distance,2) ~= 1
                result = 'wp_distance';                                        
            elseif size(obj.base_mode,2) ~= 1
                result = 'base_mode';                                        
            elseif size(obj.landed_state,2) ~= 1
                result = 'landed_state';                                        
            elseif size(obj.throttle,2) ~= 1
                result = 'throttle';                                        
            elseif size(obj.airspeed,2) ~= 1
                result = 'airspeed';                                        
            elseif size(obj.airspeed_sp,2) ~= 1
                result = 'airspeed_sp';                                        
            elseif size(obj.groundspeed,2) ~= 1
                result = 'groundspeed';                                        
            elseif size(obj.climb_rate,2) ~= 1
                result = 'climb_rate';                                        
            elseif size(obj.gps_nsat,2) ~= 1
                result = 'gps_nsat';                                        
            elseif size(obj.gps_fix_type,2) ~= 1
                result = 'gps_fix_type';                                        
            elseif size(obj.battery_remaining,2) ~= 1
                result = 'battery_remaining';                                        
            elseif size(obj.temperature,2) ~= 1
                result = 'temperature';                                        
            elseif size(obj.temperature_air,2) ~= 1
                result = 'temperature_air';                                        
            elseif size(obj.failsafe,2) ~= 1
                result = 'failsafe';                                        
            elseif size(obj.wp_num,2) ~= 1
                result = 'wp_num';                            
            else
                result = 0;
            end
            
        end
                                
        function set.custom_mode(obj,value)
            if value == uint32(value)
                obj.custom_mode = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.custom_mode()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.latitude(obj,value)
            if value == int32(value)
                obj.latitude = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.latitude()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.longitude(obj,value)
            if value == int32(value)
                obj.longitude = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.longitude()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.roll(obj,value)
            if value == int16(value)
                obj.roll = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.roll()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.pitch(obj,value)
            if value == int16(value)
                obj.pitch = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.pitch()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.heading(obj,value)
            if value == uint16(value)
                obj.heading = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.heading()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.heading_sp(obj,value)
            if value == int16(value)
                obj.heading_sp = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.heading_sp()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.altitude_amsl(obj,value)
            if value == int16(value)
                obj.altitude_amsl = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.altitude_amsl()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.altitude_sp(obj,value)
            if value == int16(value)
                obj.altitude_sp = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.altitude_sp()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.wp_distance(obj,value)
            if value == uint16(value)
                obj.wp_distance = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.wp_distance()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.base_mode(obj,value)
            if value == uint8(value)
                obj.base_mode = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.base_mode()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.landed_state(obj,value)
            if value == uint8(value)
                obj.landed_state = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.landed_state()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.throttle(obj,value)
            if value == int8(value)
                obj.throttle = int8(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.throttle()\n\t Input "value" is not of type "int8"\n');
            end
        end
                                    
        function set.airspeed(obj,value)
            if value == uint8(value)
                obj.airspeed = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.airspeed()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.airspeed_sp(obj,value)
            if value == uint8(value)
                obj.airspeed_sp = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.airspeed_sp()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.groundspeed(obj,value)
            if value == uint8(value)
                obj.groundspeed = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.groundspeed()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.climb_rate(obj,value)
            if value == int8(value)
                obj.climb_rate = int8(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.climb_rate()\n\t Input "value" is not of type "int8"\n');
            end
        end
                                    
        function set.gps_nsat(obj,value)
            if value == uint8(value)
                obj.gps_nsat = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.gps_nsat()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.gps_fix_type(obj,value)
            if value == uint8(value)
                obj.gps_fix_type = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.gps_fix_type()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.battery_remaining(obj,value)
            if value == uint8(value)
                obj.battery_remaining = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.battery_remaining()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.temperature(obj,value)
            if value == int8(value)
                obj.temperature = int8(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.temperature()\n\t Input "value" is not of type "int8"\n');
            end
        end
                                    
        function set.temperature_air(obj,value)
            if value == int8(value)
                obj.temperature_air = int8(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.temperature_air()\n\t Input "value" is not of type "int8"\n');
            end
        end
                                    
        function set.failsafe(obj,value)
            if value == uint8(value)
                obj.failsafe = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.failsafe()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.wp_num(obj,value)
            if value == uint8(value)
                obj.wp_num = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | high_latency.set.wp_num()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end