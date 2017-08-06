classdef msg_logging_ack < MAVLinkMessage
	%MSG_LOGGING_ACK: MAVLink Message ID = 268
    %Description:
    %    An ack for a LOGGING_DATA_ACKED message
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    sequence(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    sequence(uint16): sequence number (must match the one in LOGGING_DATA_ACKED)
    %    target_system(uint8): system ID of the target
    %    target_component(uint8): component ID of the target
	
	properties(Constant)
		ID = 268
		LEN = 4
	end
	
	properties
        sequence	%sequence number (must match the one in LOGGING_DATA_ACKED)	|	(uint16)
        target_system	%system ID of the target	|	(uint8)
        target_component	%component ID of the target	|	(uint8)
    end

    methods(Static)

        function send(out,sequence,target_system,target_component,varargin)

            if nargin == 3 + 1
                msg = msg_logging_ack(sequence,target_system,target_component,varargin);
            elseif nargin == 2
                msg = msg_logging_ack(sequence);
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

        function obj = msg_logging_ack(sequence,target_system,target_component,varargin)
        %MSG_LOGGING_ACK: Create a new logging_ack message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(sequence,'MAVLinkPacket')
                    packet = sequence;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('sequence','MAVLinkPacket');
                end
            elseif nargin >= 3 && isempty(varargin{1})
                obj.sequence = sequence;
                obj.target_system = target_system;
                obj.target_component = target_component;
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

                packet = MAVLinkPacket(msg_logging_ack.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_logging_ack.ID;
                
                packet.payload.putUINT16(obj.sequence);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);

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
            
            obj.sequence = payload.getUINT16();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.sequence,2) ~= 1
                result = 'sequence';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';

            else
                result = 0;
            end
        end

        function set.sequence(obj,value)
            if value == uint16(value)
                obj.sequence = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end