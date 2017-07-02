classdef msg_log_data < mavlink_message
    %MAVLINK Message Class
    %Name: log_data	ID: 120
    %Description: Reply to LOG_REQUEST_DATA
            
    properties(Constant)
        ID = 120
        LEN = 97
    end
    
    properties        
		ofs	%Offset into the log (uint32[1])
		id	%Log id (from LOG_ENTRY reply) (uint16[1])
		count	%Number of bytes (zero for end of log) (uint8[1])
		data	%log data (uint8[90])
	end

    
    methods
        
        %Constructor: msg_log_data
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_log_data(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_log_data.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_log_data.ID;
                
			packet.payload.putUINT32(obj.ofs);

			packet.payload.putUINT16(obj.id);

			packet.payload.putUINT8(obj.count);
            
            for i = 1:90
                packet.payload.putUINT8(obj.data(i));
            end
                            
		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.ofs = payload.getUINT32();

			obj.id = payload.getUINT16();

			obj.count = payload.getUINT8();
            
            for i = 1:90
                obj.data(i) = payload.getUINT8();
            end
                            
		end
            
        function set.ofs(obj,value)
            if value == uint32(value)
                obj.ofs = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | log_data.set.ofs()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.id(obj,value)
            if value == uint16(value)
                obj.id = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | log_data.set.id()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.count(obj,value)
            if value == uint8(value)
                obj.count = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | log_data.set.count()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.data(obj,value)
            if value == uint8(value)
                obj.data = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | log_data.set.data()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end