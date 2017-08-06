classdef msg_logging_data_acked < MAVLinkMessage
	%MSG_LOGGING_DATA_ACKED: MAVLink Message ID = 267
    %Description:
    %    A message containing logged data which requires a LOGGING_ACK to be sent back
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    sequence(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    sequence(uint16): sequence number (can wrap)
    %    target_system(uint8): system ID of the target
    %    target_component(uint8): component ID of the target
    %    length(uint8): data length
    %    first_message_offset(uint8): offset into data where first message starts. This can be used for recovery, when a previous message got lost (set to 255 if no start exists).
    %    data(uint8[127]): logged data
	
	properties(Constant)
		ID = 267
		LEN = 127
	end
	
	properties
        sequence	%sequence number (can wrap)	|	(uint16)
        target_system	%system ID of the target	|	(uint8)
        target_component	%component ID of the target	|	(uint8)
        length	%data length	|	(uint8)
        first_message_offset	%offset into data where first message starts. This can be used for recovery, when a previous message got lost (set to 255 if no start exists).	|	(uint8)
        data	%logged data	|	(uint8[127])
    end

    methods(Static)

        function send(out,sequence,target_system,target_component,length,first_message_offset,data,varargin)

            if nargin == 6 + 1
                msg = msg_logging_data_acked(sequence,target_system,target_component,length,first_message_offset,data,varargin);
            elseif nargin == 2
                msg = msg_logging_data_acked(sequence);
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

        function obj = msg_logging_data_acked(sequence,target_system,target_component,length,first_message_offset,data,varargin)
        %MSG_LOGGING_DATA_ACKED: Create a new logging_data_acked message object
        
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
            elseif nargin >= 6 && isempty(varargin{1})
                obj.sequence = sequence;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.length = length;
                obj.first_message_offset = first_message_offset;
                obj.data = data;
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

                packet = MAVLinkPacket(msg_logging_data_acked.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_logging_data_acked.ID;
                
                packet.payload.putUINT16(obj.sequence);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                packet.payload.putUINT8(obj.length);
                packet.payload.putUINT8(obj.first_message_offset);
                for i=1:1:127
                    packet.payload.putUINT8(obj.data(i));
                end

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
            obj.length = payload.getUINT8();
            obj.first_message_offset = payload.getUINT8();
            for i=1:1:127
                obj.data(i) = payload.getUINT8();
            end

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
            elseif size(obj.length,2) ~= 1
                result = 'length';
            elseif size(obj.first_message_offset,2) ~= 1
                result = 'first_message_offset';
            elseif size(obj.data,2) ~= 127
                result = 'data';

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
        
        function set.length(obj,value)
            if value == uint8(value)
                obj.length = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.first_message_offset(obj,value)
            if value == uint8(value)
                obj.first_message_offset = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.data(obj,value)
            if value == uint8(value)
                obj.data = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end