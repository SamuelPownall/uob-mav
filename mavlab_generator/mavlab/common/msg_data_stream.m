classdef msg_data_stream < mavlink_message
	%MSG_DATA_STREAM: MAVLINK Message ID = 67
    %Description:
    %    THIS INTERFACE IS DEPRECATED. USE MESSAGE_INTERVAL INSTEAD.
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    message_rate(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    message_rate(uint16): The message rate
    %    stream_id(uint8): The ID of the requested data stream
    %    on_off(uint8): 1 stream is enabled, 0 stream is stopped.
	
	properties(Constant)
		ID = 67
		LEN = 4
	end
	
	properties
        message_rate	%The message rate	|	(uint16)
        stream_id	%The ID of the requested data stream	|	(uint8)
        on_off	%1 stream is enabled, 0 stream is stopped.	|	(uint8)
    end

    methods

        function obj = msg_data_stream(message_rate,stream_id,on_off,varargin)
        %MSG_DATA_STREAM: Create a new data_stream message object
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1 
                if isa(message_rate,'mavlink_packet')
                    packet = message_rate;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('message_rate','mavlink_packet');
                end
            elseif nargin == 3
                obj.message_rate = message_rate;
                obj.stream_id = stream_id;
                obj.on_off = on_off;
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

                packet = mavlink_packet(msg_data_stream.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_data_stream.ID;
                
                packet.payload.putUINT16(obj.message_rate);
                packet.payload.putUINT8(obj.stream_id);
                packet.payload.putUINT8(obj.on_off);

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
            
            obj.message_rate = payload.getUINT16();
            obj.stream_id = payload.getUINT8();
            obj.on_off = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.message_rate,2) ~= 1
                result = 'message_rate';
            elseif size(obj.stream_id,2) ~= 1
                result = 'stream_id';
            elseif size(obj.on_off,2) ~= 1
                result = 'on_off';

            else
                result = 0;
            end
        end

        function set.message_rate(obj,value)
            if value == uint16(value)
                obj.message_rate = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.stream_id(obj,value)
            if value == uint8(value)
                obj.stream_id = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.on_off(obj,value)
            if value == uint8(value)
                obj.on_off = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end