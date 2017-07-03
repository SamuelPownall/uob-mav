classdef msg_hil_gps < mavlink_message
    %MAVLINK Message Class
    %Name: hil_gps	ID: 113
    %Description: The global position, as returned by the Global Positioning System (GPS). This is
                 NOT the global position estimate of the sytem, but rather a RAW sensor value. See message GLOBAL_POSITION for the global position estimate. Coordinate frame is right-handed, Z-axis up (GPS frame).
            
    properties(Constant)
        ID = 113
        LEN = 36
    end
    
    properties        
		time_usec	%Timestamp (microseconds since UNIX epoch or microseconds since system boot) (uint64)
		lat	%Latitude (WGS84), in degrees * 1E7 (int32)
		lon	%Longitude (WGS84), in degrees * 1E7 (int32)
		alt	%Altitude (AMSL, not WGS84), in meters * 1000 (positive for up) (int32)
		eph	%GPS HDOP horizontal dilution of position in cm (m*100). If unknown, set to: 65535 (uint16)
		epv	%GPS VDOP vertical dilution of position in cm (m*100). If unknown, set to: 65535 (uint16)
		vel	%GPS ground speed (m/s * 100). If unknown, set to: 65535 (uint16)
		vn	%GPS velocity in cm/s in NORTH direction in earth-fixed NED frame (int16)
		ve	%GPS velocity in cm/s in EAST direction in earth-fixed NED frame (int16)
		vd	%GPS velocity in cm/s in DOWN direction in earth-fixed NED frame (int16)
		cog	%Course over ground (NOT heading, but direction of movement) in degrees * 100, 0.0..359.99 degrees. If unknown, set to: 65535 (uint16)
		fix_type	%0-1: no fix, 2: 2D fix, 3: 3D fix. Some applications will not use the value of this field unless it is at least two, so always correctly fill in the fix. (uint8)
		satellites_visible	%Number of satellites visible. If unknown, set to 255 (uint8)
	end
    
    methods
        
        %Constructor: msg_hil_gps
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_hil_gps(packet)
        
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
        
                packet = mavlink_packet(msg_hil_gps.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_hil_gps.ID;
                
				packet.payload.putUINT64(obj.time_usec);

				packet.payload.putINT32(obj.lat);

				packet.payload.putINT32(obj.lon);

				packet.payload.putINT32(obj.alt);

				packet.payload.putUINT16(obj.eph);

				packet.payload.putUINT16(obj.epv);

				packet.payload.putUINT16(obj.vel);

				packet.payload.putINT16(obj.vn);

				packet.payload.putINT16(obj.ve);

				packet.payload.putINT16(obj.vd);

				packet.payload.putUINT16(obj.cog);

				packet.payload.putUINT8(obj.fix_type);

				packet.payload.putUINT8(obj.satellites_visible);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_hil_gps.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();

			obj.lat = payload.getINT32();

			obj.lon = payload.getINT32();

			obj.alt = payload.getINT32();

			obj.eph = payload.getUINT16();

			obj.epv = payload.getUINT16();

			obj.vel = payload.getUINT16();

			obj.vn = payload.getINT16();

			obj.ve = payload.getINT16();

			obj.vd = payload.getINT16();

			obj.cog = payload.getUINT16();

			obj.fix_type = payload.getUINT8();

			obj.satellites_visible = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_usec,2) ~= 1
                result = 'time_usec';                                        
            elseif size(obj.lat,2) ~= 1
                result = 'lat';                                        
            elseif size(obj.lon,2) ~= 1
                result = 'lon';                                        
            elseif size(obj.alt,2) ~= 1
                result = 'alt';                                        
            elseif size(obj.eph,2) ~= 1
                result = 'eph';                                        
            elseif size(obj.epv,2) ~= 1
                result = 'epv';                                        
            elseif size(obj.vel,2) ~= 1
                result = 'vel';                                        
            elseif size(obj.vn,2) ~= 1
                result = 'vn';                                        
            elseif size(obj.ve,2) ~= 1
                result = 've';                                        
            elseif size(obj.vd,2) ~= 1
                result = 'vd';                                        
            elseif size(obj.cog,2) ~= 1
                result = 'cog';                                        
            elseif size(obj.fix_type,2) ~= 1
                result = 'fix_type';                                        
            elseif size(obj.satellites_visible,2) ~= 1
                result = 'satellites_visible';                            
            else
                result = 0;
            end
            
        end
                                
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_gps.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                    
        function set.lat(obj,value)
            if value == int32(value)
                obj.lat = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_gps.set.lat()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.lon(obj,value)
            if value == int32(value)
                obj.lon = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_gps.set.lon()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.alt(obj,value)
            if value == int32(value)
                obj.alt = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_gps.set.alt()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.eph(obj,value)
            if value == uint16(value)
                obj.eph = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_gps.set.eph()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.epv(obj,value)
            if value == uint16(value)
                obj.epv = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_gps.set.epv()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.vel(obj,value)
            if value == uint16(value)
                obj.vel = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_gps.set.vel()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.vn(obj,value)
            if value == int16(value)
                obj.vn = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_gps.set.vn()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.ve(obj,value)
            if value == int16(value)
                obj.ve = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_gps.set.ve()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.vd(obj,value)
            if value == int16(value)
                obj.vd = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_gps.set.vd()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.cog(obj,value)
            if value == uint16(value)
                obj.cog = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_gps.set.cog()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.fix_type(obj,value)
            if value == uint8(value)
                obj.fix_type = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_gps.set.fix_type()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.satellites_visible(obj,value)
            if value == uint8(value)
                obj.satellites_visible = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_gps.set.satellites_visible()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end