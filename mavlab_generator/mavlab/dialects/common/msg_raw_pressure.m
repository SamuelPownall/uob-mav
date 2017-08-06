classdef msg_raw_pressure < MAVLinkMessage
	%MSG_RAW_PRESSURE: MAVLink Message ID = 28
    %Description:
    %    The RAW pressure readings for the typical setup of one absolute pressure and one differential pressure sensor. The sensor values should be the raw, UNSCALED ADC values.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_usec(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,time_usec,press_abs,press_diff1,press_diff2,temperature,varargin)

            if nargin == 5 + 1
                msg = msg_raw_pressure(time_usec,press_abs,press_diff1,press_diff2,temperature,varargin);
            elseif nargin == 2
                msg = msg_raw_pressure(time_usec);
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

        function obj = msg_raw_pressure(time_usec,press_abs,press_diff1,press_diff2,temperature,varargin)
        %MSG_RAW_PRESSURE: Create a new raw_pressure message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(time_usec,'MAVLinkPacket')
                    packet = time_usec;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('time_usec','MAVLinkPacket');
                end
            elseif nargin >= 5 && isempty(varargin{1})
                obj.time_usec = time_usec;
                obj.press_abs = press_abs;
                obj.press_diff1 = press_diff1;
                obj.press_diff2 = press_diff2;
                obj.temperature = temperature;
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

                packet = MAVLinkPacket(msg_raw_pressure.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_raw_pressure.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                packet.payload.putINT16(obj.press_abs);
                packet.payload.putINT16(obj.press_diff1);
                packet.payload.putINT16(obj.press_diff2);
                packet.payload.putINT16(obj.temperature);

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
                MAVLink.throwTypeError('value','uint64');
            end
        end
        
        function set.press_abs(obj,value)
            if value == int16(value)
                obj.press_abs = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.press_diff1(obj,value)
            if value == int16(value)
                obj.press_diff1 = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.press_diff2(obj,value)
            if value == int16(value)
                obj.press_diff2 = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.temperature(obj,value)
            if value == int16(value)
                obj.temperature = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
    end

end