classdef msg_v2_extension < mavlink_message
	%MSG_V2_EXTENSION: MAVLINK Message ID = 248
    %Description:
    %    Message implementing parts of the V2 payload specs in V1 frames for transitional support.
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    message_type(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    message_type(uint16): A code that identifies the software component that understands this message (analogous to usb device classes or mime type strings).  If this code is less than 32768, it is considered a 'registered' protocol extension and the corresponding entry should be added to https://github.com/mavlink/mavlink/extension-message-ids.xml.  Software creators can register blocks of message IDs as needed (useful for GCS specific metadata, etc...). Message_types greater than 32767 are considered local experiments and should not be checked in to any widely distributed codebase.
    %    target_network(uint8): Network ID (0 for broadcast)
    %    target_system(uint8): System ID (0 for broadcast)
    %    target_component(uint8): Component ID (0 for broadcast)
    %    payload(uint8[127]): Variable length payload. The length is defined by the remaining message length when subtracting the header and other fields.  The entire content of this block is opaque unless you understand any the encoding message_type.  The particular encoding used can be extension specific and might not always be documented as part of the mavlink specification.
	
	properties(Constant)
		ID = 248
		LEN = 127
	end
	
	properties
        message_type	%A code that identifies the software component that understands this message (analogous to usb device classes or mime type strings).  If this code is less than 32768, it is considered a 'registered' protocol extension and the corresponding entry should be added to https://github.com/mavlink/mavlink/extension-message-ids.xml.  Software creators can register blocks of message IDs as needed (useful for GCS specific metadata, etc...). Message_types greater than 32767 are considered local experiments and should not be checked in to any widely distributed codebase.	|	(uint16)
        target_network	%Network ID (0 for broadcast)	|	(uint8)
        target_system	%System ID (0 for broadcast)	|	(uint8)
        target_component	%Component ID (0 for broadcast)	|	(uint8)
        payload	%Variable length payload. The length is defined by the remaining message length when subtracting the header and other fields.  The entire content of this block is opaque unless you understand any the encoding message_type.  The particular encoding used can be extension specific and might not always be documented as part of the mavlink specification.	|	(uint8[127])
    end

    methods

        function obj = msg_v2_extension(message_type,target_network,target_system,target_component,payload,varargin)
        %Create a new v2_extension message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(message_type,'mavlink_packet')
                    packet = message_type;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('message_type','mavlink_packet');
                end
            
            elseif nargin == 5
                obj.message_type = message_type;
                obj.target_network = target_network;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.payload = payload;
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

                packet = mavlink_packet(msg_v2_extension.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_v2_extension.ID;
                
                packet.payload.putUINT16(obj.message_type);
                packet.payload.putUINT8(obj.target_network);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                for i=1:1:127
                    packet.payload.putUINT8(obj.payload(i));
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
            
            obj.message_type = payload.getUINT16();
            obj.target_network = payload.getUINT8();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            for i=1:1:127
                obj.payload(i) = payload.getUINT8();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.message_type,2) ~= 1
                result = 'message_type';
            elseif size(obj.target_network,2) ~= 1
                result = 'target_network';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';
            elseif size(obj.payload,2) ~= 127
                result = 'payload';

            else
                result = 0;
            end
        end

        function set.message_type(obj,value)
            if value == uint16(value)
                obj.message_type = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.target_network(obj,value)
            if value == uint8(value)
                obj.target_network = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
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
        
        function set.payload(obj,value)
            if value == uint8(value)
                obj.payload = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end