classdef msg_raw_pressure < mavlink_message
	%MSG_RAW_PRESSURE(packet,time_usec,press_abs,press_diff1,press_diff2,temperature): MAVLINK Message ID = 28
    %Description:
    %    The RAW pressure readings for the typical setup of one absolute pressure and one differential pressure sensor. The sensor values should be the raw, UNSCALED ADC values.
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    time_usec(uint64): Timestamp (microseconds since UNIX epoch or microseconds since system boot)
    %    press_abs(int16): Absolute pressure (raw)
    %    press_diff1(int16): Differential pressure 1 (raw, 0 if nonexistant)
    %    press_diff2(int16): Differential pressure 2 (raw, 0 if nonexistant)
    %    temperature(int16): Raw Temperature measurement (raw)
	
	properties(Constant)
		ID = 28
		LEN = 16
	end
	
	properties
        time_usec	%Timestamp (microseconds since UNIX epoch or microseconds since system boot)	|	(uint64)
        press_abs	%Absolute pressure (raw)	|	(int16)
        press_diff1	%Differential pressure 1 (raw, 0 if nonexistant)	|	(int16)
        press_diff2	%Differential pressure 2 (raw, 0 if nonexistant)	|	(int16)
        temperature	%Raw Temperature measurement (raw)	|	(int16)
    end

    methods

        %Constructor: msg_raw_pressure
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_raw_pressure(packet,time_usec,press_abs,press_diff1,press_diff2,temperature)
        
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
            
            elseif nargin-1 == 5
                obj.time_usec = time_usec;
                obj.press_abs = press_abs;
                obj.press_diff1 = press_diff1;
                obj.press_diff2 = press_diff2;
                obj.temperature = temperature;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_raw_pressure.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_raw_pressure.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                packet.payload.putINT16(obj.press_abs);
                packet.payload.putINT16(obj.press_diff1);
                packet.payload.putINT16(obj.press_diff2);
                packet.payload.putINT16(obj.temperature);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.time_usec = payload.getUINT64();
            obj.press_abs = payload.getINT16();
            obj.press_diff1 = payload.getINT16();
            obj.press_diff2 = payload.getINT16();
            obj.temperature = payload.getINT16();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.press_abs,2) ~= 1
                result = 'press_abs';
            elseif size(obj.press_diff1,2) ~= 1
                result = 'press_diff1';
            elseif size(obj.press_diff2,2) ~= 1
                result = 'press_diff2';
            elseif size(obj.temperature,2) ~= 1
                result = 'temperature';

            else
                result = 0;
            end
        end

        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                mavlink.throwTypeError('value','uint64');
            end
        end
        
        function set.press_abs(obj,value)
            if value == int16(value)
                obj.press_abs = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.press_diff1(obj,value)
            if value == int16(value)
                obj.press_diff1 = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.press_diff2(obj,value)
            if value == int16(value)
                obj.press_diff2 = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
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