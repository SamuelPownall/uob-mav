classdef msg_hil_state_quaternion < mavlink_message
    %MAVLINK Message Class
    %Name: hil_state_quaternion	ID: 115
    %Description: Sent from simulation to autopilot, avoids in contrast to HIL_STATE singularities. This packet is useful for high throughput applications such as hardware in the loop simulations.
            
    properties(Constant)
        ID = 115
        LEN = 64
    end
    
    properties        
		time_usec	%Timestamp (microseconds since UNIX epoch or microseconds since system boot) (uint64[1])
		lat	%Latitude, expressed as * 1E7 (int32[1])
		lon	%Longitude, expressed as * 1E7 (int32[1])
		alt	%Altitude in meters, expressed as * 1000 (millimeters) (int32[1])
		attitude_quaternion	%Vehicle attitude expressed as normalized quaternion in w, x, y, z order (with 1 0 0 0 being the null-rotation) (single[4])
		rollspeed	%Body frame roll / phi angular speed (rad/s) (single[1])
		pitchspeed	%Body frame pitch / theta angular speed (rad/s) (single[1])
		yawspeed	%Body frame yaw / psi angular speed (rad/s) (single[1])
		vx	%Ground X Speed (Latitude), expressed as m/s * 100 (int16[1])
		vy	%Ground Y Speed (Longitude), expressed as m/s * 100 (int16[1])
		vz	%Ground Z Speed (Altitude), expressed as m/s * 100 (int16[1])
		ind_airspeed	%Indicated airspeed, expressed as m/s * 100 (uint16[1])
		true_airspeed	%True airspeed, expressed as m/s * 100 (uint16[1])
		xacc	%X acceleration (mg) (int16[1])
		yacc	%Y acceleration (mg) (int16[1])
		zacc	%Z acceleration (mg) (int16[1])
	end

    
    methods
        
        %Constructor: msg_hil_state_quaternion
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_hil_state_quaternion(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_hil_state_quaternion.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_hil_state_quaternion.ID;
                
			packet.payload.putUINT64(obj.time_usec);

			packet.payload.putINT32(obj.lat);

			packet.payload.putINT32(obj.lon);

			packet.payload.putINT32(obj.alt);
            
            for i = 1:4
                packet.payload.putSINGLE(obj.attitude_quaternion(i));
            end
                            
			packet.payload.putSINGLE(obj.rollspeed);

			packet.payload.putSINGLE(obj.pitchspeed);

			packet.payload.putSINGLE(obj.yawspeed);

			packet.payload.putINT16(obj.vx);

			packet.payload.putINT16(obj.vy);

			packet.payload.putINT16(obj.vz);

			packet.payload.putUINT16(obj.ind_airspeed);

			packet.payload.putUINT16(obj.true_airspeed);

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
            
            for i = 1:4
                obj.attitude_quaternion(i) = payload.getSINGLE();
            end
                            
			obj.rollspeed = payload.getSINGLE();

			obj.pitchspeed = payload.getSINGLE();

			obj.yawspeed = payload.getSINGLE();

			obj.vx = payload.getINT16();

			obj.vy = payload.getINT16();

			obj.vz = payload.getINT16();

			obj.ind_airspeed = payload.getUINT16();

			obj.true_airspeed = payload.getUINT16();

			obj.xacc = payload.getINT16();

			obj.yacc = payload.getINT16();

			obj.zacc = payload.getINT16();

		end
            
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_state_quaternion.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                    
        function set.lat(obj,value)
            if value == int32(value)
                obj.lat = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_state_quaternion.set.lat()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.lon(obj,value)
            if value == int32(value)
                obj.lon = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_state_quaternion.set.lon()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.alt(obj,value)
            if value == int32(value)
                obj.alt = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_state_quaternion.set.alt()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                
        function set.attitude_quaternion(obj,value)
            obj.attitude_quaternion = single(value);
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
                fprintf(2,'MAVLAB-ERROR | hil_state_quaternion.set.vx()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.vy(obj,value)
            if value == int16(value)
                obj.vy = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_state_quaternion.set.vy()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.vz(obj,value)
            if value == int16(value)
                obj.vz = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_state_quaternion.set.vz()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.ind_airspeed(obj,value)
            if value == uint16(value)
                obj.ind_airspeed = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_state_quaternion.set.ind_airspeed()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.true_airspeed(obj,value)
            if value == uint16(value)
                obj.true_airspeed = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_state_quaternion.set.true_airspeed()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.xacc(obj,value)
            if value == int16(value)
                obj.xacc = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_state_quaternion.set.xacc()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.yacc(obj,value)
            if value == int16(value)
                obj.yacc = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_state_quaternion.set.yacc()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.zacc(obj,value)
            if value == int16(value)
                obj.zacc = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_state_quaternion.set.zacc()\n\t Input "value" is not of type "int16"\n');
            end
        end
                        
	end
end