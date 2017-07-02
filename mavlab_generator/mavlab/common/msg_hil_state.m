classdef msg_hil_state < mavlink_message
    %MAVLINK Message Class
    %Name: hil_state	ID: 90
    %Description: DEPRECATED PACKET! Suffers from missing airspeed fields and singularities due to Euler angles. Please use HIL_STATE_QUATERNION instead. Sent from simulation to autopilot. This packet is useful for high throughput applications such as hardware in the loop simulations.
            
    properties(Constant)
        ID = 90
        LEN = 56
    end
    
    properties        
		time_usec	%Timestamp (microseconds since UNIX epoch or microseconds since system boot) (uint64[1])
		lat	%Latitude, expressed as * 1E7 (int32[1])
		lon	%Longitude, expressed as * 1E7 (int32[1])
		alt	%Altitude in meters, expressed as * 1000 (millimeters) (int32[1])
		roll	%Roll angle (rad) (single[1])
		pitch	%Pitch angle (rad) (single[1])
		yaw	%Yaw angle (rad) (single[1])
		rollspeed	%Body frame roll / phi angular speed (rad/s) (single[1])
		pitchspeed	%Body frame pitch / theta angular speed (rad/s) (single[1])
		yawspeed	%Body frame yaw / psi angular speed (rad/s) (single[1])
		vx	%Ground X Speed (Latitude), expressed as m/s * 100 (int16[1])
		vy	%Ground Y Speed (Longitude), expressed as m/s * 100 (int16[1])
		vz	%Ground Z Speed (Altitude), expressed as m/s * 100 (int16[1])
		xacc	%X acceleration (mg) (int16[1])
		yacc	%Y acceleration (mg) (int16[1])
		zacc	%Z acceleration (mg) (int16[1])
	end

    
    methods
        
        %Constructor: msg_hil_state
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_hil_state(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_hil_state.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_hil_state.ID;
                
			packet.payload.putUINT64(obj.time_usec);

			packet.payload.putINT32(obj.lat);

			packet.payload.putINT32(obj.lon);

			packet.payload.putINT32(obj.alt);

			packet.payload.putSINGLE(obj.roll);

			packet.payload.putSINGLE(obj.pitch);

			packet.payload.putSINGLE(obj.yaw);

			packet.payload.putSINGLE(obj.rollspeed);

			packet.payload.putSINGLE(obj.pitchspeed);

			packet.payload.putSINGLE(obj.yawspeed);

			packet.payload.putINT16(obj.vx);

			packet.payload.putINT16(obj.vy);

			packet.payload.putINT16(obj.vz);

			packet.payload.putINT16(obj.xacc);

			packet.payload.putINT16(obj.yacc);

			packet.payload.putINT16(obj.zacc);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();

			obj.lat = payload.getINT32();

			obj.lon = payload.getINT32();

			obj.alt = payload.getINT32();

			obj.roll = payload.getSINGLE();

			obj.pitch = payload.getSINGLE();

			obj.yaw = payload.getSINGLE();

			obj.rollspeed = payload.getSINGLE();

			obj.pitchspeed = payload.getSINGLE();

			obj.yawspeed = payload.getSINGLE();

			obj.vx = payload.getINT16();

			obj.vy = payload.getINT16();

			obj.vz = payload.getINT16();

			obj.xacc = payload.getINT16();

			obj.yacc = payload.getINT16();

			obj.zacc = payload.getINT16();

		end
            
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_state.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                    
        function set.lat(obj,value)
            if value == int32(value)
                obj.lat = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_state.set.lat()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.lon(obj,value)
            if value == int32(value)
                obj.lon = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_state.set.lon()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.alt(obj,value)
            if value == int32(value)
                obj.alt = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_state.set.alt()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                
        function set.roll(obj,value)
            obj.roll = single(value);
        end
                                
        function set.pitch(obj,value)
            obj.pitch = single(value);
        end
                                
        function set.yaw(obj,value)
            obj.yaw = single(value);
        end
                                
        function set.rollspeed(obj,value)
            obj.rollspeed = single(value);
        end
                                
        function set.pitchspeed(obj,value)
            obj.pitchspeed = single(value);
        end
                                
        function set.yawspeed(obj,value)
            obj.yawspeed = single(value);
        end
                                    
        function set.vx(obj,value)
            if value == int16(value)
                obj.vx = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_state.set.vx()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.vy(obj,value)
            if value == int16(value)
                obj.vy = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_state.set.vy()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.vz(obj,value)
            if value == int16(value)
                obj.vz = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_state.set.vz()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.xacc(obj,value)
            if value == int16(value)
                obj.xacc = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_state.set.xacc()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.yacc(obj,value)
            if value == int16(value)
                obj.yacc = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_state.set.yacc()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.zacc(obj,value)
            if value == int16(value)
                obj.zacc = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_state.set.zacc()\n\t Input "value" is not of type "int16"\n');
            end
        end
                        
	end
end