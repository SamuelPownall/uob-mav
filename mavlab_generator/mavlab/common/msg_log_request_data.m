classdef msg_log_request_data < mavlink_message
    %MAVLINK Message Class
    %Name: log_request_data	ID: 119
    %Description: Request a chunk of a log
            
    properties(Constant)
        ID = 119
        LEN = 12
    end
    
    properties        
		ofs	%Offset into the log (uint32)
		count	%Number of bytes (uint32)
		id	%Log id (from LOG_ENTRY reply) (uint16)
		target_system	%System ID (uint8)
		target_component	%Component ID (uint8)
	end
    
    methods
        
        %Constructor: msg_log_request_data
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_log_request_data(packet)
        
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
        
                packet = mavlink_packet(msg_log_request_data.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_log_request_data.ID;
                
				packet.payload.putUINT32(obj.ofs);

				packet.payload.putUINT32(obj.count);

				packet.payload.putUINT16(obj.id);

				packet.payload.putUINT8(obj.target_system);

				packet.payload.putUINT8(obj.target_component);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_log_request_data.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.ofs = payload.getUINT32();

			obj.count = payload.getUINT32();

			obj.id = payload.getUINT16();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.ofs,2) ~= 1
                result = 'ofs';                                        
            elseif size(obj.count,2) ~= 1
                result = 'count';                                        
            elseif size(obj.id,2) ~= 1
                result = 'id';                                        
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';                                        
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';                            
            else
                result = 0;
            end
            
        end
                                
        function set.ofs(obj,value)
            if value == uint32(value)
                obj.ofs = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | log_request_data.set.ofs()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.count(obj,value)
            if value == uint32(value)
                obj.count = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | log_request_data.set.count()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.id(obj,value)
            if value == uint16(value)
                obj.id = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | log_request_data.set.id()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | log_request_data.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | log_request_data.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end