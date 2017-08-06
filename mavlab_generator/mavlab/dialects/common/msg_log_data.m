classdef msg_log_data < MAVLinkMessage
	%MSG_LOG_DATA: MAVLink Message ID = 120
    %Description:
    %    Reply to LOG_REQUEST_DATA
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    ofs(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    ofs(uint32): Offset into the log
    %    id(uint16): Log id (from LOG_ENTRY reply)
    %    count(uint8): Number of bytes (zero for end of log)
    %    data(uint8[90]): log data
	
	properties(Constant)
		ID = 120
		LEN = 97
	end
	
	properties
        ofs	%Offset into the log	|	(uint32)
        id	%Log id (from LOG_ENTRY reply)	|	(uint16)
        count	%Number of bytes (zero for end of log)	|	(uint8)
        data	%log data	|	(uint8[90])
    end

    methods(Static)

        function send(out,ofs,id,count,data,varargin)

            if nargin == 4 + 1
                msg = msg_log_data(ofs,id,count,data,varargin);
            elseif nargin == 2
                msg = msg_log_data(ofs);
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

        function obj = msg_log_data(ofs,id,count,data,varargin)
        %MSG_LOG_DATA: Create a new log_data message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(ofs,'MAVLinkPacket')
                    packet = ofs;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('ofs','MAVLinkPacket');
                end
            elseif nargin >= 4 && isempty(varargin{1})
                obj.ofs = ofs;
                obj.id = id;
                obj.count = count;
                obj.data = data;
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

                packet = MAVLinkPacket(msg_log_data.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_log_data.ID;
                
                packet.payload.putUINT32(obj.ofs);
                packet.payload.putUINT16(obj.id);
                packet.payload.putUINT8(obj.count);
                for i=1:1:90
                    packet.payload.putUINT8(obj.data(i));
                end

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
            
            obj.ofs = payload.getUINT32();
            obj.id = payload.getUINT16();
            obj.count = payload.getUINT8();
            for i=1:1:90
                obj.data(i) = payload.getUINT8();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.ofs,2) ~= 1
                result = 'ofs';
            elseif size(obj.id,2) ~= 1
                result = 'id';
            elseif size(obj.count,2) ~= 1
                result = 'count';
            elseif size(obj.data,2) ~= 90
                result = 'data';

            else
                result = 0;
            end
        end

        function set.ofs(obj,value)
            if value == uint32(value)
                obj.ofs = uint32(value);
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
        
        function set.count(obj,value)
            if value == uint8(value)
                obj.count = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.data(obj,value)
            if value == uint8(value)
                obj.data = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end