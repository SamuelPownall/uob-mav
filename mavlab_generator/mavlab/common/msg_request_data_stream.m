classdef msg_request_data_stream < mavlink_message
	%MSG_REQUEST_DATA_STREAM: MAVLINK Message ID = 66
    %Description:
    %    THIS INTERFACE IS DEPRECATED. USE SET_MESSAGE_INTERVAL INSTEAD.
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    req_message_rate(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    req_message_rate(uint16): The requested message rate
    %    target_system(uint8): The target requested to send the message stream.
    %    target_component(uint8): The target requested to send the message stream.
    %    req_stream_id(uint8): The ID of the requested data stream
    %    start_stop(uint8): 1 to start sending, 0 to stop sending.
	
	properties(Constant)
		ID = 66
		LEN = 6
	end
	
	properties
        req_message_rate	%The requested message rate	|	(uint16)
        target_system	%The target requested to send the message stream.	|	(uint8)
        target_component	%The target requested to send the message stream.	|	(uint8)
        req_stream_id	%The ID of the requested data stream	|	(uint8)
        start_stop	%1 to start sending, 0 to stop sending.	|	(uint8)
    end

    methods

        function obj = msg_request_data_stream(req_message_rate,target_system,target_component,req_stream_id,start_stop,varargin)
        %MSG_REQUEST_DATA_STREAM: Create a new request_data_stream message object
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1 
                if isa(req_message_rate,'mavlink_packet')
                    packet = req_message_rate;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('req_message_rate','mavlink_packet');
                end
            elseif nargin == 5
                obj.req_message_rate = req_message_rate;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.req_stream_id = req_stream_id;
                obj.start_stop = start_stop;
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

                packet = mavlink_packet(msg_request_data_stream.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_request_data_stream.ID;
                
                packet.payload.putUINT16(obj.req_message_rate);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                packet.payload.putUINT8(obj.req_stream_id);
                packet.payload.putUINT8(obj.start_stop);

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
            
            obj.req_message_rate = payload.getUINT16();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            obj.req_stream_id = payload.getUINT8();
            obj.start_stop = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.req_message_rate,2) ~= 1
                result = 'req_message_rate';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';
            elseif size(obj.req_stream_id,2) ~= 1
                result = 'req_stream_id';
            elseif size(obj.start_stop,2) ~= 1
                result = 'start_stop';

            else
                result = 0;
            end
        end

        function set.req_message_rate(obj,value)
            if value == uint16(value)
                obj.req_message_rate = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.req_stream_id(obj,value)
            if value == uint8(value)
                obj.req_stream_id = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.start_stop(obj,value)
            if value == uint8(value)
                obj.start_stop = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end