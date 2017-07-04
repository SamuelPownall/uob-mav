classdef msg_landing_target < mavlink_message
    %MAVLINK Message Class
    %Name: landing_target	ID: 149
    %Description: The location of a landing area captured from a downward facing camera
            
    properties(Constant)
        ID = 149
        LEN = 30
    end
    
    properties        
		time_usec	%Timestamp (micros since boot or Unix epoch) (uint64)
		angle_x	%X-axis angular offset (in radians) of the target from the center of the image (single)
		angle_y	%Y-axis angular offset (in radians) of the target from the center of the image (single)
		distance	%Distance to the target from the vehicle in meters (single)
		size_x	%Size in radians of target along x-axis (single)
		size_y	%Size in radians of target along y-axis (single)
		target_num	%The ID of the target if multiple targets are present (uint8)
		frame	%MAV_FRAME enum specifying the whether the following feilds are earth-frame, body-frame, etc. (uint8)
	end
    
    methods
        
        %Constructor: msg_landing_target
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_landing_target(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_landing_target.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_landing_target.ID;
                
				packet.payload.putUINT64(obj.time_usec);

				packet.payload.putSINGLE(obj.angle_x);

				packet.payload.putSINGLE(obj.angle_y);

				packet.payload.putSINGLE(obj.distance);

				packet.payload.putSINGLE(obj.size_x);

				packet.payload.putSINGLE(obj.size_y);

				packet.payload.putUINT8(obj.target_num);

				packet.payload.putUINT8(obj.frame);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();

			obj.angle_x = payload.getSINGLE();

			obj.angle_y = payload.getSINGLE();

			obj.distance = payload.getSINGLE();

			obj.size_x = payload.getSINGLE();

			obj.size_y = payload.getSINGLE();

			obj.target_num = payload.getUINT8();

			obj.frame = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_usec,2) ~= 1
                result = 'time_usec';                                        
            elseif size(obj.angle_x,2) ~= 1
                result = 'angle_x';                                        
            elseif size(obj.angle_y,2) ~= 1
                result = 'angle_y';                                        
            elseif size(obj.distance,2) ~= 1
                result = 'distance';                                        
            elseif size(obj.size_x,2) ~= 1
                result = 'size_x';                                        
            elseif size(obj.size_y,2) ~= 1
                result = 'size_y';                                        
            elseif size(obj.target_num,2) ~= 1
                result = 'target_num';                                        
            elseif size(obj.frame,2) ~= 1
                result = 'frame';                            
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
                                
        function set.angle_x(obj,value)
            obj.angle_x = single(value);
        end
                                
        function set.angle_y(obj,value)
            obj.angle_y = single(value);
        end
                                
        function set.distance(obj,value)
            obj.distance = single(value);
        end
                                
        function set.size_x(obj,value)
            obj.size_x = single(value);
        end
                                
        function set.size_y(obj,value)
            obj.size_y = single(value);
        end
                                    
        function set.target_num(obj,value)
            if value == uint8(value)
                obj.target_num = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.frame(obj,value)
            if value == uint8(value)
                obj.frame = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end