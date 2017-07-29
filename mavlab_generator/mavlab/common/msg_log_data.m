classdef msg_log_data < mavlink_handle
	%MSG_LOG_DATA(packet,ofs,id,count,data): MAVLINK Message ID = 120
    %Description:
    %    Reply to LOG_REQUEST_DATA
    %    If constructing from fields, packet argument should be set to []
	%Fields:
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

    methods

        %Constructor: msg_log_data
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_log_data(packet,ofs,id,count,data)
        
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
            
            elseif nargin-1 == 4
                obj.ofs = ofs;
                obj.id = id;
                obj.count = count;
                obj.data = data;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_log_data.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_log_data.ID;
                
                packet.payload.putUINT32(obj.ofs);
                packet.payload.putUINT16(obj.id);
                packet.payload.putUINT8(obj.count);
                for i=1:1:90
                    packet.payload.putUINT8(obj.data(i));
                end

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.ofs = payload.getUINT32();
            obj.id = payload.getUINT16();
            obj.count = payload.getUINT8();
            for i=1:1:90
                obj.data(i) = payload.getUINT8();
            end

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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
        
        function set.count(obj,value)
            if value == uint8(value)
                obj.count = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.data(obj,value)
            if value == uint8(value)
                obj.data = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end