classdef msg_hwstatus < MAVLinkMessage
	%MSG_HWSTATUS: MAVLink Message ID = 165
    %Description:
    %    Status of key hardware
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    Vcc(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    Vcc(uint16): board voltage (mV)
    %    I2Cerr(uint8): I2C error count
	
	properties(Constant)
		ID = 165
		LEN = 3
	end
	
	properties
        Vcc	%board voltage (mV)	|	(uint16)
        I2Cerr	%I2C error count	|	(uint8)
    end

    methods(Static)

        function send(out,Vcc,I2Cerr,varargin)

            if nargin == 2 + 1
                msg = msg_hwstatus(Vcc,I2Cerr,varargin);
            elseif nargin == 2
                msg = msg_hwstatus(Vcc);
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

        function obj = msg_hwstatus(Vcc,I2Cerr,varargin)
        %MSG_HWSTATUS: Create a new hwstatus message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(Vcc,'MAVLinkPacket')
                    packet = Vcc;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('Vcc','MAVLinkPacket');
                end
            elseif nargin >= 2 && isempty(varargin{1})
                obj.Vcc = Vcc;
                obj.I2Cerr = I2Cerr;
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

                packet = MAVLinkPacket(msg_hwstatus.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_hwstatus.ID;
                
                packet.payload.putUINT16(obj.Vcc);
                packet.payload.putUINT8(obj.I2Cerr);

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
            
            obj.Vcc = payload.getUINT16();
            obj.I2Cerr = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.Vcc,2) ~= 1
                result = 'Vcc';
            elseif size(obj.I2Cerr,2) ~= 1
                result = 'I2Cerr';

            else
                result = 0;
            end
        end

        function set.Vcc(obj,value)
            if value == uint16(value)
                obj.Vcc = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.I2Cerr(obj,value)
            if value == uint8(value)
                obj.I2Cerr = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end