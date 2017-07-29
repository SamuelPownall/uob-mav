classdef msg_log_request_list < mavlink_handle
	%MSG_LOG_REQUEST_LIST(packet,start,end,target_system,target_component): MAVLINK Message ID = 117
    %Description:
    %    Request a list of available logs. On some systems calling this may stop on-board logging until LOG_REQUEST_END is called.
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    start(uint16): First log id (0 for first available)
    %    end(uint16): Last log id (0xffff for last available)
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
	
	properties(Constant)
		ID = 117
		LEN = 6
	end
	
	properties
        start	%First log id (0 for first available)	|	(uint16)
        end	%Last log id (0xffff for last available)	|	(uint16)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
    end

    methods

        %Constructor: msg_log_request_list
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_log_request_list(packet,start,end,target_system,target_component)
        
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
            
            elseif nargin-1 == 4
                obj.start = start;
                obj.end = end;
                obj.target_system = target_system;
                obj.target_component = target_component;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_log_request_list.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_log_request_list.ID;
                
                packet.payload.putUINT16(obj.start);
                packet.payload.putUINT16(obj.end);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.start = payload.getUINT16();
            obj.end = payload.getUINT16();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.start,2) ~= 1
                result = 'start';
            elseif size(obj.end,2) ~= 1
                result = 'end';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';

            else
                result = 0;
            end
        end

        function set.start(obj,value)
            if value == uint16(value)
                obj.start = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.end(obj,value)
            if value == uint16(value)
                obj.end = uint16(value);
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
        
    end

end