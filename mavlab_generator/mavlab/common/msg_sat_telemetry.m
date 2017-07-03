classdef msg_sat_telemetry < mavlink_message
    %MAVLINK Message Class
    %Name: sat_telemetry	ID: 180
    %Description: Custom MAVLink message for telemetry over IridiumSBD
            
    properties(Constant)
        ID = 180
        LEN = 36
    end
    
    properties        
		time	%Description of the field (uint32)
		latitude	%Description of the field (int32)
		longitude	%Description of the field (int32)
		altitude	%Description of the field (single)
		nav_distance	%Description of the field (single)
		nav_bearing	%Description of the field (uint16)
		air_speed	%Description of the field (uint16)
		bat_voltage	%Description of the field (uint16)
		bat_current	%Description of the field (uint16)
		roll	%Description of the field (int16)
		pitch	%Description of the field (int16)
		vertical_speed	%Description of the field (int16)
		gps_fixtype	%Description of the field (uint8)
		bat_percent	%Description of the field (uint8)
	end
    
    methods
        
        %Constructor: msg_sat_telemetry
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_sat_telemetry(packet)
        
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
        
                packet = mavlink_packet(msg_sat_telemetry.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_sat_telemetry.ID;
                
				packet.payload.putUINT32(obj.time);

				packet.payload.putINT32(obj.latitude);

				packet.payload.putINT32(obj.longitude);

				packet.payload.putSINGLE(obj.altitude);

				packet.payload.putSINGLE(obj.nav_distance);

				packet.payload.putUINT16(obj.nav_bearing);

				packet.payload.putUINT16(obj.air_speed);

				packet.payload.putUINT16(obj.bat_voltage);

				packet.payload.putUINT16(obj.bat_current);

				packet.payload.putINT16(obj.roll);

				packet.payload.putINT16(obj.pitch);

				packet.payload.putINT16(obj.vertical_speed);

				packet.payload.putUINT8(obj.gps_fixtype);

				packet.payload.putUINT8(obj.bat_percent);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_sat_telemetry.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time = payload.getUINT32();

			obj.latitude = payload.getINT32();

			obj.longitude = payload.getINT32();

			obj.altitude = payload.getSINGLE();

			obj.nav_distance = payload.getSINGLE();

			obj.nav_bearing = payload.getUINT16();

			obj.air_speed = payload.getUINT16();

			obj.bat_voltage = payload.getUINT16();

			obj.bat_current = payload.getUINT16();

			obj.roll = payload.getINT16();

			obj.pitch = payload.getINT16();

			obj.vertical_speed = payload.getINT16();

			obj.gps_fixtype = payload.getUINT8();

			obj.bat_percent = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time,2) ~= 1
                result = 'time';                                        
            elseif size(obj.latitude,2) ~= 1
                result = 'latitude';                                        
            elseif size(obj.longitude,2) ~= 1
                result = 'longitude';                                        
            elseif size(obj.altitude,2) ~= 1
                result = 'altitude';                                        
            elseif size(obj.nav_distance,2) ~= 1
                result = 'nav_distance';                                        
            elseif size(obj.nav_bearing,2) ~= 1
                result = 'nav_bearing';                                        
            elseif size(obj.air_speed,2) ~= 1
                result = 'air_speed';                                        
            elseif size(obj.bat_voltage,2) ~= 1
                result = 'bat_voltage';                                        
            elseif size(obj.bat_current,2) ~= 1
                result = 'bat_current';                                        
            elseif size(obj.roll,2) ~= 1
                result = 'roll';                                        
            elseif size(obj.pitch,2) ~= 1
                result = 'pitch';                                        
            elseif size(obj.vertical_speed,2) ~= 1
                result = 'vertical_speed';                                        
            elseif size(obj.gps_fixtype,2) ~= 1
                result = 'gps_fixtype';                                        
            elseif size(obj.bat_percent,2) ~= 1
                result = 'bat_percent';                            
            else
                result = 0;
            end
            
        end
                                
        function set.time(obj,value)
            if value == uint32(value)
                obj.time = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | sat_telemetry.set.time()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.latitude(obj,value)
            if value == int32(value)
                obj.latitude = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | sat_telemetry.set.latitude()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.longitude(obj,value)
            if value == int32(value)
                obj.longitude = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | sat_telemetry.set.longitude()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                
        function set.altitude(obj,value)
            obj.altitude = single(value);
        end
                                
        function set.nav_distance(obj,value)
            obj.nav_distance = single(value);
        end
                                    
        function set.nav_bearing(obj,value)
            if value == uint16(value)
                obj.nav_bearing = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | sat_telemetry.set.nav_bearing()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.air_speed(obj,value)
            if value == uint16(value)
                obj.air_speed = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | sat_telemetry.set.air_speed()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.bat_voltage(obj,value)
            if value == uint16(value)
                obj.bat_voltage = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | sat_telemetry.set.bat_voltage()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.bat_current(obj,value)
            if value == uint16(value)
                obj.bat_current = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | sat_telemetry.set.bat_current()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.roll(obj,value)
            if value == int16(value)
                obj.roll = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | sat_telemetry.set.roll()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.pitch(obj,value)
            if value == int16(value)
                obj.pitch = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | sat_telemetry.set.pitch()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.vertical_speed(obj,value)
            if value == int16(value)
                obj.vertical_speed = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | sat_telemetry.set.vertical_speed()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.gps_fixtype(obj,value)
            if value == uint8(value)
                obj.gps_fixtype = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | sat_telemetry.set.gps_fixtype()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.bat_percent(obj,value)
            if value == uint8(value)
                obj.bat_percent = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | sat_telemetry.set.bat_percent()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end