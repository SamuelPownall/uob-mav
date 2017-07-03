classdef msg_message_interval < mavlink_message
    %MAVLINK Message Class
    %Name: message_interval	ID: 244
    %Description: This interface replaces DATA_STREAM
            
    properties(Constant)
        ID = 244
        LEN = 6
    end
    
    properties        
		interval_us	%The interval between two messages, in microseconds. A value of -1 indicates this stream is disabled, 0 indicates it is not available, > 0 indicates the interval at which it is sent. (int32)
		message_id	%The ID of the requested MAVLink message. v1.0 is limited to 254 messages. (uint16)
	end
    
    methods
        
        %Constructor: msg_message_interval
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_message_interval(packet)
        
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
        
                packet = mavlink_packet(msg_message_interval.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_message_interval.ID;
                
				packet.payload.putINT32(obj.interval_us);

				packet.payload.putUINT16(obj.message_id);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_message_interval.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.interval_us = payload.getINT32();

			obj.message_id = payload.getUINT16();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.interval_us,2) ~= 1
                result = 'interval_us';                                        
            elseif size(obj.message_id,2) ~= 1
                result = 'message_id';                            
            else
                result = 0;
            end
            
        end
                                
        function set.interval_us(obj,value)
            if value == int32(value)
                obj.interval_us = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | message_interval.set.interval_us()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.message_id(obj,value)
            if value == uint16(value)
                obj.message_id = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | message_interval.set.message_id()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                        
	end
end