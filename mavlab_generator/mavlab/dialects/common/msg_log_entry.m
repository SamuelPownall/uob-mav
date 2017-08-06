classdef msg_log_entry < MAVLinkMessage
	%MSG_LOG_ENTRY: MAVLink Message ID = 118
    %Description:
    %    Reply to LOG_REQUEST_LIST
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_utc(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,time_utc,size,id,num_logs,last_log_num,varargin)

            if nargin == 5 + 1
                msg = msg_log_entry(time_utc,size,id,num_logs,last_log_num,varargin);
            elseif nargin == 2
                msg = msg_log_entry(time_utc);
            else
                MAVLink.throwCustomError('The number of function arguments is not valid');
                return;
            end

            packet = msg.pack();
            if ~isempty(packet)
                buffer = packet.encode();
                write(out,buffer);
            else
                MAVLink.throwCustomError('The packet could not be verified');
            end
        
        end

    end

    methods

        function obj = msg_log_entry(time_utc,size,id,num_logs,last_log_num,varargin)
        %MSG_LOG_ENTRY: Create a new log_entry message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(time_utc,'MAVLinkPacket')
                    packet = time_utc;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('time_utc','MAVLinkPacket');
                end
            elseif nargin >= 5 && isempty(varargin{1})
                obj.time_utc = time_utc;
                obj.size = size;
                obj.id = id;
                obj.num_logs = num_logs;
                obj.last_log_num = last_log_num;
            elseif nargin ~= 0
                MAVLink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        function packet = pack(obj)
        %PACK: Packs this MAVLink message into a MAVLinkPacket
        %Description:
        %    Packs the fields of a message into a MAVLinkPacket which can be encoded
        %    for transmission.

            errorField = obj.verify();
            if errorField == 0

                packet = MAVLinkPacket(msg_log_entry.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_log_entry.ID;
                
                packet.payload.putUINT32(obj.time_utc);
                packet.payload.putUINT32(obj.size);
                packet.payload.putUINT16(obj.id);
                packet.payload.putUINT16(obj.num_logs);
                packet.payload.putUINT16(obj.last_log_num);

            else
                packet = [];
                MAVLink.throwPackingError(errorField);
            end

        end

        function unpack(obj, payload)
        %UNPACK: Unpacks a MAVLinkPayload into this MAVLink message
        %Description:
        %    Extracts the data from a MAVLinkPayload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(MAVLinkPayload): The payload to be unpacked into this MAVLink message

            payload.resetIndex();
            
            obj.time_utc = payload.getUINT32();
            obj.size = payload.getUINT32();
            obj.id = payload.getUINT16();
            obj.num_logs = payload.getUINT16();
            obj.last_log_num = payload.getUINT16();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

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
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.size(obj,value)
            if value == uint32(value)
                obj.size = uint32(value);
            else
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.id(obj,value)
            if value == uint16(value)
                obj.id = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.num_logs(obj,value)
            if value == uint16(value)
                obj.num_logs = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.last_log_num(obj,value)
            if value == uint16(value)
                obj.last_log_num = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
    end

end