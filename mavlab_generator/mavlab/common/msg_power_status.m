classdef msg_power_status < mavlink_handle
	%MSG_POWER_STATUS(packet,Vcc,Vservo,flags): MAVLINK Message ID = 125
    %Description:
    %    Power supply status
    %    If constructing from fields, packet argument should be set to []
	%Fields:
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

        %Constructor: msg_power_status
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_power_status(packet,Vcc,Vservo,flags)
        
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

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

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

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.Vcc = payload.getUINT16();
            obj.Vservo = payload.getUINT16();
            obj.flags = payload.getUINT16();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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