classdef msg_radio < mavlink_handle
	%MSG_RADIO(packet,rxerrors,fixed,rssi,remrssi,txbuf,noise,remnoise): MAVLINK Message ID = 166
    %Description:
    %    Status generated by radio
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    rxerrors(uint16): receive errors
    %    fixed(uint16): count of error corrected packets
    %    rssi(uint8): local signal strength
    %    remrssi(uint8): remote signal strength
    %    txbuf(uint8): how full the tx buffer is as a percentage
    %    noise(uint8): background noise level
    %    remnoise(uint8): remote background noise level
	
	properties(Constant)
		ID = 166
		LEN = 9
	end
	
	properties
        rxerrors	%receive errors	|	(uint16)
        fixed	%count of error corrected packets	|	(uint16)
        rssi	%local signal strength	|	(uint8)
        remrssi	%remote signal strength	|	(uint8)
        txbuf	%how full the tx buffer is as a percentage	|	(uint8)
        noise	%background noise level	|	(uint8)
        remnoise	%remote background noise level	|	(uint8)
    end

    methods

        %Constructor: msg_radio
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_radio(packet,rxerrors,fixed,rssi,remrssi,txbuf,noise,remnoise)
        
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
            
            elseif nargin-1 == 7
                obj.rxerrors = rxerrors;
                obj.fixed = fixed;
                obj.rssi = rssi;
                obj.remrssi = remrssi;
                obj.txbuf = txbuf;
                obj.noise = noise;
                obj.remnoise = remnoise;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_radio.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_radio.ID;
                
                packet.payload.putUINT16(obj.rxerrors);
                packet.payload.putUINT16(obj.fixed);
                packet.payload.putUINT8(obj.rssi);
                packet.payload.putUINT8(obj.remrssi);
                packet.payload.putUINT8(obj.txbuf);
                packet.payload.putUINT8(obj.noise);
                packet.payload.putUINT8(obj.remnoise);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.rxerrors = payload.getUINT16();
            obj.fixed = payload.getUINT16();
            obj.rssi = payload.getUINT8();
            obj.remrssi = payload.getUINT8();
            obj.txbuf = payload.getUINT8();
            obj.noise = payload.getUINT8();
            obj.remnoise = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.rxerrors,2) ~= 1
                result = 'rxerrors';
            elseif size(obj.fixed,2) ~= 1
                result = 'fixed';
            elseif size(obj.rssi,2) ~= 1
                result = 'rssi';
            elseif size(obj.remrssi,2) ~= 1
                result = 'remrssi';
            elseif size(obj.txbuf,2) ~= 1
                result = 'txbuf';
            elseif size(obj.noise,2) ~= 1
                result = 'noise';
            elseif size(obj.remnoise,2) ~= 1
                result = 'remnoise';

            else
                result = 0;
            end
        end

        function set.rxerrors(obj,value)
            if value == uint16(value)
                obj.rxerrors = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.fixed(obj,value)
            if value == uint16(value)
                obj.fixed = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.rssi(obj,value)
            if value == uint8(value)
                obj.rssi = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.remrssi(obj,value)
            if value == uint8(value)
                obj.remrssi = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.txbuf(obj,value)
            if value == uint8(value)
                obj.txbuf = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.noise(obj,value)
            if value == uint8(value)
                obj.noise = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.remnoise(obj,value)
            if value == uint8(value)
                obj.remnoise = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end