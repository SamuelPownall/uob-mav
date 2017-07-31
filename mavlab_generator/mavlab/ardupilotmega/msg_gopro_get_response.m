classdef msg_gopro_get_response < mavlink_message
	%MSG_GOPRO_GET_RESPONSE: MAVLINK Message ID = 217
    %Description:
    %    Response from a GOPRO_COMMAND get request
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    cmd_id(mavlink_packet): Alternative way to construct a message using a mavlink_packet
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

        function obj = msg_gopro_get_response(cmd_id,value,varargin)
        %MSG_GOPRO_GET_RESPONSE: Create a new gopro_get_response message object
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1 
                if isa(cmd_id,'mavlink_packet')
                    packet = cmd_id;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('cmd_id','mavlink_packet');
                end
            elseif nargin == 2
                obj.cmd_id = cmd_id;
                obj.value = value;
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

        function unpack(obj, payload)
        %UNPACK: Unpacks a mavlink_payload into this MAVLINK message
        %Description:
        %    Extracts the data from a mavlink_payload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(mavlink_payload): The payload to be unpacked into this MAVLINK message

            payload.resetIndex();
            
            obj.cmd_id = payload.getUINT8();
            obj.value = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

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