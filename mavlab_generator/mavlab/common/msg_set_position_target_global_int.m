classdef msg_set_position_target_global_int < mavlink_message
    %MAVLINK Message Class
    %Name: set_position_target_global_int	ID: 86
    %Description: Sets a desired vehicle position, velocity, and/or acceleration in a global coordinate system (WGS84). Used by an external controller to command the vehicle (manual controller or other system).
            
    properties(Constant)
        ID = 86
        LEN = 53
    end
    
    properties        
		time_boot_ms	%Timestamp in milliseconds since system boot. The rationale for the timestamp in the setpoint is to allow the system to compensate for the transport delay of the setpoint. This allows the system to compensate processing latency. (uint32[1])
		lat_int	%X Position in WGS84 frame in 1e7 * meters (int32[1])
		lon_int	%Y Position in WGS84 frame in 1e7 * meters (int32[1])
		alt	%Altitude in meters in AMSL altitude, not WGS84 if absolute or relative, above terrain if GLOBAL_TERRAIN_ALT_INT (single[1])
		vx	%X velocity in NED frame in meter / s (single[1])
		vy	%Y velocity in NED frame in meter / s (single[1])
		vz	%Z velocity in NED frame in meter / s (single[1])
		afx	%X acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N (single[1])
		afy	%Y acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N (single[1])
		afz	%Z acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N (single[1])
		yaw	%yaw setpoint in rad (single[1])
		yaw_rate	%yaw rate setpoint in rad/s (single[1])
		type_mask	%Bitmask to indicate which dimensions should be ignored by the vehicle: a value of 0b0000000000000000 or 0b0000001000000000 indicates that none of the setpoint dimensions should be ignored. If bit 10 is set the floats afx afy afz should be interpreted as force instead of acceleration. Mapping: bit 1: x, bit 2: y, bit 3: z, bit 4: vx, bit 5: vy, bit 6: vz, bit 7: ax, bit 8: ay, bit 9: az, bit 10: is force setpoint, bit 11: yaw, bit 12: yaw rate (uint16[1])
		target_system	%System ID (uint8[1])
		target_component	%Component ID (uint8[1])
		coordinate_frame	%Valid options are: MAV_FRAME_GLOBAL_INT = 5, MAV_FRAME_GLOBAL_RELATIVE_ALT_INT = 6, MAV_FRAME_GLOBAL_TERRAIN_ALT_INT = 11 (uint8[1])
	end

    
    methods
        
        %Constructor: msg_set_position_target_global_int
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_set_position_target_global_int(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_set_position_target_global_int.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_set_position_target_global_int.ID;
                
			packet.payload.putUINT32(obj.time_boot_ms);

			packet.payload.putINT32(obj.lat_int);

			packet.payload.putINT32(obj.lon_int);

			packet.payload.putSINGLE(obj.alt);

			packet.payload.putSINGLE(obj.vx);

			packet.payload.putSINGLE(obj.vy);

			packet.payload.putSINGLE(obj.vz);

			packet.payload.putSINGLE(obj.afx);

			packet.payload.putSINGLE(obj.afy);

			packet.payload.putSINGLE(obj.afz);

			packet.payload.putSINGLE(obj.yaw);

			packet.payload.putSINGLE(obj.yaw_rate);

			packet.payload.putUINT16(obj.type_mask);

			packet.payload.putUINT8(obj.target_system);

			packet.payload.putUINT8(obj.target_component);

			packet.payload.putUINT8(obj.coordinate_frame);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_boot_ms = payload.getUINT32();

			obj.lat_int = payload.getINT32();

			obj.lon_int = payload.getINT32();

			obj.alt = payload.getSINGLE();

			obj.vx = payload.getSINGLE();

			obj.vy = payload.getSINGLE();

			obj.vz = payload.getSINGLE();

			obj.afx = payload.getSINGLE();

			obj.afy = payload.getSINGLE();

			obj.afz = payload.getSINGLE();

			obj.yaw = payload.getSINGLE();

			obj.yaw_rate = payload.getSINGLE();

			obj.type_mask = payload.getUINT16();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

			obj.coordinate_frame = payload.getUINT8();

		end
            
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | set_position_target_global_int.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.lat_int(obj,value)
            if value == int32(value)
                obj.lat_int = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | set_position_target_global_int.set.lat_int()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.lon_int(obj,value)
            if value == int32(value)
                obj.lon_int = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | set_position_target_global_int.set.lon_int()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                
        function set.alt(obj,value)
            obj.alt = single(value);
        end
                                
        function set.vx(obj,value)
            obj.vx = single(value);
        end
                                
        function set.vy(obj,value)
            obj.vy = single(value);
        end
                                
        function set.vz(obj,value)
            obj.vz = single(value);
        end
                                
        function set.afx(obj,value)
            obj.afx = single(value);
        end
                                
        function set.afy(obj,value)
            obj.afy = single(value);
        end
                                
        function set.afz(obj,value)
            obj.afz = single(value);
        end
                                
        function set.yaw(obj,value)
            obj.yaw = single(value);
        end
                                
        function set.yaw_rate(obj,value)
            obj.yaw_rate = single(value);
        end
                                    
        function set.type_mask(obj,value)
            if value == uint16(value)
                obj.type_mask = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | set_position_target_global_int.set.type_mask()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | set_position_target_global_int.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | set_position_target_global_int.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.coordinate_frame(obj,value)
            if value == uint8(value)
                obj.coordinate_frame = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | set_position_target_global_int.set.coordinate_frame()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end