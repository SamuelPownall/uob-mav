classdef msg_encapsulated_data < MAVLinkMessage
	%MSG_ENCAPSULATED_DATA: MAVLink Message ID = 131
    %Description:
    %    No description available
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    seqnr(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    seqnr(uint16): sequence number (starting with 0 on every transmission)
    %    data(uint8[127]): image data bytes
	
	properties(Constant)
		ID = 131
		LEN = 127
	end
	
	properties
        seqnr	%sequence number (starting with 0 on every transmission)	|	(uint16)
        data	%image data bytes	|	(uint8[127])
    end

    methods(Static)

        function send(out,seqnr,data,varargin)

            if nargin == 2 + 1
                msg = msg_encapsulated_data(seqnr,data,varargin);
            elseif nargin == 2
                msg = msg_encapsulated_data(seqnr);
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

        function obj = msg_encapsulated_data(seqnr,data,varargin)
        %MSG_ENCAPSULATED_DATA: Create a new encapsulated_data message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(seqnr,'MAVLinkPacket')
                    packet = seqnr;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('seqnr','MAVLinkPacket');
                end
            elseif nargin >= 2 && isempty(varargin{1})
                obj.seqnr = seqnr;
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

                packet = MAVLinkPacket(msg_encapsulated_data.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_encapsulated_data.ID;
                
                packet.payload.putUINT16(obj.seqnr);
                for i=1:1:127
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
            
            obj.seqnr = payload.getUINT16();
            for i=1:1:127
                obj.data(i) = payload.getUINT8();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.seqnr,2) ~= 1
                result = 'seqnr';
            elseif size(obj.data,2) ~= 127
                result = 'data';

            else
                result = 0;
            end
        end

        function set.seqnr(obj,value)
            if value == uint16(value)
                obj.seqnr = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
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