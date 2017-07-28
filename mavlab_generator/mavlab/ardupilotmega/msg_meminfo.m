classdef msg_meminfo < mavlink_message
	%MSG_MEMINFO(packet,brkval,freemem): MAVLINK Message ID = 152
    %Description:
    %    state of APM memory
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    brkval(uint16): heap top
    %    freemem(uint16): free memory
	
	properties(Constant)
		ID = 152
		LEN = 4
	end
	
	properties
        brkval	%heap top	|	(uint16)
        freemem	%free memory	|	(uint16)
    end

    methods

        %Constructor: msg_meminfo
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_meminfo(packet,brkval,freemem)
        
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
            
            elseif nargin-1 == 2
                obj.brkval = brkval;
                obj.freemem = freemem;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_meminfo.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_meminfo.ID;
                
                packet.payload.putUINT16(obj.brkval);
                packet.payload.putUINT16(obj.freemem);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.brkval = payload.getUINT16();
            obj.freemem = payload.getUINT16();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.brkval,2) ~= 1
                result = 'brkval';
            elseif size(obj.freemem,2) ~= 1
                result = 'freemem';

            else
                result = 0;
            end
        end

        function set.brkval(obj,value)
            if value == uint16(value)
                obj.brkval = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.freemem(obj,value)
            if value == uint16(value)
                obj.freemem = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
    end

end