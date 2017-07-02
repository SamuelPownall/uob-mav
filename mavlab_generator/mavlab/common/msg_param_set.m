classdef msg_param_set < mavlink_message
    %MAVLINK Message Class
    %Name: param_set	ID: 23
    %Description: Set a parameter value TEMPORARILY to RAM. It will be reset to default on system reboot. Send the ACTION MAV_ACTION_STORAGE_WRITE to PERMANENTLY write the RAM contents to EEPROM. IMPORTANT: The receiving component should acknowledge the new parameter value by sending a param_value message to all communication partners. This will also ensure that multiple GCS all have an up-to-date list of all parameters. If the sending GCS did not receive a PARAM_VALUE message within its timeout time, it should re-send the PARAM_SET message.
            
    properties(Constant)
        ID = 23
        LEN = 23
    end
    
    properties        
		param_value	%Onboard parameter value (single[1])
		target_system	%System ID (uint8[1])
		target_component	%Component ID (uint8[1])
		param_id	%Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string (uint8[16])
		param_type	%Onboard parameter type: see the MAV_PARAM_TYPE enum for supported data types. (uint8[1])
	end

    
    methods
        
        %Constructor: msg_param_set
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_param_set(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_param_set.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_param_set.ID;
                
			packet.payload.putSINGLE(obj.param_value);

			packet.payload.putUINT8(obj.target_system);

			packet.payload.putUINT8(obj.target_component);
            
            for i = 1:16
                packet.payload.putUINT8(obj.param_id(i));
            end
                            
			packet.payload.putUINT8(obj.param_type);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.param_value = payload.getSINGLE();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();
            
            for i = 1:16
                obj.param_id(i) = payload.getUINT8();
            end
                            
			obj.param_type = payload.getUINT8();

		end
        
        function set.param_value(obj,value)
            obj.param_value = single(value);
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | param_set.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | param_set.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.param_id(obj,value)
            if value == uint8(value)
                obj.param_id = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | param_set.set.param_id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.param_type(obj,value)
            if value == uint8(value)
                obj.param_type = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | param_set.set.param_type()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end