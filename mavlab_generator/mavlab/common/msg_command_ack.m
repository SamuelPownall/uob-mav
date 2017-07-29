classdef msg_command_ack < mavlink_message
	%MSG_COMMAND_ACK: MAVLINK Message ID = 77
    %Description:
    %    Report status of a command. Includes feedback wether the command was executed.
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
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

    methods

        function obj = msg_command_ack(packet,command,result)
        %Create a new command_ack message
        
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
                obj.command = command;
                obj.result = result;
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

                packet = mavlink_packet(msg_command_ack.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_command_ack.ID;
                
                packet.payload.putUINT16(obj.command);
                packet.payload.putUINT8(obj.result);

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
                mavlink.throwTypeError('value','uint16');
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