classdef msg_change_operator_control_ack < mavlink_message
    %MAVLINK Message Class
    %Name: change_operator_control_ack	ID: 6
    %Description: Accept / deny control of this MAV
            
    properties(Constant)
        ID = 6
        LEN = 3
    end
    
    properties        
		gcs_system_id	%ID of the GCS this message  (uint8)
		control_request	%0: request control of this MAV, 1: Release control of this MAV (uint8)
		ack	%0: ACK, 1: NACK: Wrong passkey, 2: NACK: Unsupported passkey encryption method, 3: NACK: Already under control (uint8)
	end
    
    methods
        
        %Constructor: msg_change_operator_control_ack
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_change_operator_control_ack(packet)
        
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
        
                packet = mavlink_packet(msg_change_operator_control_ack.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_change_operator_control_ack.ID;
                
				packet.payload.putUINT8(obj.gcs_system_id);

				packet.payload.putUINT8(obj.control_request);

				packet.payload.putUINT8(obj.ack);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_change_operator_control_ack.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.gcs_system_id = payload.getUINT8();

			obj.control_request = payload.getUINT8();

			obj.ack = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.gcs_system_id,2) ~= 1
                result = 'gcs_system_id';                                        
            elseif size(obj.control_request,2) ~= 1
                result = 'control_request';                                        
            elseif size(obj.ack,2) ~= 1
                result = 'ack';                            
            else
                result = 0;
            end
            
        end
                                
        function set.gcs_system_id(obj,value)
            if value == uint8(value)
                obj.gcs_system_id = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | change_operator_control_ack.set.gcs_system_id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.control_request(obj,value)
            if value == uint8(value)
                obj.control_request = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | change_operator_control_ack.set.control_request()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.ack(obj,value)
            if value == uint8(value)
                obj.ack = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | change_operator_control_ack.set.ack()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end