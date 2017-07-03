classdef msg_attitude_quaternion < mavlink_message
    %MAVLINK Message Class
    %Name: attitude_quaternion	ID: 31
    %Description: The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right), expressed as quaternion. Quaternion order is w, x, y, z and a zero rotation would be expressed as (1 0 0 0).
            
    properties(Constant)
        ID = 31
        LEN = 32
    end
    
    properties        
		time_boot_ms	%Timestamp (milliseconds since system boot) (uint32)
		q1	%Quaternion component 1, w (1 in null-rotation) (single)
		q2	%Quaternion component 2, x (0 in null-rotation) (single)
		q3	%Quaternion component 3, y (0 in null-rotation) (single)
		q4	%Quaternion component 4, z (0 in null-rotation) (single)
		rollspeed	%Roll angular speed (rad/s) (single)
		pitchspeed	%Pitch angular speed (rad/s) (single)
		yawspeed	%Yaw angular speed (rad/s) (single)
	end
    
    methods
        
        %Constructor: msg_attitude_quaternion
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_attitude_quaternion(packet)
        
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
        
                packet = mavlink_packet(msg_attitude_quaternion.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_attitude_quaternion.ID;
                
				packet.payload.putUINT32(obj.time_boot_ms);

				packet.payload.putSINGLE(obj.q1);

				packet.payload.putSINGLE(obj.q2);

				packet.payload.putSINGLE(obj.q3);

				packet.payload.putSINGLE(obj.q4);

				packet.payload.putSINGLE(obj.rollspeed);

				packet.payload.putSINGLE(obj.pitchspeed);

				packet.payload.putSINGLE(obj.yawspeed);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_attitude_quaternion.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_boot_ms = payload.getUINT32();

			obj.q1 = payload.getSINGLE();

			obj.q2 = payload.getSINGLE();

			obj.q3 = payload.getSINGLE();

			obj.q4 = payload.getSINGLE();

			obj.rollspeed = payload.getSINGLE();

			obj.pitchspeed = payload.getSINGLE();

			obj.yawspeed = payload.getSINGLE();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';                                        
            elseif size(obj.q1,2) ~= 1
                result = 'q1';                                        
            elseif size(obj.q2,2) ~= 1
                result = 'q2';                                        
            elseif size(obj.q3,2) ~= 1
                result = 'q3';                                        
            elseif size(obj.q4,2) ~= 1
                result = 'q4';                                        
            elseif size(obj.rollspeed,2) ~= 1
                result = 'rollspeed';                                        
            elseif size(obj.pitchspeed,2) ~= 1
                result = 'pitchspeed';                                        
            elseif size(obj.yawspeed,2) ~= 1
                result = 'yawspeed';                            
            else
                result = 0;
            end
            
        end
                                
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | attitude_quaternion.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                
        function set.q1(obj,value)
            obj.q1 = single(value);
        end
                                
        function set.q2(obj,value)
            obj.q2 = single(value);
        end
                                
        function set.q3(obj,value)
            obj.q3 = single(value);
        end
                                
        function set.q4(obj,value)
            obj.q4 = single(value);
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
                        
	end
end