classdef msg_set_actuator_control_target < mavlink_message
    %MAVLINK Message Class
    %Name: set_actuator_control_target	ID: 139
    %Description: Set the vehicle attitude and body angular rates.
            
    properties(Constant)
        ID = 139
        LEN = 43
    end
    
    properties        
		time_usec	%Timestamp (micros since boot or Unix epoch) (uint64[1])
		controls	%Actuator controls. Normed to -1..+1 where 0 is neutral position. Throttle for single rotation direction motors is 0..1, negative range for reverse direction. Standard mapping for attitude controls (group 0): (index 0-7): roll, pitch, yaw, throttle, flaps, spoilers, airbrakes, landing gear. Load a pass-through mixer to repurpose them as generic outputs. (single[8])
		group_mlx	%Actuator group. The "_mlx" indicates this is a multi-instance message and a MAVLink parser should use this field to difference between instances. (uint8[1])
		target_system	%System ID (uint8[1])
		target_component	%Component ID (uint8[1])
	end

    
    methods
        
        %Constructor: msg_set_actuator_control_target
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_set_actuator_control_target(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_set_actuator_control_target.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_set_actuator_control_target.ID;
                
			packet.payload.putUINT64(obj.time_usec);
            
            for i = 1:8
                packet.payload.putSINGLE(obj.controls(i));
            end
                            
			packet.payload.putUINT8(obj.group_mlx);

			packet.payload.putUINT8(obj.target_system);

			packet.payload.putUINT8(obj.target_component);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();
            
            for i = 1:8
                obj.controls(i) = payload.getSINGLE();
            end
                            
			obj.group_mlx = payload.getUINT8();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

		end
            
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | set_actuator_control_target.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                
        function set.controls(obj,value)
            obj.controls = single(value);
        end
                                    
        function set.group_mlx(obj,value)
            if value == uint8(value)
                obj.group_mlx = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | set_actuator_control_target.set.group_mlx()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | set_actuator_control_target.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | set_actuator_control_target.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end