classdef msg_attitude < mavlink_message
    %MAVLINK Message Class
    %Name: attitude	ID: 30
    %Description: The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right).
            
    properties(Constant)
        ID = 30
        LEN = 28
    end
    
    properties        
		time_boot_ms	%Timestamp (milliseconds since system boot) (uint32)
		roll	%Roll angle (rad, -pi..+pi) (single)
		pitch	%Pitch angle (rad, -pi..+pi) (single)
		yaw	%Yaw angle (rad, -pi..+pi) (single)
		rollspeed	%Roll angular speed (rad/s) (single)
		pitchspeed	%Pitch angular speed (rad/s) (single)
		yawspeed	%Yaw angular speed (rad/s) (single)
	end
    
    methods
        
        %Constructor: msg_attitude
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_attitude(packet,time_boot_ms,roll,pitch,yaw,rollspeed,pitchspeed,yawspeed)
        
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
				obj.roll = roll;
				obj.pitch = pitch;
				obj.yaw = yaw;
				obj.rollspeed = rollspeed;
				obj.pitchspeed = pitchspeed;
				obj.yawspeed = yawspeed;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_attitude.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_attitude.ID;
                
				packet.payload.putUINT32(obj.time_boot_ms);

				packet.payload.putSINGLE(obj.roll);

				packet.payload.putSINGLE(obj.pitch);

				packet.payload.putSINGLE(obj.yaw);

				packet.payload.putSINGLE(obj.rollspeed);

				packet.payload.putSINGLE(obj.pitchspeed);

				packet.payload.putSINGLE(obj.yawspeed);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_boot_ms = payload.getUINT32();

			obj.roll = payload.getSINGLE();

			obj.pitch = payload.getSINGLE();

			obj.yaw = payload.getSINGLE();

			obj.rollspeed = payload.getSINGLE();

			obj.pitchspeed = payload.getSINGLE();

			obj.yawspeed = payload.getSINGLE();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';                                        
            elseif size(obj.roll,2) ~= 1
                result = 'roll';                                        
            elseif size(obj.pitch,2) ~= 1
                result = 'pitch';                                        
            elseif size(obj.yaw,2) ~= 1
                result = 'yaw';                                        
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
                mavlink.throwTypeError('value','uint32');
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
                        
	end
end