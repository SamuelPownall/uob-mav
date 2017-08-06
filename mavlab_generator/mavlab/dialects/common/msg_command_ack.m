classdef msg_command_ack < MAVLinkMessage
	%MSG_COMMAND_ACK: MAVLink Message ID = 77
    %Description:
    %    Report status of a command. Includes feedback wether the command was executed.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    command(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    command(uint16): Command ID, as defined by MAV_CMD enum.
    %    result(uint8): See MAV_RESULT enum
	
	properties(Constant)
		ID = 77
		LEN = 3
	end
	
	properties
        command	%Command ID, as defined by MAV_CMD enum.	|	(uint16)
        result	%See MAV_RESULT enum	|	(uint8)
    end

    methods(Static)

        function send(out,command,result,varargin)

            if nargin == 2 + 1
                msg = msg_command_ack(command,result,varargin);
            elseif nargin == 2
                msg = msg_command_ack(command);
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

        function obj = msg_command_ack(command,result,varargin)
        %MSG_COMMAND_ACK: Create a new command_ack message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(command,'MAVLinkPacket')
                    packet = command;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('command','MAVLinkPacket');
                end
            elseif nargin >= 2 && isempty(varargin{1})
                obj.command = command;
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

                packet = MAVLinkPacket(msg_command_ack.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_command_ack.ID;
                
                packet.payload.putUINT16(obj.command);
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
            
            obj.command = payload.getUINT16();
            obj.result = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.command,2) ~= 1
                result = 'command';
            elseif size(obj.result,2) ~= 1
                result = 'result';

            else
                result = 0;
            end
        end

        function set.command(obj,value)
            if value == uint16(value)
                obj.command = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
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