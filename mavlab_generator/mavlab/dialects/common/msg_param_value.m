classdef msg_param_value < MAVLinkMessage
	%MSG_PARAM_VALUE: MAVLink Message ID = 22
    %Description:
    %    Emit the value of a onboard parameter. The inclusion of param_count and param_index in the message allows the recipient to keep track of received parameters and allows him to re-request missing parameters after a loss or timeout.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    param_value(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,param_value,param_count,param_index,param_id,param_type,varargin)

            if nargin == 5 + 1
                msg = msg_param_value(param_value,param_count,param_index,param_id,param_type,varargin);
            elseif nargin == 2
                msg = msg_param_value(param_value);
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

        function obj = msg_param_value(param_value,param_count,param_index,param_id,param_type,varargin)
        %MSG_PARAM_VALUE: Create a new param_value message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(param_value,'MAVLinkPacket')
                    packet = param_value;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('param_value','MAVLinkPacket');
                end
            elseif nargin >= 5 && isempty(varargin{1})
                obj.param_value = param_value;
                obj.param_count = param_count;
                obj.param_index = param_index;
                obj.param_id = param_id;
                obj.param_type = param_type;
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

                packet = MAVLinkPacket(msg_param_value.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
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
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.param_index(obj,value)
            if value == uint16(value)
                obj.param_index = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.param_id(obj,value)
            if value == uint8(value)
                obj.param_id = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.param_type(obj,value)
            if value == uint8(value)
                obj.param_type = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end