classdef msg_logging_data < mavlink_message
	%MSG_LOGGING_DATA: MAVLINK Message ID = 266
    %Description:
    %    A message containing logged data (see also MAV_CMD_LOGGING_START)
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    sequence(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    sequence(uint16): sequence number (can wrap)
    %    target_system(uint8): system ID of the target
    %    target_component(uint8): component ID of the target
    %    length(uint8): data length
    %    first_message_offset(uint8): offset into data where first message starts. This can be used for recovery, when a previous message got lost (set to 255 if no start exists).
    %    data(uint8[127]): logged data
	
	properties(Constant)
		ID = 266
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

    methods

        function obj = msg_logging_data(sequence,target_system,target_component,length,first_message_offset,data,varargin)
        %MSG_LOGGING_DATA: Create a new logging_data message object
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1 
                if isa(sequence,'mavlink_packet')
                    packet = sequence;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('sequence','mavlink_packet');
                end
            elseif nargin == 6
                obj.sequence = sequence;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.length = length;
                obj.first_message_offset = first_message_offset;
                obj.data = data;
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

                packet = mavlink_packet(msg_logging_data.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_logging_data.ID;
                
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
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.length(obj,value)
            if value == uint8(value)
                obj.length = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.first_message_offset(obj,value)
            if value == uint8(value)
                obj.first_message_offset = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.data(obj,value)
            if value == uint8(value)
                obj.data = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end