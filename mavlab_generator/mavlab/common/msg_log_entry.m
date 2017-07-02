classdef msg_log_entry < mavlink_message
    %MAVLINK Message Class
    %Name: log_entry	ID: 118
    %Description: Reply to LOG_REQUEST_LIST
            
    properties(Constant)
        ID = 118
        LEN = 14
    end
    
    properties        
		time_utc	%UTC timestamp of log in seconds since 1970, or 0 if not available (uint32[1])
		size	%Size of the log (may be approximate) in bytes (uint32[1])
		id	%Log id (uint16[1])
		num_logs	%Total number of logs (uint16[1])
		last_log_num	%High log number (uint16[1])
	end

    
    methods
        
        %Constructor: msg_log_entry
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_log_entry(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_log_entry.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_log_entry.ID;
                
			packet.payload.putUINT32(obj.time_utc);

			packet.payload.putUINT32(obj.size);

			packet.payload.putUINT16(obj.id);

			packet.payload.putUINT16(obj.num_logs);

			packet.payload.putUINT16(obj.last_log_num);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_utc = payload.getUINT32();

			obj.size = payload.getUINT32();

			obj.id = payload.getUINT16();

			obj.num_logs = payload.getUINT16();

			obj.last_log_num = payload.getUINT16();

		end
            
        function set.time_utc(obj,value)
            if value == uint32(value)
                obj.time_utc = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | log_entry.set.time_utc()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.size(obj,value)
            if value == uint32(value)
                obj.size = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | log_entry.set.size()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.id(obj,value)
            if value == uint16(value)
                obj.id = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | log_entry.set.id()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.num_logs(obj,value)
            if value == uint16(value)
                obj.num_logs = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | log_entry.set.num_logs()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.last_log_num(obj,value)
            if value == uint16(value)
                obj.last_log_num = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | log_entry.set.last_log_num()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                        
	end
end