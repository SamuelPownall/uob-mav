classdef msg_fence_status < mavlink_message
	%MSG_FENCE_STATUS(packet,breach_time,breach_count,breach_status,breach_type): MAVLINK Message ID = 162
    %Description:
    %    Status of geo-fencing. Sent in extended
	    status stream when fencing enabled
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    breach_time(uint32): time of last breach in milliseconds since boot
    %    breach_count(uint16): number of fence breaches
    %    breach_status(uint8): 0 if currently inside fence, 1 if outside
    %    breach_type(uint8): last breach type (see FENCE_BREACH_* enum)
	
	properties(Constant)
		ID = 162
		LEN = 8
	end
	
	properties
        breach_time	%time of last breach in milliseconds since boot	|	(uint32)
        breach_count	%number of fence breaches	|	(uint16)
        breach_status	%0 if currently inside fence, 1 if outside	|	(uint8)
        breach_type	%last breach type (see FENCE_BREACH_* enum)	|	(uint8)
    end

    methods

        %Constructor: msg_fence_status
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_fence_status(packet,breach_time,breach_count,breach_status,breach_type)
        
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
                obj.breach_time = breach_time;
                obj.breach_count = breach_count;
                obj.breach_status = breach_status;
                obj.breach_type = breach_type;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_fence_status.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_fence_status.ID;
                
                packet.payload.putUINT32(obj.breach_time);
                packet.payload.putUINT16(obj.breach_count);
                packet.payload.putUINT8(obj.breach_status);
                packet.payload.putUINT8(obj.breach_type);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.breach_time = payload.getUINT32();
            obj.breach_count = payload.getUINT16();
            obj.breach_status = payload.getUINT8();
            obj.breach_type = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.breach_time,2) ~= 1
                result = 'breach_time';
            elseif size(obj.breach_count,2) ~= 1
                result = 'breach_count';
            elseif size(obj.breach_status,2) ~= 1
                result = 'breach_status';
            elseif size(obj.breach_type,2) ~= 1
                result = 'breach_type';

            else
                result = 0;
            end
        end

        function set.breach_time(obj,value)
            if value == uint32(value)
                obj.breach_time = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.breach_count(obj,value)
            if value == uint16(value)
                obj.breach_count = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.breach_status(obj,value)
            if value == uint8(value)
                obj.breach_status = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.breach_type(obj,value)
            if value == uint8(value)
                obj.breach_type = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end