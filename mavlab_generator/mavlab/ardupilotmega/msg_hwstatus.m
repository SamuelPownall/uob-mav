classdef msg_hwstatus < mavlink_message
	%MSG_HWSTATUS: MAVLINK Message ID = 165
    %Description:
    %    Status of key hardware
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
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

        function obj = msg_hwstatus(packet,Vcc,I2Cerr)
        %Create a new hwstatus message
        
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

        function packet = pack(obj)
        %PACK: Packs this MAVLINK message into a mavlink_packet
        %Description:
        %    Packs the fields of a message into a mavlink_packet which can be encoded
        %    for transmission.

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

        function unpack(obj, payload)
        %UNPACK: Unpacks a mavlink_payload into this MAVLINK message
        %Description:
        %    Extracts the data from a mavlink_payload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(mavlink_payload): The payload to be unpacked into this MAVLINK message

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