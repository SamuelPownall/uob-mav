classdef msg_vision_position_estimate < mavlink_message
    %MAVLINK Message Class
    %Name: vision_position_estimate	ID: 102
    %Description: None
            
    properties(Constant)
        ID = 102
        LEN = 32
    end
    
    properties        
		usec	%Timestamp (microseconds, synced to UNIX time or since system boot) (uint64)
		x	%Global X position (single)
		y	%Global Y position (single)
		z	%Global Z position (single)
		roll	%Roll angle in rad (single)
		pitch	%Pitch angle in rad (single)
		yaw	%Yaw angle in rad (single)
	end
    
    methods
        
        %Constructor: msg_vision_position_estimate
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_vision_position_estimate(packet,usec,x,y,z,roll,pitch,yaw)
        
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
                
            elseif nargin == 8
                
				obj.usec = usec;
				obj.x = x;
				obj.y = y;
				obj.z = z;
				obj.roll = roll;
				obj.pitch = pitch;
				obj.yaw = yaw;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_vision_position_estimate.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_vision_position_estimate.ID;
                
				packet.payload.putUINT64(obj.usec);

				packet.payload.putSINGLE(obj.x);

				packet.payload.putSINGLE(obj.y);

				packet.payload.putSINGLE(obj.z);

				packet.payload.putSINGLE(obj.roll);

				packet.payload.putSINGLE(obj.pitch);

				packet.payload.putSINGLE(obj.yaw);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.usec = payload.getUINT64();

			obj.x = payload.getSINGLE();

			obj.y = payload.getSINGLE();

			obj.z = payload.getSINGLE();

			obj.roll = payload.getSINGLE();

			obj.pitch = payload.getSINGLE();

			obj.yaw = payload.getSINGLE();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.usec,2) ~= 1
                result = 'usec';                                        
            elseif size(obj.x,2) ~= 1
                result = 'x';                                        
            elseif size(obj.y,2) ~= 1
                result = 'y';                                        
            elseif size(obj.z,2) ~= 1
                result = 'z';                                        
            elseif size(obj.roll,2) ~= 1
                result = 'roll';                                        
            elseif size(obj.pitch,2) ~= 1
                result = 'pitch';                                        
            elseif size(obj.yaw,2) ~= 1
                result = 'yaw';                            
            else
                result = 0;
            end
            
        end
                                
        function set.usec(obj,value)
            if value == uint64(value)
                obj.usec = uint64(value);
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
                                
        function set.roll(obj,value)
            obj.roll = single(value);
        end
                                
        function set.pitch(obj,value)
            obj.pitch = single(value);
        end
                                
        function set.yaw(obj,value)
            obj.yaw = single(value);
        end
                        
	end
end