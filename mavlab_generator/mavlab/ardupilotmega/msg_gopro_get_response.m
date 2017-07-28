classdef msg_gopro_get_response < mavlink_message
	%MSG_GOPRO_GET_RESPONSE(packet,cmd_id,value): MAVLINK Message ID = 217
    %Description:
    %    Response from a GOPRO_COMMAND get request
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    cmd_id(uint8): Command ID
    %    value(uint8): Value
	
	properties(Constant)
		ID = 217
		LEN = 2
	end
	
	properties
        cmd_id	%Command ID	|	(uint8)
        value	%Value	|	(uint8)
    end

    methods

        %Constructor: msg_gopro_get_response
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_gopro_get_response(packet,cmd_id,value)
        
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
            
            elseif nargin-1 == 2
                obj.cmd_id = cmd_id;
                obj.value = value;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_gopro_get_response.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_gopro_get_response.ID;
                
                packet.payload.putUINT8(obj.cmd_id);
                packet.payload.putUINT8(obj.value);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.cmd_id = payload.getUINT8();
            obj.value = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.cmd_id,2) ~= 1
                result = 'cmd_id';
            elseif size(obj.value,2) ~= 1
                result = 'value';

            else
                result = 0;
            end
        end

        function set.cmd_id(obj,value)
            if value == uint8(value)
                obj.cmd_id = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.value(obj,value)
            if value == uint8(value)
                obj.value = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end