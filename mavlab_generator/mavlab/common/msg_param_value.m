classdef msg_param_value < mavlink_message
    %MAVLINK Message Class
    %Name: param_value	ID: 22
    %Description: Emit the value of a onboard parameter. The inclusion of param_count and param_index in the message allows the recipient to keep track of received parameters and allows him to re-request missing parameters after a loss or timeout.
            
    properties(Constant)
        ID = 22
        LEN = 25
    end
    
    properties        
		param_value	%Onboard parameter value (single[1])
		param_count	%Total number of onboard parameters (uint16[1])
		param_index	%Index of this onboard parameter (uint16[1])
		param_id	%Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string (uint8[16])
		param_type	%Onboard parameter type: see the MAV_PARAM_TYPE enum for supported data types. (uint8[1])
	end

    
    methods
        
        %Constructor: msg_param_value
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_param_value(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_param_value.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_param_value.ID;
                
			packet.payload.putSINGLE(obj.param_value);

			packet.payload.putUINT16(obj.param_count);

			packet.payload.putUINT16(obj.param_index);
            
            for i = 1:16
                packet.payload.putUINT8(obj.param_id(i));
            end
                            
			packet.payload.putUINT8(obj.param_type);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.param_value = payload.getSINGLE();

			obj.param_count = payload.getUINT16();

			obj.param_index = payload.getUINT16();
            
            for i = 1:16
                obj.param_id(i) = payload.getUINT8();
            end
                            
			obj.param_type = payload.getUINT8();

		end
        
        function set.param_value(obj,value)
            obj.param_value = single(value);
        end
                                    
        function set.param_count(obj,value)
            if value == uint16(value)
                obj.param_count = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | param_value.set.param_count()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.param_index(obj,value)
            if value == uint16(value)
                obj.param_index = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | param_value.set.param_index()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.param_id(obj,value)
            if value == uint8(value)
                obj.param_id = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | param_value.set.param_id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.param_type(obj,value)
            if value == uint8(value)
                obj.param_type = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | param_value.set.param_type()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end