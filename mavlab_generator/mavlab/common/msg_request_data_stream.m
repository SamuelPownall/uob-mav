classdef msg_request_data_stream < mavlink_message
    %MAVLINK Message Class
    %Name: request_data_stream	ID: 66
    %Description: THIS INTERFACE IS DEPRECATED. USE SET_MESSAGE_INTERVAL INSTEAD.
            
    properties(Constant)
        ID = 66
        LEN = 6
    end
    
    properties        
		req_message_rate	%The requested message rate (uint16)
		target_system	%The target requested to send the message stream. (uint8)
		target_component	%The target requested to send the message stream. (uint8)
		req_stream_id	%The ID of the requested data stream (uint8)
		start_stop	%1 to start sending, 0 to stop sending. (uint8)
	end
    
    methods
        
        %Constructor: msg_request_data_stream
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_request_data_stream(packet)
        
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
        
                packet = mavlink_packet(msg_request_data_stream.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_request_data_stream.ID;
                
				packet.payload.putUINT16(obj.req_message_rate);

				packet.payload.putUINT8(obj.target_system);

				packet.payload.putUINT8(obj.target_component);

				packet.payload.putUINT8(obj.req_stream_id);

				packet.payload.putUINT8(obj.start_stop);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_request_data_stream.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.req_message_rate = payload.getUINT16();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

			obj.req_stream_id = payload.getUINT8();

			obj.start_stop = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.req_message_rate,2) ~= 1
                result = 'req_message_rate';                                        
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';                                        
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';                                        
            elseif size(obj.req_stream_id,2) ~= 1
                result = 'req_stream_id';                                        
            elseif size(obj.start_stop,2) ~= 1
                result = 'start_stop';                            
            else
                result = 0;
            end
            
        end
                                
        function set.req_message_rate(obj,value)
            if value == uint16(value)
                obj.req_message_rate = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | request_data_stream.set.req_message_rate()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | request_data_stream.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | request_data_stream.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.req_stream_id(obj,value)
            if value == uint8(value)
                obj.req_stream_id = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | request_data_stream.set.req_stream_id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.start_stop(obj,value)
            if value == uint8(value)
                obj.start_stop = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | request_data_stream.set.start_stop()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end