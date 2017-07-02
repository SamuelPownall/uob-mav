classdef msg_param_map_rc < mavlink_message
    %MAVLINK Message Class
    %Name: param_map_rc	ID: 50
    %Description: Bind a RC channel to a parameter. The parameter should change accoding to the RC channel value.
            
    properties(Constant)
        ID = 50
        LEN = 37
    end
    
    properties        
		param_value0	%Initial parameter value (single[1])
		scale	%Scale, maps the RC range [-1, 1] to a parameter value (single[1])
		param_value_min	%Minimum param value. The protocol does not define if this overwrites an onboard minimum value. (Depends on implementation) (single[1])
		param_value_max	%Maximum param value. The protocol does not define if this overwrites an onboard maximum value. (Depends on implementation) (single[1])
		param_index	%Parameter index. Send -1 to use the param ID field as identifier (else the param id will be ignored), send -2 to disable any existing map for this rc_channel_index. (int16[1])
		target_system	%System ID (uint8[1])
		target_component	%Component ID (uint8[1])
		param_id	%Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string (uint8[16])
		parameter_rc_channel_index	%Index of parameter RC channel. Not equal to the RC channel id. Typically correpsonds to a potentiometer-knob on the RC. (uint8[1])
	end

    
    methods
        
        %Constructor: msg_param_map_rc
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_param_map_rc(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_param_map_rc.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_param_map_rc.ID;
                
			packet.payload.putSINGLE(obj.param_value0);

			packet.payload.putSINGLE(obj.scale);

			packet.payload.putSINGLE(obj.param_value_min);

			packet.payload.putSINGLE(obj.param_value_max);

			packet.payload.putINT16(obj.param_index);

			packet.payload.putUINT8(obj.target_system);

			packet.payload.putUINT8(obj.target_component);
            
            for i = 1:16
                packet.payload.putUINT8(obj.param_id(i));
            end
                            
			packet.payload.putUINT8(obj.parameter_rc_channel_index);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.param_value0 = payload.getSINGLE();

			obj.scale = payload.getSINGLE();

			obj.param_value_min = payload.getSINGLE();

			obj.param_value_max = payload.getSINGLE();

			obj.param_index = payload.getINT16();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();
            
            for i = 1:16
                obj.param_id(i) = payload.getUINT8();
            end
                            
			obj.parameter_rc_channel_index = payload.getUINT8();

		end
        
        function set.param_value0(obj,value)
            obj.param_value0 = single(value);
        end
                                
        function set.scale(obj,value)
            obj.scale = single(value);
        end
                                
        function set.param_value_min(obj,value)
            obj.param_value_min = single(value);
        end
                                
        function set.param_value_max(obj,value)
            obj.param_value_max = single(value);
        end
                                    
        function set.param_index(obj,value)
            if value == int16(value)
                obj.param_index = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | param_map_rc.set.param_index()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | param_map_rc.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | param_map_rc.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.param_id(obj,value)
            if value == uint8(value)
                obj.param_id = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | param_map_rc.set.param_id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.parameter_rc_channel_index(obj,value)
            if value == uint8(value)
                obj.parameter_rc_channel_index = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | param_map_rc.set.parameter_rc_channel_index()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end