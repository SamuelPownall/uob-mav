classdef msg_request_data_stream < MAVLinkMessage
	%MSG_REQUEST_DATA_STREAM: MAVLink Message ID = 66
    %Description:
    %    THIS INTERFACE IS DEPRECATED. USE SET_MESSAGE_INTERVAL INSTEAD.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    req_message_rate(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,req_message_rate,target_system,target_component,req_stream_id,start_stop,varargin)

            if nargin == 5 + 1
                msg = msg_request_data_stream(req_message_rate,target_system,target_component,req_stream_id,start_stop,varargin);
            elseif nargin == 2
                msg = msg_request_data_stream(req_message_rate);
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

        function obj = msg_request_data_stream(req_message_rate,target_system,target_component,req_stream_id,start_stop,varargin)
        %MSG_REQUEST_DATA_STREAM: Create a new request_data_stream message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(req_message_rate,'MAVLinkPacket')
                    packet = req_message_rate;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('req_message_rate','MAVLinkPacket');
                end
            elseif nargin >= 5 && isempty(varargin{1})
                obj.req_message_rate = req_message_rate;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.req_stream_id = req_stream_id;
                obj.start_stop = start_stop;
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

                packet = MAVLinkPacket(msg_request_data_stream.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_request_data_stream.ID;
                
                packet.payload.putUINT16(obj.req_message_rate);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                packet.payload.putUINT8(obj.req_stream_id);
                packet.payload.putUINT8(obj.start_stop);

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
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.req_stream_id(obj,value)
            if value == uint8(value)
                obj.req_stream_id = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.start_stop(obj,value)
            if value == uint8(value)
                obj.start_stop = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end