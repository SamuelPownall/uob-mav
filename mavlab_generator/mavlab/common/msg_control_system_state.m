classdef msg_control_system_state < mavlink_message
    %MAVLINK Message Class
    %Name: control_system_state	ID: 146
    %Description: The smoothed, monotonic system state used to feed the control loops of the system.
            
    properties(Constant)
        ID = 146
        LEN = 100
    end
    
    properties        
		time_usec	%Timestamp (micros since boot or Unix epoch) (uint64)
		x_acc	%X acceleration in body frame (single)
		y_acc	%Y acceleration in body frame (single)
		z_acc	%Z acceleration in body frame (single)
		x_vel	%X velocity in body frame (single)
		y_vel	%Y velocity in body frame (single)
		z_vel	%Z velocity in body frame (single)
		x_pos	%X position in local frame (single)
		y_pos	%Y position in local frame (single)
		z_pos	%Z position in local frame (single)
		airspeed	%Airspeed, set to -1 if unknown (single)
		vel_variance	%Variance of body velocity estimate (single[3])
		pos_variance	%Variance in local position (single[3])
		q	%The attitude, represented as Quaternion (single[4])
		roll_rate	%Angular rate in roll axis (single)
		pitch_rate	%Angular rate in pitch axis (single)
		yaw_rate	%Angular rate in yaw axis (single)
	end
    
    methods
        
        %Constructor: msg_control_system_state
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_control_system_state(packet)
        
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
        
                packet = mavlink_packet(msg_control_system_state.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_control_system_state.ID;
                
				packet.payload.putUINT64(obj.time_usec);

				packet.payload.putSINGLE(obj.x_acc);

				packet.payload.putSINGLE(obj.y_acc);

				packet.payload.putSINGLE(obj.z_acc);

				packet.payload.putSINGLE(obj.x_vel);

				packet.payload.putSINGLE(obj.y_vel);

				packet.payload.putSINGLE(obj.z_vel);

				packet.payload.putSINGLE(obj.x_pos);

				packet.payload.putSINGLE(obj.y_pos);

				packet.payload.putSINGLE(obj.z_pos);

				packet.payload.putSINGLE(obj.airspeed);
            
                for i = 1:3
                    packet.payload.putSINGLE(obj.vel_variance(i));
                end
                                            
                for i = 1:3
                    packet.payload.putSINGLE(obj.pos_variance(i));
                end
                                            
                for i = 1:4
                    packet.payload.putSINGLE(obj.q(i));
                end
                                
				packet.payload.putSINGLE(obj.roll_rate);

				packet.payload.putSINGLE(obj.pitch_rate);

				packet.payload.putSINGLE(obj.yaw_rate);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_control_system_state.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();

			obj.x_acc = payload.getSINGLE();

			obj.y_acc = payload.getSINGLE();

			obj.z_acc = payload.getSINGLE();

			obj.x_vel = payload.getSINGLE();

			obj.y_vel = payload.getSINGLE();

			obj.z_vel = payload.getSINGLE();

			obj.x_pos = payload.getSINGLE();

			obj.y_pos = payload.getSINGLE();

			obj.z_pos = payload.getSINGLE();

			obj.airspeed = payload.getSINGLE();
            
            for i = 1:3
                obj.vel_variance(i) = payload.getSINGLE();
            end
                                        
            for i = 1:3
                obj.pos_variance(i) = payload.getSINGLE();
            end
                                        
            for i = 1:4
                obj.q(i) = payload.getSINGLE();
            end
                            
			obj.roll_rate = payload.getSINGLE();

			obj.pitch_rate = payload.getSINGLE();

			obj.yaw_rate = payload.getSINGLE();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_usec,2) ~= 1
                result = 'time_usec';                                        
            elseif size(obj.x_acc,2) ~= 1
                result = 'x_acc';                                        
            elseif size(obj.y_acc,2) ~= 1
                result = 'y_acc';                                        
            elseif size(obj.z_acc,2) ~= 1
                result = 'z_acc';                                        
            elseif size(obj.x_vel,2) ~= 1
                result = 'x_vel';                                        
            elseif size(obj.y_vel,2) ~= 1
                result = 'y_vel';                                        
            elseif size(obj.z_vel,2) ~= 1
                result = 'z_vel';                                        
            elseif size(obj.x_pos,2) ~= 1
                result = 'x_pos';                                        
            elseif size(obj.y_pos,2) ~= 1
                result = 'y_pos';                                        
            elseif size(obj.z_pos,2) ~= 1
                result = 'z_pos';                                        
            elseif size(obj.airspeed,2) ~= 1
                result = 'airspeed';                                        
            elseif size(obj.vel_variance,2) ~= 3
                result = 'vel_variance';                                        
            elseif size(obj.pos_variance,2) ~= 3
                result = 'pos_variance';                                        
            elseif size(obj.q,2) ~= 4
                result = 'q';                                        
            elseif size(obj.roll_rate,2) ~= 1
                result = 'roll_rate';                                        
            elseif size(obj.pitch_rate,2) ~= 1
                result = 'pitch_rate';                                        
            elseif size(obj.yaw_rate,2) ~= 1
                result = 'yaw_rate';                            
            else
                result = 0;
            end
            
        end
                                
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | control_system_state.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                
        function set.x_acc(obj,value)
            obj.x_acc = single(value);
        end
                                
        function set.y_acc(obj,value)
            obj.y_acc = single(value);
        end
                                
        function set.z_acc(obj,value)
            obj.z_acc = single(value);
        end
                                
        function set.x_vel(obj,value)
            obj.x_vel = single(value);
        end
                                
        function set.y_vel(obj,value)
            obj.y_vel = single(value);
        end
                                
        function set.z_vel(obj,value)
            obj.z_vel = single(value);
        end
                                
        function set.x_pos(obj,value)
            obj.x_pos = single(value);
        end
                                
        function set.y_pos(obj,value)
            obj.y_pos = single(value);
        end
                                
        function set.z_pos(obj,value)
            obj.z_pos = single(value);
        end
                                
        function set.airspeed(obj,value)
            obj.airspeed = single(value);
        end
                                
        function set.vel_variance(obj,value)
            obj.vel_variance = single(value);
        end
                                
        function set.pos_variance(obj,value)
            obj.pos_variance = single(value);
        end
                                
        function set.q(obj,value)
            obj.q = single(value);
        end
                                
        function set.roll_rate(obj,value)
            obj.roll_rate = single(value);
        end
                                
        function set.pitch_rate(obj,value)
            obj.pitch_rate = single(value);
        end
                                
        function set.yaw_rate(obj,value)
            obj.yaw_rate = single(value);
        end
                        
	end
end