classdef msg_attitude_target < mavlink_message
    %MAVLINK Message Class
    %Name: attitude_target	ID: 83
    %Description: Reports the current commanded attitude of the vehicle as specified by the autopilot. This should match the commands sent in a SET_ATTITUDE_TARGET message if the vehicle is being controlled this way.
            
    properties(Constant)
        ID = 83
        LEN = 37
    end
    
    properties        
		time_boot_ms	%Timestamp in milliseconds since system boot (uint32)
		q	%Attitude quaternion (w, x, y, z order, zero-rotation is 1, 0, 0, 0) (single[4])
		body_roll_rate	%Body roll rate in radians per second (single)
		body_pitch_rate	%Body roll rate in radians per second (single)
		body_yaw_rate	%Body roll rate in radians per second (single)
		thrust	%Collective thrust, normalized to 0 .. 1 (-1 .. 1 for vehicles capable of reverse trust) (single)
		type_mask	%Mappings: If any of these bits are set, the corresponding input should be ignored: bit 1: body roll rate, bit 2: body pitch rate, bit 3: body yaw rate. bit 4-bit 7: reserved, bit 8: attitude (uint8)
	end
    
    methods
        
        %Constructor: msg_attitude_target
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_attitude_target(packet,time_boot_ms,q,body_roll_rate,body_pitch_rate,body_yaw_rate,thrust,type_mask)
        
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
				obj.q = q;
				obj.body_roll_rate = body_roll_rate;
				obj.body_pitch_rate = body_pitch_rate;
				obj.body_yaw_rate = body_yaw_rate;
				obj.thrust = thrust;
				obj.type_mask = type_mask;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_attitude_target.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_attitude_target.ID;
                
				packet.payload.putUINT32(obj.time_boot_ms);
            
                for i = 1:4
                    packet.payload.putSINGLE(obj.q(i));
                end
                                
				packet.payload.putSINGLE(obj.body_roll_rate);

				packet.payload.putSINGLE(obj.body_pitch_rate);

				packet.payload.putSINGLE(obj.body_yaw_rate);

				packet.payload.putSINGLE(obj.thrust);

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
                                    
        function set.type_mask(obj,value)
            if value == uint8(value)
                obj.type_mask = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end