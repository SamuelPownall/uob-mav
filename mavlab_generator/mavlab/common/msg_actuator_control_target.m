classdef msg_actuator_control_target < mavlink_message
    %MAVLINK Message Class
    %Name: actuator_control_target	ID: 140
    %Description: Set the vehicle attitude and body angular rates.
            
    properties(Constant)
        ID = 140
        LEN = 41
    end
    
    properties        
		time_usec	%Timestamp (micros since boot or Unix epoch) (uint64)
		controls	%Actuator controls. Normed to -1..+1 where 0 is neutral position. Throttle for single rotation direction motors is 0..1, negative range for reverse direction. Standard mapping for attitude controls (group 0): (index 0-7): roll, pitch, yaw, throttle, flaps, spoilers, airbrakes, landing gear. Load a pass-through mixer to repurpose them as generic outputs. (single[8])
		group_mlx	%Actuator group. The "_mlx" indicates this is a multi-instance message and a MAVLink parser should use this field to difference between instances. (uint8)
	end
    
    methods
        
        %Constructor: msg_actuator_control_target
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_actuator_control_target(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            emptyField = obj.verify();
            if emptyField == 0
        
                packet = mavlink_packet(msg_actuator_control_target.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_actuator_control_target.ID;
                
				packet.payload.putUINT64(obj.time_usec);
            
                for i = 1:8
                    packet.payload.putSINGLE(obj.controls(i));
                end
                                
				packet.payload.putUINT8(obj.group_mlx);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_actuator_control_target.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();
            
            for i = 1:8
                obj.controls(i) = payload.getSINGLE();
            end
                            
			obj.group_mlx = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_usec,2) ~= 1
                result = 'time_usec';                                        
            elseif size(obj.controls,2) ~= 8
                result = 'controls';                                        
            elseif size(obj.group_mlx,2) ~= 1
                result = 'group_mlx';                            
            else
                result = 0;
            end
            
        end
                                
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | actuator_control_target.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                
        function set.controls(obj,value)
            obj.controls = single(value);
        end
                                    
        function set.group_mlx(obj,value)
            if value == uint8(value)
                obj.group_mlx = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | actuator_control_target.set.group_mlx()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end