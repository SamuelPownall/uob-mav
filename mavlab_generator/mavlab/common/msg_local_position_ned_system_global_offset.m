classdef msg_local_position_ned_system_global_offset < mavlink_message
    %MAVLINK Message Class
    %Name: local_position_ned_system_global_offset	ID: 89
    %Description: The offset in X, Y, Z and yaw between the LOCAL_POSITION_NED messages of MAV X and the global coordinate frame in NED coordinates. Coordinate frame is right-handed, Z-axis down (aeronautical frame, NED / north-east-down convention)
            
    properties(Constant)
        ID = 89
        LEN = 28
    end
    
    properties        
		time_boot_ms	%Timestamp (milliseconds since system boot) (uint32)
		x	%X Position (single)
		y	%Y Position (single)
		z	%Z Position (single)
		roll	%Roll (single)
		pitch	%Pitch (single)
		yaw	%Yaw (single)
	end
    
    methods
        
        %Constructor: msg_local_position_ned_system_global_offset
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_local_position_ned_system_global_offset(packet,time_boot_ms,x,y,z,roll,pitch,yaw)
        
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
                
				obj.time_boot_ms = time_boot_ms;
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
        
                packet = mavlink_packet(msg_local_position_ned_system_global_offset.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_local_position_ned_system_global_offset.ID;
                
				packet.payload.putUINT32(obj.time_boot_ms);

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
        
			obj.time_boot_ms = payload.getUINT32();

			obj.x = payload.getSINGLE();

			obj.y = payload.getSINGLE();

			obj.z = payload.getSINGLE();

			obj.roll = payload.getSINGLE();

			obj.pitch = payload.getSINGLE();

			obj.yaw = payload.getSINGLE();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';                                        
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
                                
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
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