classdef msg_param_value < mavlink_message
	%MSG_PARAM_VALUE: MAVLINK Message ID = 22
    %Description:
    %    Emit the value of a onboard parameter. The inclusion of param_count and param_index in the message allows the recipient to keep track of received parameters and allows him to re-request missing parameters after a loss or timeout.
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    param_value(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    param_value(single): Onboard parameter value
    %    param_count(uint16): Total number of onboard parameters
    %    param_index(uint16): Index of this onboard parameter
    %    param_id(uint8[16]): Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string
    %    param_type(uint8): Onboard parameter type: see the MAV_PARAM_TYPE enum for supported data types.
	
	properties(Constant)
		ID = 22
		LEN = 25
	end
	
	properties
        param_value	%Onboard parameter value	|	(single)
        param_count	%Total number of onboard parameters	|	(uint16)
        param_index	%Index of this onboard parameter	|	(uint16)
        param_id	%Onboard parameter id, terminated by NULL if the length is less than 16 human-readable chars and WITHOUT null termination (NULL) byte if the length is exactly 16 chars - applications have to provide 16+1 bytes storage if the ID is stored as string	|	(uint8[16])
        param_type	%Onboard parameter type: see the MAV_PARAM_TYPE enum for supported data types.	|	(uint8)
    end

    methods

        function obj = msg_param_value(param_value,param_count,param_index,param_id,param_type,varargin)
        %Create a new param_value message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(param_value,'mavlink_packet')
                    packet = param_value;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('param_value','mavlink_packet');
                end
            
            elseif nargin == 5
                obj.param_value = param_value;
                obj.param_count = param_count;
                obj.param_index = param_index;
                obj.param_id = param_id;
                obj.param_type = param_type;
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

                packet = mavlink_packet(msg_param_value.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_param_value.ID;
                
                packet.payload.putSINGLE(obj.param_value);
                packet.payload.putUINT16(obj.param_count);
                packet.payload.putUINT16(obj.param_index);
                for i=1:1:16
                    packet.payload.putUINT8(obj.param_id(i));
                end
                packet.payload.putUINT8(obj.param_type);

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
            
            obj.param_value = payload.getSINGLE();
            obj.param_count = payload.getUINT16();
            obj.param_index = payload.getUINT16();
            for i=1:1:16
                obj.param_id(i) = payload.getUINT8();
            end
            obj.param_type = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.param_value,2) ~= 1
                result = 'param_value';
            elseif size(obj.param_count,2) ~= 1
                result = 'param_count';
            elseif size(obj.param_index,2) ~= 1
                result = 'param_index';
            elseif size(obj.param_id,2) ~= 16
                result = 'param_id';
            elseif size(obj.param_type,2) ~= 1
                result = 'param_type';

            else
                result = 0;
            end
        end

        function set.param_value(obj,value)
            obj.param_value = single(value);
        end
        
        function set.param_count(obj,value)
            if value == uint16(value)
                obj.param_count = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.param_index(obj,value)
            if value == uint16(value)
                obj.param_index = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.param_id(obj,value)
            if value == uint8(value)
                obj.param_id = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.param_type(obj,value)
            if value == uint8(value)
                obj.param_type = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end