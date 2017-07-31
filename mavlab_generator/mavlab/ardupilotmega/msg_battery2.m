classdef msg_battery2 < mavlink_message
	%MSG_BATTERY2: MAVLINK Message ID = 181
    %Description:
    %    2nd Battery status
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    voltage(mavlink_packet): Alternative way to construct a message using a mavlink_packet
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

    methods

        function obj = msg_battery2(voltage,current_battery,varargin)
        %MSG_BATTERY2: Create a new battery2 message object
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1 
                if isa(voltage,'mavlink_packet')
                    packet = voltage;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('voltage','mavlink_packet');
                end
            elseif nargin == 2
                obj.voltage = voltage;
                obj.current_battery = current_battery;
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

                packet = mavlink_packet(msg_battery2.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_battery2.ID;
                
                packet.payload.putUINT16(obj.voltage);
                packet.payload.putINT16(obj.current_battery);

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
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.current_battery(obj,value)
            if value == int16(value)
                obj.current_battery = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
    end

end