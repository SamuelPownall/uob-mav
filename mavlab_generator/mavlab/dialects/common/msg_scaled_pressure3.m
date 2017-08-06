classdef msg_scaled_pressure3 < MAVLinkMessage
	%MSG_SCALED_PRESSURE3: MAVLink Message ID = 143
    %Description:
    %    Barometer readings for 3rd barometer
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_boot_ms(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    time_boot_ms(uint32): Timestamp (milliseconds since system boot)
    %    press_abs(single): Absolute pressure (hectopascal)
    %    press_diff(single): Differential pressure 1 (hectopascal)
    %    temperature(int16): Temperature measurement (0.01 degrees celsius)
	
	properties(Constant)
		ID = 143
		LEN = 14
	end
	
	properties
        time_boot_ms	%Timestamp (milliseconds since system boot)	|	(uint32)
        press_abs	%Absolute pressure (hectopascal)	|	(single)
        press_diff	%Differential pressure 1 (hectopascal)	|	(single)
        temperature	%Temperature measurement (0.01 degrees celsius)	|	(int16)
    end

    methods(Static)

        function send(out,time_boot_ms,press_abs,press_diff,temperature,varargin)

            if nargin == 4 + 1
                msg = msg_scaled_pressure3(time_boot_ms,press_abs,press_diff,temperature,varargin);
            elseif nargin == 2
                msg = msg_scaled_pressure3(time_boot_ms);
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

        function obj = msg_scaled_pressure3(time_boot_ms,press_abs,press_diff,temperature,varargin)
        %MSG_SCALED_PRESSURE3: Create a new scaled_pressure3 message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(time_boot_ms,'MAVLinkPacket')
                    packet = time_boot_ms;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('time_boot_ms','MAVLinkPacket');
                end
            elseif nargin >= 4 && isempty(varargin{1})
                obj.time_boot_ms = time_boot_ms;
                obj.press_abs = press_abs;
                obj.press_diff = press_diff;
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

                packet = MAVLinkPacket(msg_scaled_pressure3.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_scaled_pressure3.ID;
                
                packet.payload.putUINT32(obj.time_boot_ms);
                packet.payload.putSINGLE(obj.press_abs);
                packet.payload.putSINGLE(obj.press_diff);
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
            
            obj.time_boot_ms = payload.getUINT32();
            obj.press_abs = payload.getSINGLE();
            obj.press_diff = payload.getSINGLE();
            obj.temperature = payload.getINT16();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

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
                MAVLink.throwTypeError('value','uint32');
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
                MAVLink.throwTypeError('value','int16');
            end
        end
        
    end

end