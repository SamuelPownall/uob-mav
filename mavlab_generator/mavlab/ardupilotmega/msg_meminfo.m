classdef msg_meminfo < mavlink_message
	%MSG_MEMINFO: MAVLINK Message ID = 152
    %Description:
    %    state of APM memory
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
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

        function obj = msg_meminfo(packet,brkval,freemem)
        %Create a new meminfo message
        
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

        function packet = pack(obj)
        %PACK: Packs this MAVLINK message into a mavlink_packet
        %Description:
        %    Packs the fields of a message into a mavlink_packet which can be encoded
        %    for transmission.

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

        function unpack(obj, payload)
        %UNPACK: Unpacks a mavlink_payload into this MAVLINK message
        %Description:
        %    Extracts the data from a mavlink_payload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(mavlink_payload): The payload to be unpacked into this MAVLINK message

            payload.resetIndex();
            
            obj.brkval = payload.getUINT16();
            obj.freemem = payload.getUINT16();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

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