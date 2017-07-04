classdef msg_gps2_raw < mavlink_message
    %MAVLINK Message Class
    %Name: gps2_raw	ID: 124
    %Description: Second GPS data. Coordinate frame is right-handed, Z-axis up (GPS frame).
            
    properties(Constant)
        ID = 124
        LEN = 35
    end
    
    properties        
		time_usec	%Timestamp (microseconds since UNIX epoch or microseconds since system boot) (uint64)
		lat	%Latitude (WGS84), in degrees * 1E7 (int32)
		lon	%Longitude (WGS84), in degrees * 1E7 (int32)
		alt	%Altitude (AMSL, not WGS84), in meters * 1000 (positive for up) (int32)
		dgps_age	%Age of DGPS info (uint32)
		eph	%GPS HDOP horizontal dilution of position in cm (m*100). If unknown, set to: UINT16_MAX (uint16)
		epv	%GPS VDOP vertical dilution of position in cm (m*100). If unknown, set to: UINT16_MAX (uint16)
		vel	%GPS ground speed (m/s * 100). If unknown, set to: UINT16_MAX (uint16)
		cog	%Course over ground (NOT heading, but direction of movement) in degrees * 100, 0.0..359.99 degrees. If unknown, set to: UINT16_MAX (uint16)
		fix_type	%See the GPS_FIX_TYPE enum. (uint8)
		satellites_visible	%Number of satellites visible. If unknown, set to 255 (uint8)
		dgps_numch	%Number of DGPS satellites (uint8)
	end
    
    methods
        
        %Constructor: msg_gps2_raw
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_gps2_raw(packet,time_usec,lat,lon,alt,dgps_age,eph,epv,vel,cog,fix_type,satellites_visible,dgps_numch)
        
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
                
            elseif nargin == 13
                
				obj.time_usec = time_usec;
				obj.lat = lat;
				obj.lon = lon;
				obj.alt = alt;
				obj.dgps_age = dgps_age;
				obj.eph = eph;
				obj.epv = epv;
				obj.vel = vel;
				obj.cog = cog;
				obj.fix_type = fix_type;
				obj.satellites_visible = satellites_visible;
				obj.dgps_numch = dgps_numch;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_gps2_raw.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_gps2_raw.ID;
                
				packet.payload.putUINT64(obj.time_usec);

				packet.payload.putINT32(obj.lat);

				packet.payload.putINT32(obj.lon);

				packet.payload.putINT32(obj.alt);

				packet.payload.putUINT32(obj.dgps_age);

				packet.payload.putUINT16(obj.eph);

				packet.payload.putUINT16(obj.epv);

				packet.payload.putUINT16(obj.vel);

				packet.payload.putUINT16(obj.cog);

				packet.payload.putUINT8(obj.fix_type);

				packet.payload.putUINT8(obj.satellites_visible);

				packet.payload.putUINT8(obj.dgps_numch);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();

			obj.lat = payload.getINT32();

			obj.lon = payload.getINT32();

			obj.alt = payload.getINT32();

			obj.dgps_age = payload.getUINT32();

			obj.eph = payload.getUINT16();

			obj.epv = payload.getUINT16();

			obj.vel = payload.getUINT16();

			obj.cog = payload.getUINT16();

			obj.fix_type = payload.getUINT8();

			obj.satellites_visible = payload.getUINT8();

			obj.dgps_numch = payload.getUINT8();

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
            elseif size(obj.dgps_age,2) ~= 1
                result = 'dgps_age';                                        
            elseif size(obj.eph,2) ~= 1
                result = 'eph';                                        
            elseif size(obj.epv,2) ~= 1
                result = 'epv';                                        
            elseif size(obj.vel,2) ~= 1
                result = 'vel';                                        
            elseif size(obj.cog,2) ~= 1
                result = 'cog';                                        
            elseif size(obj.fix_type,2) ~= 1
                result = 'fix_type';                                        
            elseif size(obj.satellites_visible,2) ~= 1
                result = 'satellites_visible';                                        
            elseif size(obj.dgps_numch,2) ~= 1
                result = 'dgps_numch';                            
            else
                result = 0;
            end
            
        end
                                
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                mavlink.throwTypeError('value','uint64');
            end
        end
                                    
        function set.lat(obj,value)
            if value == int32(value)
                obj.lat = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                                    
        function set.lon(obj,value)
            if value == int32(value)
                obj.lon = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                                    
        function set.alt(obj,value)
            if value == int32(value)
                obj.alt = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                                    
        function set.dgps_age(obj,value)
            if value == uint32(value)
                obj.dgps_age = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
                                    
        function set.eph(obj,value)
            if value == uint16(value)
                obj.eph = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.epv(obj,value)
            if value == uint16(value)
                obj.epv = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.vel(obj,value)
            if value == uint16(value)
                obj.vel = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.cog(obj,value)
            if value == uint16(value)
                obj.cog = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.fix_type(obj,value)
            if value == uint8(value)
                obj.fix_type = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.satellites_visible(obj,value)
            if value == uint8(value)
                obj.satellites_visible = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.dgps_numch(obj,value)
            if value == uint8(value)
                obj.dgps_numch = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end