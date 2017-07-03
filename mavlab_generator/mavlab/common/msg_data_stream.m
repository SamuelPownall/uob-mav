classdef msg_data_stream < mavlink_message
    %MAVLINK Message Class
    %Name: data_stream	ID: 67
    %Description: THIS INTERFACE IS DEPRECATED. USE MESSAGE_INTERVAL INSTEAD.
            
    properties(Constant)
        ID = 67
        LEN = 4
    end
    
    properties        
		message_rate	%The message rate (uint16)
		stream_id	%The ID of the requested data stream (uint8)
		on_off	%1 stream is enabled, 0 stream is stopped. (uint8)
	end
    
    methods
        
        %Constructor: msg_data_stream
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_data_stream(packet)
        
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
        
                packet = mavlink_packet(msg_data_stream.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_data_stream.ID;
                
				packet.payload.putUINT16(obj.message_rate);

				packet.payload.putUINT8(obj.stream_id);

				packet.payload.putUINT8(obj.on_off);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_data_stream.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.message_rate = payload.getUINT16();

			obj.stream_id = payload.getUINT8();

			obj.on_off = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.message_rate,2) ~= 1
                result = 'message_rate';                                        
            elseif size(obj.stream_id,2) ~= 1
                result = 'stream_id';                                        
            elseif size(obj.on_off,2) ~= 1
                result = 'on_off';                            
            else
                result = 0;
            end
            
        end
                                
        function set.message_rate(obj,value)
            if value == uint16(value)
                obj.message_rate = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | data_stream.set.message_rate()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.stream_id(obj,value)
            if value == uint8(value)
                obj.stream_id = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | data_stream.set.stream_id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.on_off(obj,value)
            if value == uint8(value)
                obj.on_off = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | data_stream.set.on_off()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end