classdef msg_ap_adc < mavlink_handle
	%MSG_AP_ADC(packet,adc1,adc2,adc3,adc4,adc5,adc6): MAVLINK Message ID = 153
    %Description:
    %    raw ADC output
    %    If constructing from fields, packet argument should be set to []
	%Fields:
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

    methods

        %Constructor: msg_ap_adc
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_ap_adc(packet,adc1,adc2,adc3,adc4,adc5,adc6)
        
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
            
            elseif nargin-1 == 6
                obj.adc1 = adc1;
                obj.adc2 = adc2;
                obj.adc3 = adc3;
                obj.adc4 = adc4;
                obj.adc5 = adc5;
                obj.adc6 = adc6;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_ap_adc.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_ap_adc.ID;
                
                packet.payload.putUINT16(obj.adc1);
                packet.payload.putUINT16(obj.adc2);
                packet.payload.putUINT16(obj.adc3);
                packet.payload.putUINT16(obj.adc4);
                packet.payload.putUINT16(obj.adc5);
                packet.payload.putUINT16(obj.adc6);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.adc1 = payload.getUINT16();
            obj.adc2 = payload.getUINT16();
            obj.adc3 = payload.getUINT16();
            obj.adc4 = payload.getUINT16();
            obj.adc5 = payload.getUINT16();
            obj.adc6 = payload.getUINT16();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.adc2(obj,value)
            if value == uint16(value)
                obj.adc2 = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.adc3(obj,value)
            if value == uint16(value)
                obj.adc3 = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.adc4(obj,value)
            if value == uint16(value)
                obj.adc4 = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.adc5(obj,value)
            if value == uint16(value)
                obj.adc5 = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.adc6(obj,value)
            if value == uint16(value)
                obj.adc6 = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
    end

end