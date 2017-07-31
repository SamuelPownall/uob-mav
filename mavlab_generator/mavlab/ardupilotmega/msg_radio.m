classdef msg_radio < mavlink_message
	%MSG_RADIO: MAVLINK Message ID = 166
    %Description:
    %    Status generated by radio
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    rxerrors(mavlink_packet): Alternative way to construct a message using a mavlink_packet
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

        function obj = msg_radio(rxerrors,fixed,rssi,remrssi,txbuf,noise,remnoise,varargin)
        %Create a new radio message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(rxerrors,'mavlink_packet')
                    packet = rxerrors;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('rxerrors','mavlink_packet');
                end
            
            elseif nargin == 7
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

        function packet = pack(obj)
        %PACK: Packs this MAVLINK message into a mavlink_packet
        %Description:
        %    Packs the fields of a message into a mavlink_packet which can be encoded
        %    for transmission.

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

        function unpack(obj, payload)
        %UNPACK: Unpacks a mavlink_payload into this MAVLINK message
        %Description:
        %    Extracts the data from a mavlink_payload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(mavlink_payload): The payload to be unpacked into this MAVLINK message

            payload.resetIndex();
            
            obj.rxerrors = payload.getUINT16();
            obj.fixed = payload.getUINT16();
            obj.rssi = payload.getUINT8();
            obj.remrssi = payload.getUINT8();
            obj.txbuf = payload.getUINT8();
            obj.noise = payload.getUINT8();
            obj.remnoise = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

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