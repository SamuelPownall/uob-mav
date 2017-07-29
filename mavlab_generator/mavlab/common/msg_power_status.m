classdef msg_power_status < mavlink_message
	%MSG_POWER_STATUS: MAVLINK Message ID = 125
    %Description:
    %    Power supply status
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
    %    Vcc(uint16): 5V rail voltage in millivolts
    %    Vservo(uint16): servo rail voltage in millivolts
    %    flags(uint16): power supply status flags (see MAV_POWER_STATUS enum)
	
	properties(Constant)
		ID = 125
		LEN = 6
	end
	
	properties
        Vcc	%5V rail voltage in millivolts	|	(uint16)
        Vservo	%servo rail voltage in millivolts	|	(uint16)
        flags	%power supply status flags (see MAV_POWER_STATUS enum)	|	(uint16)
    end

    methods

        function obj = msg_power_status(packet,Vcc,Vservo,flags)
        %Create a new power_status message
        
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
            
            elseif nargin-1 == 3
                obj.Vcc = Vcc;
                obj.Vservo = Vservo;
                obj.flags = flags;
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

                packet = mavlink_packet(msg_power_status.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_power_status.ID;
                
                packet.payload.putUINT16(obj.Vcc);
                packet.payload.putUINT16(obj.Vservo);
                packet.payload.putUINT16(obj.flags);

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
            
            obj.Vcc = payload.getUINT16();
            obj.Vservo = payload.getUINT16();
            obj.flags = payload.getUINT16();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.Vcc,2) ~= 1
                result = 'Vcc';
            elseif size(obj.Vservo,2) ~= 1
                result = 'Vservo';
            elseif size(obj.flags,2) ~= 1
                result = 'flags';

            else
                result = 0;
            end
        end

        function set.Vcc(obj,value)
            if value == uint16(value)
                obj.Vcc = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.Vservo(obj,value)
            if value == uint16(value)
                obj.Vservo = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.flags(obj,value)
            if value == uint16(value)
                obj.flags = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
    end

end