classdef msg_ap_adc < MAVLinkMessage
	%MSG_AP_ADC: MAVLink Message ID = 153
    %Description:
    %    raw ADC output
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    adc1(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    adc1(uint16): ADC output 1
    %    adc2(uint16): ADC output 2
    %    adc3(uint16): ADC output 3
    %    adc4(uint16): ADC output 4
    %    adc5(uint16): ADC output 5
    %    adc6(uint16): ADC output 6
	
	properties(Constant)
		ID = 153
		LEN = 12
	end
	
	properties
        adc1	%ADC output 1	|	(uint16)
        adc2	%ADC output 2	|	(uint16)
        adc3	%ADC output 3	|	(uint16)
        adc4	%ADC output 4	|	(uint16)
        adc5	%ADC output 5	|	(uint16)
        adc6	%ADC output 6	|	(uint16)
    end

    methods(Static)

        function send(out,adc1,adc2,adc3,adc4,adc5,adc6,varargin)

            if nargin == 6 + 1
                msg = msg_ap_adc(adc1,adc2,adc3,adc4,adc5,adc6,varargin);
            elseif nargin == 2
                msg = msg_ap_adc(adc1);
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

        function obj = msg_ap_adc(adc1,adc2,adc3,adc4,adc5,adc6,varargin)
        %MSG_AP_ADC: Create a new ap_adc message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(adc1,'MAVLinkPacket')
                    packet = adc1;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('adc1','MAVLinkPacket');
                end
            elseif nargin >= 6 && isempty(varargin{1})
                obj.adc1 = adc1;
                obj.adc2 = adc2;
                obj.adc3 = adc3;
                obj.adc4 = adc4;
                obj.adc5 = adc5;
                obj.adc6 = adc6;
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

                packet = MAVLinkPacket(msg_ap_adc.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_ap_adc.ID;
                
                packet.payload.putUINT16(obj.adc1);
                packet.payload.putUINT16(obj.adc2);
                packet.payload.putUINT16(obj.adc3);
                packet.payload.putUINT16(obj.adc4);
                packet.payload.putUINT16(obj.adc5);
                packet.payload.putUINT16(obj.adc6);

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
            
            obj.adc1 = payload.getUINT16();
            obj.adc2 = payload.getUINT16();
            obj.adc3 = payload.getUINT16();
            obj.adc4 = payload.getUINT16();
            obj.adc5 = payload.getUINT16();
            obj.adc6 = payload.getUINT16();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.adc1,2) ~= 1
                result = 'adc1';
            elseif size(obj.adc2,2) ~= 1
                result = 'adc2';
            elseif size(obj.adc3,2) ~= 1
                result = 'adc3';
            elseif size(obj.adc4,2) ~= 1
                result = 'adc4';
            elseif size(obj.adc5,2) ~= 1
                result = 'adc5';
            elseif size(obj.adc6,2) ~= 1
                result = 'adc6';

            else
                result = 0;
            end
        end

        function set.adc1(obj,value)
            if value == uint16(value)
                obj.adc1 = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.adc2(obj,value)
            if value == uint16(value)
                obj.adc2 = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.adc3(obj,value)
            if value == uint16(value)
                obj.adc3 = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.adc4(obj,value)
            if value == uint16(value)
                obj.adc4 = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.adc5(obj,value)
            if value == uint16(value)
                obj.adc5 = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.adc6(obj,value)
            if value == uint16(value)
                obj.adc6 = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
    end

end