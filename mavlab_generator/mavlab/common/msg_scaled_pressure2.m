classdef msg_scaled_pressure2 < mavlink_message
	%MSG_SCALED_PRESSURE2(packet,time_boot_ms,press_abs,press_diff,temperature): MAVLINK Message ID = 137
    %Description:
    %    Barometer readings for 2nd barometer
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    time_boot_ms(uint32): Timestamp (milliseconds since system boot)
    %    press_abs(single): Absolute pressure (hectopascal)
    %    press_diff(single): Differential pressure 1 (hectopascal)
    %    temperature(int16): Temperature measurement (0.01 degrees celsius)
	
	properties(Constant)
		ID = 137
		LEN = 14
	end
	
	properties
        time_boot_ms	%Timestamp (milliseconds since system boot)	|	(uint32)
        press_abs	%Absolute pressure (hectopascal)	|	(single)
        press_diff	%Differential pressure 1 (hectopascal)	|	(single)
        temperature	%Temperature measurement (0.01 degrees celsius)	|	(int16)
    end

    methods

        %Constructor: msg_scaled_pressure2
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_scaled_pressure2(packet,time_boot_ms,press_abs,press_diff,temperature)
        
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
            
            elseif nargin-1 == 4
                obj.time_boot_ms = time_boot_ms;
                obj.press_abs = press_abs;
                obj.press_diff = press_diff;
                obj.temperature = temperature;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_scaled_pressure2.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_scaled_pressure2.ID;
                
                packet.payload.putUINT32(obj.time_boot_ms);
                packet.payload.putSINGLE(obj.press_abs);
                packet.payload.putSINGLE(obj.press_diff);
                packet.payload.putINT16(obj.temperature);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.time_boot_ms = payload.getUINT32();
            obj.press_abs = payload.getSINGLE();
            obj.press_diff = payload.getSINGLE();
            obj.temperature = payload.getINT16();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';
            elseif size(obj.press_abs,2) ~= 1
                result = 'press_abs';
            elseif size(obj.press_diff,2) ~= 1
                result = 'press_diff';
            elseif size(obj.temperature,2) ~= 1
                result = 'temperature';

            else
                result = 0;
            end
        end

        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.press_abs(obj,value)
            obj.press_abs = single(value);
        end
        
        function set.press_diff(obj,value)
            obj.press_diff = single(value);
        end
        
        function set.temperature(obj,value)
            if value == int16(value)
                obj.temperature = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
    end

end