classdef msg_gopro_set_response < mavlink_handle
	%MSG_GOPRO_SET_RESPONSE(packet,cmd_id,result): MAVLINK Message ID = 219
    %Description:
    %    Response from a GOPRO_COMMAND set request
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    cmd_id(uint8): Command ID
    %    result(uint8): Result
	
	properties(Constant)
		ID = 219
		LEN = 2
	end
	
	properties
        cmd_id	%Command ID	|	(uint8)
        result	%Result	|	(uint8)
    end

    methods

        %Constructor: msg_gopro_set_response
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_gopro_set_response(packet,cmd_id,result)
        
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
                obj.result = result;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_gopro_set_response.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_gopro_set_response.ID;
                
                packet.payload.putUINT8(obj.cmd_id);
                packet.payload.putUINT8(obj.result);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.cmd_id = payload.getUINT8();
            obj.result = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.cmd_id,2) ~= 1
                result = 'cmd_id';
            elseif size(obj.result,2) ~= 1
                result = 'result';

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
        
        function set.result(obj,value)
            if value == uint8(value)
                obj.result = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end