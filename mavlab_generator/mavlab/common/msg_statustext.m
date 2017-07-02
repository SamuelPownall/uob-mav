classdef msg_statustext < mavlink_message
    %MAVLINK Message Class
    %Name: statustext	ID: 253
    %Description: Status text message. These messages are printed in yellow in the COMM console of QGroundControl. WARNING: They consume quite some bandwidth, so use only for important status and error messages. If implemented wisely, these messages are buffered on the MCU and sent only at a limited rate (e.g. 10 Hz).
            
    properties(Constant)
        ID = 253
        LEN = 51
    end
    
    properties        
		severity	%Severity of status. Relies on the definitions within RFC-5424. See enum MAV_SEVERITY. (uint8[1])
		text	%Status text message, without null termination character (uint8[50])
	end

    
    methods
        
        %Constructor: msg_statustext
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_statustext(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_statustext.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_statustext.ID;
                
			packet.payload.putUINT8(obj.severity);
            
            for i = 1:50
                packet.payload.putUINT8(obj.text(i));
            end
                            
		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.severity = payload.getUINT8();
            
            for i = 1:50
                obj.text(i) = payload.getUINT8();
            end
                            
		end
            
        function set.severity(obj,value)
            if value == uint8(value)
                obj.severity = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | statustext.set.severity()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.text(obj,value)
            if value == uint8(value)
                obj.text = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | statustext.set.text()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end