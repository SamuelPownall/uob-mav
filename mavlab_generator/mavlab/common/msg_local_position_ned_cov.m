classdef msg_local_position_ned_cov < mavlink_message
    %MAVLINK Message Class
    %Name: local_position_ned_cov	ID: 64
    %Description: The filtered local position (e.g. fused computer vision and accelerometers). Coordinate frame is right-handed, Z-axis down (aeronautical frame, NED / north-east-down convention)
            
    properties(Constant)
        ID = 64
        LEN = 225
    end
    
    properties        
		time_usec	%Timestamp (microseconds since system boot or since UNIX epoch) (uint64)
		x	%X Position (single)
		y	%Y Position (single)
		z	%Z Position (single)
		vx	%X Speed (m/s) (single)
		vy	%Y Speed (m/s) (single)
		vz	%Z Speed (m/s) (single)
		ax	%X Acceleration (m/s^2) (single)
		ay	%Y Acceleration (m/s^2) (single)
		az	%Z Acceleration (m/s^2) (single)
		covariance	%Covariance matrix upper right triangular (first nine entries are the first ROW, next eight entries are the second row, etc.) (single[45])
		estimator_type	%Class id of the estimator this estimate originated from. (uint8)
	end
    
    methods
        
        %Constructor: msg_local_position_ned_cov
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_local_position_ned_cov(packet,time_usec,x,y,z,vx,vy,vz,ax,ay,az,covariance,estimator_type)
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(packet,'mavlink_packet')
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('packet','mavlink_packet');
                end
                
            elseif nargin == 13
                
				obj.time_usec = time_usec;
				obj.x = x;
				obj.y = y;
				obj.z = z;
				obj.vx = vx;
				obj.vy = vy;
				obj.vz = vz;
				obj.ax = ax;
				obj.ay = ay;
				obj.az = az;
				obj.covariance = covariance;
				obj.estimator_type = estimator_type;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
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
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
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
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_usec,2) ~= 1
                result = 'time_usec';                                        
            elseif size(obj.x,2) ~= 1
                result = 'x';                                        
            elseif size(obj.y,2) ~= 1
                result = 'y';                                        
            elseif size(obj.z,2) ~= 1
                result = 'z';                                        
            elseif size(obj.vx,2) ~= 1
                result = 'vx';                                        
            elseif size(obj.vy,2) ~= 1
                result = 'vy';                                        
            elseif size(obj.vz,2) ~= 1
                result = 'vz';                                        
            elseif size(obj.ax,2) ~= 1
                result = 'ax';                                        
            elseif size(obj.ay,2) ~= 1
                result = 'ay';                                        
            elseif size(obj.az,2) ~= 1
                result = 'az';                                        
            elseif size(obj.covariance,2) ~= 45
                result = 'covariance';                                        
            elseif size(obj.estimator_type,2) ~= 1
                result = 'estimator_type';                            
            else
                result = 0;
            end
            
        end
                                
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                mavlink.throwTypeError('value','uint64');
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
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end