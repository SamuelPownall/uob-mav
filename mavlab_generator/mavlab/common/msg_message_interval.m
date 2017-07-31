classdef msg_message_interval < mavlink_message
	%MSG_MESSAGE_INTERVAL: MAVLINK Message ID = 244
    %Description:
    %    This interface replaces DATA_STREAM
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    interval_us(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    interval_us(int32): The interval between two messages, in microseconds. A value of -1 indicates this stream is disabled, 0 indicates it is not available, > 0 indicates the interval at which it is sent.
    %    message_id(uint16): The ID of the requested MAVLink message. v1.0 is limited to 254 messages.
	
	properties(Constant)
		ID = 244
		LEN = 6
	end
	
	properties
        interval_us	%The interval between two messages, in microseconds. A value of -1 indicates this stream is disabled, 0 indicates it is not available, > 0 indicates the interval at which it is sent.	|	(int32)
        message_id	%The ID of the requested MAVLink message. v1.0 is limited to 254 messages.	|	(uint16)
    end

    methods

        function obj = msg_message_interval(interval_us,message_id,varargin)
        %MSG_MESSAGE_INTERVAL: Create a new message_interval message object
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1 
                if isa(interval_us,'mavlink_packet')
                    packet = interval_us;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('interval_us','mavlink_packet');
                end
            elseif nargin == 2
                obj.interval_us = interval_us;
                obj.message_id = message_id;
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

                packet = mavlink_packet(msg_message_interval.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_message_interval.ID;
                
                packet.payload.putINT32(obj.interval_us);
                packet.payload.putUINT16(obj.message_id);

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
            
            obj.interval_us = payload.getINT32();
            obj.message_id = payload.getUINT16();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.interval_us,2) ~= 1
                result = 'interval_us';
            elseif size(obj.message_id,2) ~= 1
                result = 'message_id';

            else
                result = 0;
            end
        end

        function set.interval_us(obj,value)
            if value == int32(value)
                obj.interval_us = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
        
        function set.message_id(obj,value)
            if value == uint16(value)
                obj.message_id = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
    end

end