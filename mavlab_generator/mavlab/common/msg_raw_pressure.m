classdef msg_raw_pressure < mavlink_message
	%MSG_RAW_PRESSURE: MAVLINK Message ID = 28
    %Description:
    %    The RAW pressure readings for the typical setup of one absolute pressure and one differential pressure sensor. The sensor values should be the raw, UNSCALED ADC values.
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    time_usec(mavlink_packet): Alternative way to construct a message using a mavlink_packet
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

        function obj = msg_raw_pressure(time_usec,press_abs,press_diff1,press_diff2,temperature,varargin)
        %Create a new raw_pressure message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(time_usec,'mavlink_packet')
                    packet = time_usec;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('time_usec','mavlink_packet');
                end
            
            elseif nargin == 5
                obj.time_usec = time_usec;
                obj.press_abs = press_abs;
                obj.press_diff1 = press_diff1;
                obj.press_diff2 = press_diff2;
                obj.temperature = temperature;
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

        function unpack(obj, payload)
        %UNPACK: Unpacks a mavlink_payload into this MAVLINK message
        %Description:
        %    Extracts the data from a mavlink_payload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(mavlink_payload): The payload to be unpacked into this MAVLINK message

            payload.resetIndex();
            
            obj.time_usec = payload.getUINT64();
            obj.press_abs = payload.getINT16();
            obj.press_diff1 = payload.getINT16();
            obj.press_diff2 = payload.getINT16();
            obj.temperature = payload.getINT16();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

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