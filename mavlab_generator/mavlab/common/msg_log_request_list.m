classdef msg_log_request_list < mavlink_message
    %MAVLINK Message Class
    %Name: log_request_list	ID: 117
    %Description: Request a list of available logs. On some systems calling this may stop on-board logging until LOG_REQUEST_END is called.
            
    properties(Constant)
        ID = 117
        LEN = 6
    end
    
    properties        
		start	%First log id (0 for first available) (uint16[1])
		end	%Last log id (0xffff for last available) (uint16[1])
		target_system	%System ID (uint8[1])
		target_component	%Component ID (uint8[1])
	end

    
    methods
        
        %Constructor: msg_log_request_list
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_log_request_list(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_log_request_list.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_log_request_list.ID;
                
			packet.payload.putUINT16(obj.start);

			packet.payload.putUINT16(obj.end);

			packet.payload.putUINT8(obj.target_system);

			packet.payload.putUINT8(obj.target_component);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.start = payload.getUINT16();

			obj.end = payload.getUINT16();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

		end
            
        function set.start(obj,value)
            if value == uint16(value)
                obj.start = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | log_request_list.set.start()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.end(obj,value)
            if value == uint16(value)
                obj.end = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | log_request_list.set.end()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | log_request_list.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | log_request_list.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end