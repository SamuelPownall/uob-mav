classdef msg_attitude_quaternion_cov < mavlink_message
    %MAVLINK Message Class
    %Name: attitude_quaternion_cov	ID: 61
    %Description: The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right), expressed as quaternion. Quaternion order is w, x, y, z and a zero rotation would be expressed as (1 0 0 0).
            
    properties(Constant)
        ID = 61
        LEN = 72
    end
    
    properties        
		time_usec	%Timestamp (microseconds since system boot or since UNIX epoch) (uint64)
		q	%Quaternion components, w, x, y, z (1 0 0 0 is the null-rotation) (single[4])
		rollspeed	%Roll angular speed (rad/s) (single)
		pitchspeed	%Pitch angular speed (rad/s) (single)
		yawspeed	%Yaw angular speed (rad/s) (single)
		covariance	%Attitude covariance (single[9])
	end
    
    methods
        
        %Constructor: msg_attitude_quaternion_cov
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_attitude_quaternion_cov(packet)
        
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
        
                packet = mavlink_packet(msg_attitude_quaternion_cov.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_attitude_quaternion_cov.ID;
                
				packet.payload.putUINT64(obj.time_usec);
            
                for i = 1:4
                    packet.payload.putSINGLE(obj.q(i));
                end
                                
				packet.payload.putSINGLE(obj.rollspeed);

				packet.payload.putSINGLE(obj.pitchspeed);

				packet.payload.putSINGLE(obj.yawspeed);
            
                for i = 1:9
                    packet.payload.putSINGLE(obj.covariance(i));
                end
                                        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_attitude_quaternion_cov.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();
            
            for i = 1:4
                obj.q(i) = payload.getSINGLE();
            end
                            
			obj.rollspeed = payload.getSINGLE();

			obj.pitchspeed = payload.getSINGLE();

			obj.yawspeed = payload.getSINGLE();
            
            for i = 1:9
                obj.covariance(i) = payload.getSINGLE();
            end
                            
		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_usec,2) ~= 1
                result = 'time_usec';                                        
            elseif size(obj.q,2) ~= 4
                result = 'q';                                        
            elseif size(obj.rollspeed,2) ~= 1
                result = 'rollspeed';                                        
            elseif size(obj.pitchspeed,2) ~= 1
                result = 'pitchspeed';                                        
            elseif size(obj.yawspeed,2) ~= 1
                result = 'yawspeed';                                        
            elseif size(obj.covariance,2) ~= 9
                result = 'covariance';                            
            else
                result = 0;
            end
            
        end
                                
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | attitude_quaternion_cov.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                
        function set.q(obj,value)
            obj.q = single(value);
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
                                
        function set.covariance(obj,value)
            obj.covariance = single(value);
        end
                        
	end
end