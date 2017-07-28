classdef msg_request_data_stream < mavlink_message
	%MSG_REQUEST_DATA_STREAM(packet,req_message_rate,target_system,target_component,req_stream_id,start_stop): MAVLINK Message ID = 66
    %Description:
    %    THIS INTERFACE IS DEPRECATED. USE SET_MESSAGE_INTERVAL INSTEAD.
    %    If constructing from fields, packet argument should be set to []
	%Fields:
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

        %Constructor: msg_request_data_stream
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_request_data_stream(packet,req_message_rate,target_system,target_component,req_stream_id,start_stop)
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(packet,'mavlink_packet')
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('packet','mavlink_packet');
                end
            
            elseif nargin-1 == 5
                obj.req_message_rate = req_message_rate;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.req_stream_id = req_stream_id;
                obj.start_stop = start_stop;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

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

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.req_message_rate = payload.getUINT16();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            obj.req_stream_id = payload.getUINT8();
            obj.start_stop = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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