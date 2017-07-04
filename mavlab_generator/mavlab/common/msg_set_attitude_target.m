classdef msg_set_attitude_target < mavlink_message
    %MAVLINK Message Class
    %Name: set_attitude_target	ID: 82
    %Description: Sets a desired vehicle attitude. Used by an external controller to command the vehicle (manual controller or other system).
            
    properties(Constant)
        ID = 82
        LEN = 39
    end
    
    properties        
		time_boot_ms	%Timestamp in milliseconds since system boot (uint32)
		q	%Attitude quaternion (w, x, y, z order, zero-rotation is 1, 0, 0, 0) (single[4])
		body_roll_rate	%Body roll rate in radians per second (single)
		body_pitch_rate	%Body roll rate in radians per second (single)
		body_yaw_rate	%Body roll rate in radians per second (single)
		thrust	%Collective thrust, normalized to 0 .. 1 (-1 .. 1 for vehicles capable of reverse trust) (single)
		target_system	%System ID (uint8)
		target_component	%Component ID (uint8)
		type_mask	%Mappings: If any of these bits are set, the corresponding input should be ignored: bit 1: body roll rate, bit 2: body pitch rate, bit 3: body yaw rate. bit 4-bit 6: reserved, bit 7: throttle, bit 8: attitude (uint8)
	end
    
    methods
        
        %Constructor: msg_set_attitude_target
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_set_attitude_target(packet,time_boot_ms,q,body_roll_rate,body_pitch_rate,body_yaw_rate,thrust,target_system,target_component,type_mask)
        
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
                
            elseif nargin == 10
                
				obj.time_boot_ms = time_boot_ms;
				obj.q = q;
				obj.body_roll_rate = body_roll_rate;
				obj.body_pitch_rate = body_pitch_rate;
				obj.body_yaw_rate = body_yaw_rate;
				obj.thrust = thrust;
				obj.target_system = target_system;
				obj.target_component = target_component;
				obj.type_mask = type_mask;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_set_attitude_target.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_set_attitude_target.ID;
                
				packet.payload.putUINT32(obj.time_boot_ms);
            
                for i = 1:4
                    packet.payload.putSINGLE(obj.q(i));
                end
                                
				packet.payload.putSINGLE(obj.body_roll_rate);

				packet.payload.putSINGLE(obj.body_pitch_rate);

				packet.payload.putSINGLE(obj.body_yaw_rate);

				packet.payload.putSINGLE(obj.thrust);

				packet.payload.putUINT8(obj.target_system);

				packet.payload.putUINT8(obj.target_component);

				packet.payload.putUINT8(obj.type_mask);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_boot_ms = payload.getUINT32();
            
            for i = 1:4
                obj.q(i) = payload.getSINGLE();
            end
                            
			obj.body_roll_rate = payload.getSINGLE();

			obj.body_pitch_rate = payload.getSINGLE();

			obj.body_yaw_rate = payload.getSINGLE();

			obj.thrust = payload.getSINGLE();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

			obj.type_mask = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';                                        
            elseif size(obj.q,2) ~= 4
                result = 'q';                                        
            elseif size(obj.body_roll_rate,2) ~= 1
                result = 'body_roll_rate';                                        
            elseif size(obj.body_pitch_rate,2) ~= 1
                result = 'body_pitch_rate';                                        
            elseif size(obj.body_yaw_rate,2) ~= 1
                result = 'body_yaw_rate';                                        
            elseif size(obj.thrust,2) ~= 1
                result = 'thrust';                                        
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';                                        
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';                                        
            elseif size(obj.type_mask,2) ~= 1
                result = 'type_mask';                            
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
                                
        function set.q(obj,value)
            obj.q = single(value);
        end
                                
        function set.body_roll_rate(obj,value)
            obj.body_roll_rate = single(value);
        end
                                
        function set.body_pitch_rate(obj,value)
            obj.body_pitch_rate = single(value);
        end
                                
        function set.body_yaw_rate(obj,value)
            obj.body_yaw_rate = single(value);
        end
                                
        function set.thrust(obj,value)
            obj.thrust = single(value);
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.type_mask(obj,value)
            if value == uint8(value)
                obj.type_mask = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end