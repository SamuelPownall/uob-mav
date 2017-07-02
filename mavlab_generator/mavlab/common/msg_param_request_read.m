classdef msg_param_request_read < mavlink_message
    %MAVLINK Message Class
    %Name: param_request_read	ID: 20
    %Description: Request to read the onboard parameter with the param_id string id. Onboard parameters are stored as key[const char*] -> value[float]. This allows to send a parameter to any other component (such as the GCS) without the need of previous knowledge of possible parameter names. Thus the same GCS can store different parameters for different autopilots. See also http://qgroundcontrol.org/parameter_interface for a full documentation of QGroundControl and IMU code.
            
    properties(Constant)
        ID = 20
        LEN = 20
    end
    
    properties        
		param_index	%Parameter index. Send -1 to use the param ID field as identifier (else the param id will be ignored) (int16[1])
		target_system	%System ID (uint8[1])
		target_component	%Component ID (uint8[1])
		param_id	%Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string (uint8[16])
	end

    
    methods
        
        %Constructor: msg_param_request_read
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_param_request_read(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_param_request_read.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_param_request_read.ID;
                
			packet.payload.putINT16(obj.param_index);

			packet.payload.putUINT8(obj.target_system);

			packet.payload.putUINT8(obj.target_component);
            
            for i = 1:16
                packet.payload.putUINT8(obj.param_id(i));
            end
                            
		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.param_index = payload.getINT16();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();
            
            for i = 1:16
                obj.param_id(i) = payload.getUINT8();
            end
                            
		end
            
        function set.param_index(obj,value)
            if value == int16(value)
                obj.param_index = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | param_request_read.set.param_index()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | param_request_read.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | param_request_read.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.param_id(obj,value)
            if value == uint8(value)
                obj.param_id = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | param_request_read.set.param_id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end