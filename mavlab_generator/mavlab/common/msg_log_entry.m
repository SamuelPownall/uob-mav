classdef msg_log_entry < mavlink_message
	%MSG_LOG_ENTRY(packet,time_utc,size,id,num_logs,last_log_num): MAVLINK Message ID = 118
    %Description:
    %    Reply to LOG_REQUEST_LIST
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    time_utc(uint32): UTC timestamp of log in seconds since 1970, or 0 if not available
    %    size(uint32): Size of the log (may be approximate) in bytes
    %    id(uint16): Log id
    %    num_logs(uint16): Total number of logs
    %    last_log_num(uint16): High log number
	
	properties(Constant)
		ID = 118
		LEN = 14
	end
	
	properties
        time_utc	%UTC timestamp of log in seconds since 1970, or 0 if not available	|	(uint32)
        size	%Size of the log (may be approximate) in bytes	|	(uint32)
        id	%Log id	|	(uint16)
        num_logs	%Total number of logs	|	(uint16)
        last_log_num	%High log number	|	(uint16)
    end

    methods

        %Constructor: msg_log_entry
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_log_entry(packet,time_utc,size,id,num_logs,last_log_num)
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(packet,'mavlink_packet')
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('packet','mavlink_packet');
                end
            
            elseif nargin-1 == 5
                obj.time_utc = time_utc;
                obj.size = size;
                obj.id = id;
                obj.num_logs = num_logs;
                obj.last_log_num = last_log_num;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_log_entry.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_log_entry.ID;
                
                packet.payload.putUINT32(obj.time_utc);
                packet.payload.putUINT32(obj.size);
                packet.payload.putUINT16(obj.id);
                packet.payload.putUINT16(obj.num_logs);
                packet.payload.putUINT16(obj.last_log_num);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.time_utc = payload.getUINT32();
            obj.size = payload.getUINT32();
            obj.id = payload.getUINT16();
            obj.num_logs = payload.getUINT16();
            obj.last_log_num = payload.getUINT16();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.time_utc,2) ~= 1
                result = 'time_utc';
            elseif size(obj.size,2) ~= 1
                result = 'size';
            elseif size(obj.id,2) ~= 1
                result = 'id';
            elseif size(obj.num_logs,2) ~= 1
                result = 'num_logs';
            elseif size(obj.last_log_num,2) ~= 1
                result = 'last_log_num';

            else
                result = 0;
            end
        end

        function set.time_utc(obj,value)
            if value == uint32(value)
                obj.time_utc = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.size(obj,value)
            if value == uint32(value)
                obj.size = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.id(obj,value)
            if value == uint16(value)
                obj.id = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.num_logs(obj,value)
            if value == uint16(value)
                obj.num_logs = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.last_log_num(obj,value)
            if value == uint16(value)
                obj.last_log_num = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
    end

end