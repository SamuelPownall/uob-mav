classdef msg_statustext < MAVLinkMessage
	%MSG_STATUSTEXT: MAVLink Message ID = 253
    %Description:
    %    Status text message. These messages are printed in yellow in the COMM console of QGroundControl. WARNING: They consume quite some bandwidth, so use only for important status and error messages. If implemented wisely, these messages are buffered on the MCU and sent only at a limited rate (e.g. 10 Hz).
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    severity(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    severity(uint8): Severity of status. Relies on the definitions within RFC-5424. See enum MAV_SEVERITY.
    %    text(uint8[50]): Status text message, without null termination character
	
	properties(Constant)
		ID = 253
		LEN = 51
	end
	
	properties
        severity	%Severity of status. Relies on the definitions within RFC-5424. See enum MAV_SEVERITY.	|	(uint8)
        text	%Status text message, without null termination character	|	(uint8[50])
    end

    methods(Static)

        function send(out,severity,text,varargin)

            if nargin == 2 + 1
                msg = msg_statustext(severity,text,varargin);
            elseif nargin == 2
                msg = msg_statustext(severity);
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

        function obj = msg_statustext(severity,text,varargin)
        %MSG_STATUSTEXT: Create a new statustext message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(severity,'MAVLinkPacket')
                    packet = severity;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('severity','MAVLinkPacket');
                end
            elseif nargin >= 2 && isempty(varargin{1})
                obj.severity = severity;
                obj.text = text;
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

                packet = MAVLinkPacket(msg_statustext.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_statustext.ID;
                
                packet.payload.putUINT8(obj.severity);
                for i=1:1:50
                    packet.payload.putUINT8(obj.text(i));
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
            
            obj.severity = payload.getUINT8();
            for i=1:1:50
                obj.text(i) = payload.getUINT8();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.severity,2) ~= 1
                result = 'severity';
            elseif size(obj.text,2) ~= 50
                result = 'text';

            else
                result = 0;
            end
        end

        function set.severity(obj,value)
            if value == uint8(value)
                obj.severity = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.text(obj,value)
            if value == uint8(value)
                obj.text = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end