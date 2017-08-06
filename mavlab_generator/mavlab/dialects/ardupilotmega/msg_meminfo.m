classdef msg_meminfo < MAVLinkMessage
	%MSG_MEMINFO: MAVLink Message ID = 152
    %Description:
    %    state of APM memory
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    brkval(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,brkval,freemem,varargin)

            if nargin == 2 + 1
                msg = msg_meminfo(brkval,freemem,varargin);
            elseif nargin == 2
                msg = msg_meminfo(brkval);
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

        function obj = msg_meminfo(brkval,freemem,varargin)
        %MSG_MEMINFO: Create a new meminfo message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(brkval,'MAVLinkPacket')
                    packet = brkval;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('brkval','MAVLinkPacket');
                end
            elseif nargin >= 2 && isempty(varargin{1})
                obj.brkval = brkval;
                obj.freemem = freemem;
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

                packet = MAVLinkPacket(msg_meminfo.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_meminfo.ID;
                
                packet.payload.putUINT16(obj.brkval);
                packet.payload.putUINT16(obj.freemem);

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
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.freemem(obj,value)
            if value == uint16(value)
                obj.freemem = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
    end

end