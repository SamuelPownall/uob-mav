classdef msg_position_target_local_ned < mavlink_message
    %MAVLINK Message Class
    %Name: position_target_local_ned	ID: 85
    %Description: Reports the current commanded vehicle position, velocity, and acceleration as specified by the autopilot. This should match the commands sent in SET_POSITION_TARGET_LOCAL_NED if the vehicle is being controlled this way.
            
    properties(Constant)
        ID = 85
        LEN = 51
    end
    
    properties        
		time_boot_ms	%Timestamp in milliseconds since system boot (uint32[1])
		x	%X Position in NED frame in meters (single[1])
		y	%Y Position in NED frame in meters (single[1])
		z	%Z Position in NED frame in meters (note, altitude is negative in NED) (single[1])
		vx	%X velocity in NED frame in meter / s (single[1])
		vy	%Y velocity in NED frame in meter / s (single[1])
		vz	%Z velocity in NED frame in meter / s (single[1])
		afx	%X acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N (single[1])
		afy	%Y acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N (single[1])
		afz	%Z acceleration or force (if bit 10 of type_mask is set) in NED frame in meter / s^2 or N (single[1])
		yaw	%yaw setpoint in rad (single[1])
		yaw_rate	%yaw rate setpoint in rad/s (single[1])
		type_mask	%Bitmask to indicate which dimensions should be ignored by the vehicle: a value of 0b0000000000000000 or 0b0000001000000000 indicates that none of the setpoint dimensions should be ignored. If bit 10 is set the floats afx afy afz should be interpreted as force instead of acceleration. Mapping: bit 1: x, bit 2: y, bit 3: z, bit 4: vx, bit 5: vy, bit 6: vz, bit 7: ax, bit 8: ay, bit 9: az, bit 10: is force setpoint, bit 11: yaw, bit 12: yaw rate (uint16[1])
		coordinate_frame	%Valid options are: MAV_FRAME_LOCAL_NED = 1, MAV_FRAME_LOCAL_OFFSET_NED = 7, MAV_FRAME_BODY_NED = 8, MAV_FRAME_BODY_OFFSET_NED = 9 (uint8[1])
	end

    
    methods
        
        %Constructor: msg_position_target_local_ned
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_position_target_local_ned(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_position_target_local_ned.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_position_target_local_ned.ID;
                
			packet.payload.putUINT32(obj.time_boot_ms);

			packet.payload.putSINGLE(obj.x);

			packet.payload.putSINGLE(obj.y);

			packet.payload.putSINGLE(obj.z);

			packet.payload.putSINGLE(obj.vx);

			packet.payload.putSINGLE(obj.vy);

			packet.payload.putSINGLE(obj.vz);

			packet.payload.putSINGLE(obj.afx);

			packet.payload.putSINGLE(obj.afy);

			packet.payload.putSINGLE(obj.afz);

			packet.payload.putSINGLE(obj.yaw);

			packet.payload.putSINGLE(obj.yaw_rate);

			packet.payload.putUINT16(obj.type_mask);

			packet.payload.putUINT8(obj.coordinate_frame);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_boot_ms = payload.getUINT32();

			obj.x = payload.getSINGLE();

			obj.y = payload.getSINGLE();

			obj.z = payload.getSINGLE();

			obj.vx = payload.getSINGLE();

			obj.vy = payload.getSINGLE();

			obj.vz = payload.getSINGLE();

			obj.afx = payload.getSINGLE();

			obj.afy = payload.getSINGLE();

			obj.afz = payload.getSINGLE();

			obj.yaw = payload.getSINGLE();

			obj.yaw_rate = payload.getSINGLE();

			obj.type_mask = payload.getUINT16();

			obj.coordinate_frame = payload.getUINT8();

		end
            
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | position_target_local_ned.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                
        function set.x(obj,value)
            obj.x = single(value);
        end
                                
        function set.y(obj,value)
            obj.y = single(value);
        end
                                
        function set.z(obj,value)
            obj.z = single(value);
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
                fprintf(2,'MAVLAB-ERROR | position_target_local_ned.set.type_mask()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.coordinate_frame(obj,value)
            if value == uint8(value)
                obj.coordinate_frame = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | position_target_local_ned.set.coordinate_frame()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end