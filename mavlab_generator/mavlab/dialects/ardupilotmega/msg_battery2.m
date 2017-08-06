classdef msg_battery2 < MAVLinkMessage
	%MSG_BATTERY2: MAVLink Message ID = 181
    %Description:
    %    2nd Battery status
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    voltage(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    voltage(uint16): voltage in millivolts
    %    current_battery(int16): Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current
	
	properties(Constant)
		ID = 181
		LEN = 4
	end
	
	properties
        voltage	%voltage in millivolts	|	(uint16)
        current_battery	%Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current	|	(int16)
    end

    methods(Static)

        function send(out,voltage,current_battery,varargin)

            if nargin == 2 + 1
                msg = msg_battery2(voltage,current_battery,varargin);
            elseif nargin == 2
                msg = msg_battery2(voltage);
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

        function obj = msg_battery2(voltage,current_battery,varargin)
        %MSG_BATTERY2: Create a new battery2 message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(voltage,'MAVLinkPacket')
                    packet = voltage;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('voltage','MAVLinkPacket');
                end
            elseif nargin >= 2 && isempty(varargin{1})
                obj.voltage = voltage;
                obj.current_battery = current_battery;
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

                packet = MAVLinkPacket(msg_battery2.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_battery2.ID;
                
                packet.payload.putUINT16(obj.voltage);
                packet.payload.putINT16(obj.current_battery);

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
            
            obj.voltage = payload.getUINT16();
            obj.current_battery = payload.getINT16();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.voltage,2) ~= 1
                result = 'voltage';
            elseif size(obj.current_battery,2) ~= 1
                result = 'current_battery';

            else
                result = 0;
            end
        end

        function set.voltage(obj,value)
            if value == uint16(value)
                obj.voltage = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.current_battery(obj,value)
            if value == int16(value)
                obj.current_battery = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
    end

end