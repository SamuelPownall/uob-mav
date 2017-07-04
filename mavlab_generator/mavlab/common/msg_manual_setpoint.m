classdef msg_manual_setpoint < mavlink_message
    %MAVLINK Message Class
    %Name: manual_setpoint	ID: 81
    %Description: Setpoint in roll, pitch, yaw and thrust from the operator
            
    properties(Constant)
        ID = 81
        LEN = 22
    end
    
    properties        
		time_boot_ms	%Timestamp in milliseconds since system boot (uint32)
		roll	%Desired roll rate in radians per second (single)
		pitch	%Desired pitch rate in radians per second (single)
		yaw	%Desired yaw rate in radians per second (single)
		thrust	%Collective thrust, normalized to 0 .. 1 (single)
		mode_switch	%Flight mode switch position, 0.. 255 (uint8)
		manual_override_switch	%Override mode switch position, 0.. 255 (uint8)
	end
    
    methods
        
        %Constructor: msg_manual_setpoint
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_manual_setpoint(packet)
        
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
        
                packet = mavlink_packet(msg_manual_setpoint.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_manual_setpoint.ID;
                
				packet.payload.putUINT32(obj.time_boot_ms);

				packet.payload.putSINGLE(obj.roll);

				packet.payload.putSINGLE(obj.pitch);

				packet.payload.putSINGLE(obj.yaw);

				packet.payload.putSINGLE(obj.thrust);

				packet.payload.putUINT8(obj.mode_switch);

				packet.payload.putUINT8(obj.manual_override_switch);
        
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

			obj.thrust = payload.getSINGLE();

			obj.mode_switch = payload.getUINT8();

			obj.manual_override_switch = payload.getUINT8();

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
            elseif size(obj.thrust,2) ~= 1
                result = 'thrust';                                        
            elseif size(obj.mode_switch,2) ~= 1
                result = 'mode_switch';                                        
            elseif size(obj.manual_override_switch,2) ~= 1
                result = 'manual_override_switch';                            
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
                                
        function set.thrust(obj,value)
            obj.thrust = single(value);
        end
                                    
        function set.mode_switch(obj,value)
            if value == uint8(value)
                obj.mode_switch = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.manual_override_switch(obj,value)
            if value == uint8(value)
                obj.manual_override_switch = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end