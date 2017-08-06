classdef msg_gopro_set_response < MAVLinkMessage
	%MSG_GOPRO_SET_RESPONSE: MAVLink Message ID = 219
    %Description:
    %    Response from a GOPRO_COMMAND set request
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    cmd_id(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,cmd_id,result,varargin)

            if nargin == 2 + 1
                msg = msg_gopro_set_response(cmd_id,result,varargin);
            elseif nargin == 2
                msg = msg_gopro_set_response(cmd_id);
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

        function obj = msg_gopro_set_response(cmd_id,result,varargin)
        %MSG_GOPRO_SET_RESPONSE: Create a new gopro_set_response message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(cmd_id,'MAVLinkPacket')
                    packet = cmd_id;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('cmd_id','MAVLinkPacket');
                end
            elseif nargin >= 2 && isempty(varargin{1})
                obj.cmd_id = cmd_id;
                obj.result = result;
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

                packet = MAVLinkPacket(msg_gopro_set_response.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_gopro_set_response.ID;
                
                packet.payload.putUINT8(obj.cmd_id);
                packet.payload.putUINT8(obj.result);

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
            
            obj.cmd_id = payload.getUINT8();
            obj.result = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

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
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.result(obj,value)
            if value == uint8(value)
                obj.result = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end