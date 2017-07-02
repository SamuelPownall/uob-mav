classdef msg_global_position_int < mavlink_message
    %MAVLINK Message Class
    %Name: global_position_int	ID: 33
    %Description: The filtered global position (e.g. fused GPS and accelerometers). The position is in GPS-frame (right-handed, Z-up). It
               is designed as scaled integer message since the resolution of float is not sufficient.
            
    properties(Constant)
        ID = 33
        LEN = 28
    end
    
    properties        
		time_boot_ms	%Timestamp (milliseconds since system boot) (uint32[1])
		lat	%Latitude, expressed as degrees * 1E7 (int32[1])
		lon	%Longitude, expressed as degrees * 1E7 (int32[1])
		alt	%Altitude in meters, expressed as * 1000 (millimeters), AMSL (not WGS84 - note that virtually all GPS modules provide the AMSL as well) (int32[1])
		relative_alt	%Altitude above ground in meters, expressed as * 1000 (millimeters) (int32[1])
		vx	%Ground X Speed (Latitude, positive north), expressed as m/s * 100 (int16[1])
		vy	%Ground Y Speed (Longitude, positive east), expressed as m/s * 100 (int16[1])
		vz	%Ground Z Speed (Altitude, positive down), expressed as m/s * 100 (int16[1])
		hdg	%Vehicle heading (yaw angle) in degrees * 100, 0.0..359.99 degrees. If unknown, set to: UINT16_MAX (uint16[1])
	end

    
    methods
        
        %Constructor: msg_global_position_int
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_global_position_int(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_global_position_int.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_global_position_int.ID;
                
			packet.payload.putUINT32(obj.time_boot_ms);

			packet.payload.putINT32(obj.lat);

			packet.payload.putINT32(obj.lon);

			packet.payload.putINT32(obj.alt);

			packet.payload.putINT32(obj.relative_alt);

			packet.payload.putINT16(obj.vx);

			packet.payload.putINT16(obj.vy);

			packet.payload.putINT16(obj.vz);

			packet.payload.putUINT16(obj.hdg);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_boot_ms = payload.getUINT32();

			obj.lat = payload.getINT32();

			obj.lon = payload.getINT32();

			obj.alt = payload.getINT32();

			obj.relative_alt = payload.getINT32();

			obj.vx = payload.getINT16();

			obj.vy = payload.getINT16();

			obj.vz = payload.getINT16();

			obj.hdg = payload.getUINT16();

		end
            
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | global_position_int.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.lat(obj,value)
            if value == int32(value)
                obj.lat = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | global_position_int.set.lat()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.lon(obj,value)
            if value == int32(value)
                obj.lon = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | global_position_int.set.lon()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.alt(obj,value)
            if value == int32(value)
                obj.alt = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | global_position_int.set.alt()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.relative_alt(obj,value)
            if value == int32(value)
                obj.relative_alt = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | global_position_int.set.relative_alt()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.vx(obj,value)
            if value == int16(value)
                obj.vx = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | global_position_int.set.vx()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.vy(obj,value)
            if value == int16(value)
                obj.vy = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | global_position_int.set.vy()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.vz(obj,value)
            if value == int16(value)
                obj.vz = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | global_position_int.set.vz()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.hdg(obj,value)
            if value == uint16(value)
                obj.hdg = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | global_position_int.set.hdg()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                        
	end
end