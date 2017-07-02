classdef msg_local_position_ned_cov < mavlink_message
    %MAVLINK Message Class
    %Name: local_position_ned_cov	ID: 64
    %Description: The filtered local position (e.g. fused computer vision and accelerometers). Coordinate frame is right-handed, Z-axis down (aeronautical frame, NED / north-east-down convention)
            
    properties(Constant)
        ID = 64
        LEN = 225
    end
    
    properties        
		time_usec	%Timestamp (microseconds since system boot or since UNIX epoch) (uint64[1])
		x	%X Position (single[1])
		y	%Y Position (single[1])
		z	%Z Position (single[1])
		vx	%X Speed (m/s) (single[1])
		vy	%Y Speed (m/s) (single[1])
		vz	%Z Speed (m/s) (single[1])
		ax	%X Acceleration (m/s^2) (single[1])
		ay	%Y Acceleration (m/s^2) (single[1])
		az	%Z Acceleration (m/s^2) (single[1])
		covariance	%Covariance matrix upper right triangular (first nine entries are the first ROW, next eight entries are the second row, etc.) (single[45])
		estimator_type	%Class id of the estimator this estimate originated from. (uint8[1])
	end

    
    methods
        
        %Constructor: msg_local_position_ned_cov
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_local_position_ned_cov(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_local_position_ned_cov.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_local_position_ned_cov.ID;
                
			packet.payload.putUINT64(obj.time_usec);

			packet.payload.putSINGLE(obj.x);

			packet.payload.putSINGLE(obj.y);

			packet.payload.putSINGLE(obj.z);

			packet.payload.putSINGLE(obj.vx);

			packet.payload.putSINGLE(obj.vy);

			packet.payload.putSINGLE(obj.vz);

			packet.payload.putSINGLE(obj.ax);

			packet.payload.putSINGLE(obj.ay);

			packet.payload.putSINGLE(obj.az);
            
            for i = 1:45
                packet.payload.putSINGLE(obj.covariance(i));
            end
                            
			packet.payload.putUINT8(obj.estimator_type);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();

			obj.x = payload.getSINGLE();

			obj.y = payload.getSINGLE();

			obj.z = payload.getSINGLE();

			obj.vx = payload.getSINGLE();

			obj.vy = payload.getSINGLE();

			obj.vz = payload.getSINGLE();

			obj.ax = payload.getSINGLE();

			obj.ay = payload.getSINGLE();

			obj.az = payload.getSINGLE();
            
            for i = 1:45
                obj.covariance(i) = payload.getSINGLE();
            end
                            
			obj.estimator_type = payload.getUINT8();

		end
            
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | local_position_ned_cov.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
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
                                
        function set.ax(obj,value)
            obj.ax = single(value);
        end
                                
        function set.ay(obj,value)
            obj.ay = single(value);
        end
                                
        function set.az(obj,value)
            obj.az = single(value);
        end
                                
        function set.covariance(obj,value)
            obj.covariance = single(value);
        end
                                    
        function set.estimator_type(obj,value)
            if value == uint8(value)
                obj.estimator_type = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | local_position_ned_cov.set.estimator_type()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end