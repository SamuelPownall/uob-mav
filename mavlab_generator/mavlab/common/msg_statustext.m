classdef msg_statustext < mavlink_handle
	%MSG_STATUSTEXT(packet,severity,text): MAVLINK Message ID = 253
    %Description:
    %    Status text message. These messages are printed in yellow in the COMM console of QGroundControl. WARNING: They consume quite some bandwidth, so use only for important status and error messages. If implemented wisely, these messages are buffered on the MCU and sent only at a limited rate (e.g. 10 Hz).
    %    If constructing from fields, packet argument should be set to []
	%Fields:
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

        %Constructor: msg_statustext
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_statustext(packet,severity,text)
        
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
                obj.severity = severity;
                obj.text = text;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

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

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.severity = payload.getUINT8();
            for i=1:1:50
                obj.text(i) = payload.getUINT8();
            end

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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