classdef msg_named_value_int < mavlink_message
	%MSG_NAMED_VALUE_INT: MAVLINK Message ID = 252
    %Description:
    %    Send a key-value pair as integer. The use of this message is discouraged for normal packets, but a quite efficient way for testing new messages and getting experimental debug output.
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    time_boot_ms(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    time_boot_ms(uint32): Timestamp (milliseconds since system boot)
    %    value(int32): Signed integer value
    %    name(uint8[10]): Name of the debug variable
	
	properties(Constant)
		ID = 252
		LEN = 18
	end
	
	properties
        time_boot_ms	%Timestamp (milliseconds since system boot)	|	(uint32)
        value	%Signed integer value	|	(int32)
        name	%Name of the debug variable	|	(uint8[10])
    end

    methods

        function obj = msg_named_value_int(time_boot_ms,value,name,varargin)
        %Create a new named_value_int message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(time_boot_ms,'mavlink_packet')
                    packet = time_boot_ms;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('time_boot_ms','mavlink_packet');
                end
            
            elseif nargin == 3
                obj.time_boot_ms = time_boot_ms;
                obj.value = value;
                obj.name = name;
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

                packet = mavlink_packet(msg_named_value_int.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_named_value_int.ID;
                
                packet.payload.putUINT32(obj.time_boot_ms);
                packet.payload.putINT32(obj.value);
                for i=1:1:10
                    packet.payload.putUINT8(obj.name(i));
                end

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
            
            obj.time_boot_ms = payload.getUINT32();
            obj.value = payload.getINT32();
            for i=1:1:10
                obj.name(i) = payload.getUINT8();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';
            elseif size(obj.value,2) ~= 1
                result = 'value';
            elseif size(obj.name,2) ~= 10
                result = 'name';

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
        
        function set.value(obj,value)
            if value == int32(value)
                obj.value = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
        
        function set.name(obj,value)
            if value == uint8(value)
                obj.name = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end