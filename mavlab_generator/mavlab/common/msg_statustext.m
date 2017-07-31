classdef msg_statustext < mavlink_message
	%MSG_STATUSTEXT: MAVLINK Message ID = 253
    %Description:
    %    Status text message. These messages are printed in yellow in the COMM console of QGroundControl. WARNING: They consume quite some bandwidth, so use only for important status and error messages. If implemented wisely, these messages are buffered on the MCU and sent only at a limited rate (e.g. 10 Hz).
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    severity(mavlink_packet): Alternative way to construct a message using a mavlink_packet
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

    methods

        function obj = msg_statustext(severity,text,varargin)
        %MSG_STATUSTEXT: Create a new statustext message object
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1 
                if isa(severity,'mavlink_packet')
                    packet = severity;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('severity','mavlink_packet');
                end
            elseif nargin == 2
                obj.severity = severity;
                obj.text = text;
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

                packet = mavlink_packet(msg_statustext.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_statustext.ID;
                
                packet.payload.putUINT8(obj.severity);
                for i=1:1:50
                    packet.payload.putUINT8(obj.text(i));
                end

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
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.text(obj,value)
            if value == uint8(value)
                obj.text = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end