classdef msg_gps2_raw < mavlink_message
    %MAVLINK Message Class
    %Name: gps2_raw	ID: 124
    %Description: Second GPS data. Coordinate frame is right-handed, Z-axis up (GPS frame).
            
    properties(Constant)
        ID = 124
        LEN = 35
    end
    
    properties        
		time_usec	%Timestamp (microseconds since UNIX epoch or microseconds since system boot) (uint64[1])
		lat	%Latitude (WGS84), in degrees * 1E7 (int32[1])
		lon	%Longitude (WGS84), in degrees * 1E7 (int32[1])
		alt	%Altitude (AMSL, not WGS84), in meters * 1000 (positive for up) (int32[1])
		dgps_age	%Age of DGPS info (uint32[1])
		eph	%GPS HDOP horizontal dilution of position in cm (m*100). If unknown, set to: UINT16_MAX (uint16[1])
		epv	%GPS VDOP vertical dilution of position in cm (m*100). If unknown, set to: UINT16_MAX (uint16[1])
		vel	%GPS ground speed (m/s * 100). If unknown, set to: UINT16_MAX (uint16[1])
		cog	%Course over ground (NOT heading, but direction of movement) in degrees * 100, 0.0..359.99 degrees. If unknown, set to: UINT16_MAX (uint16[1])
		fix_type	%See the GPS_FIX_TYPE enum. (uint8[1])
		satellites_visible	%Number of satellites visible. If unknown, set to 255 (uint8[1])
		dgps_numch	%Number of DGPS satellites (uint8[1])
	end

    
    methods
        
        %Constructor: msg_gps2_raw
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_gps2_raw(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
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

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
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
            
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_raw.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                    
        function set.lat(obj,value)
            if value == int32(value)
                obj.lat = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_raw.set.lat()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.lon(obj,value)
            if value == int32(value)
                obj.lon = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_raw.set.lon()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.alt(obj,value)
            if value == int32(value)
                obj.alt = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_raw.set.alt()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.dgps_age(obj,value)
            if value == uint32(value)
                obj.dgps_age = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_raw.set.dgps_age()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.eph(obj,value)
            if value == uint16(value)
                obj.eph = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_raw.set.eph()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.epv(obj,value)
            if value == uint16(value)
                obj.epv = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_raw.set.epv()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.vel(obj,value)
            if value == uint16(value)
                obj.vel = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_raw.set.vel()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.cog(obj,value)
            if value == uint16(value)
                obj.cog = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_raw.set.cog()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.fix_type(obj,value)
            if value == uint8(value)
                obj.fix_type = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_raw.set.fix_type()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.satellites_visible(obj,value)
            if value == uint8(value)
                obj.satellites_visible = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_raw.set.satellites_visible()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.dgps_numch(obj,value)
            if value == uint8(value)
                obj.dgps_numch = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_raw.set.dgps_numch()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end