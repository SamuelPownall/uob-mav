classdef msg_hwstatus < mavlink_handle
	%MSG_HWSTATUS(packet,Vcc,I2Cerr): MAVLINK Message ID = 165
    %Description:
    %    Status of key hardware
    %    If constructing from fields, packet argument should be set to []
	%Fields:
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

    methods

        %Constructor: msg_hwstatus
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_hwstatus(packet,Vcc,I2Cerr)
        
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
                obj.Vcc = Vcc;
                obj.I2Cerr = I2Cerr;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_hwstatus.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_hwstatus.ID;
                
                packet.payload.putUINT16(obj.Vcc);
                packet.payload.putUINT8(obj.I2Cerr);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.Vcc = payload.getUINT16();
            obj.I2Cerr = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.I2Cerr(obj,value)
            if value == uint8(value)
                obj.I2Cerr = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end