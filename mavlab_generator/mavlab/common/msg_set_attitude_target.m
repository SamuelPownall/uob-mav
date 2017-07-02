classdef msg_set_attitude_target < mavlink_message
    %MAVLINK Message Class
    %Name: set_attitude_target	ID: 82
    %Description: Sets a desired vehicle attitude. Used by an external controller to command the vehicle (manual controller or other system).
            
    properties(Constant)
        ID = 82
        LEN = 39
    end
    
    properties        
		time_boot_ms	%Timestamp in milliseconds since system boot (uint32[1])
		q	%Attitude quaternion (w, x, y, z order, zero-rotation is 1, 0, 0, 0) (single[4])
		body_roll_rate	%Body roll rate in radians per second (single[1])
		body_pitch_rate	%Body roll rate in radians per second (single[1])
		body_yaw_rate	%Body roll rate in radians per second (single[1])
		thrust	%Collective thrust, normalized to 0 .. 1 (-1 .. 1 for vehicles capable of reverse trust) (single[1])
		target_system	%System ID (uint8[1])
		target_component	%Component ID (uint8[1])
		type_mask	%Mappings: If any of these bits are set, the corresponding input should be ignored: bit 1: body roll rate, bit 2: body pitch rate, bit 3: body yaw rate. bit 4-bit 6: reserved, bit 7: throttle, bit 8: attitude (uint8[1])
	end

    
    methods
        
        %Constructor: msg_set_attitude_target
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_set_attitude_target(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
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

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
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
            
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | set_attitude_target.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
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
                fprintf(2,'MAVLAB-ERROR | set_attitude_target.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | set_attitude_target.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.type_mask(obj,value)
            if value == uint8(value)
                obj.type_mask = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | set_attitude_target.set.type_mask()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end