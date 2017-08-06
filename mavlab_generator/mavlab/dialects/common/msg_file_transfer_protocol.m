classdef msg_file_transfer_protocol < MAVLinkMessage
	%MSG_FILE_TRANSFER_PROTOCOL: MAVLink Message ID = 110
    %Description:
    %    File transfer message
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    target_network(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    target_network(uint8): Network ID (0 for broadcast)
    %    target_system(uint8): System ID (0 for broadcast)
    %    target_component(uint8): Component ID (0 for broadcast)
    %    payload(uint8[127]): Variable length payload. The length is defined by the remaining message length when subtracting the header and other fields.  The entire content of this block is opaque unless you understand any the encoding message_type.  The particular encoding used can be extension specific and might not always be documented as part of the mavlink specification.
	
	properties(Constant)
		ID = 110
		LEN = 127
	end
	
	properties
        target_network	%Network ID (0 for broadcast)	|	(uint8)
        target_system	%System ID (0 for broadcast)	|	(uint8)
        target_component	%Component ID (0 for broadcast)	|	(uint8)
        payload	%Variable length payload. The length is defined by the remaining message length when subtracting the header and other fields.  The entire content of this block is opaque unless you understand any the encoding message_type.  The particular encoding used can be extension specific and might not always be documented as part of the mavlink specification.	|	(uint8[127])
    end

    methods(Static)

        function send(out,target_network,target_system,target_component,payload,varargin)

            if nargin == 4 + 1
                msg = msg_file_transfer_protocol(target_network,target_system,target_component,payload,varargin);
            elseif nargin == 2
                msg = msg_file_transfer_protocol(target_network);
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

        function obj = msg_file_transfer_protocol(target_network,target_system,target_component,payload,varargin)
        %MSG_FILE_TRANSFER_PROTOCOL: Create a new file_transfer_protocol message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(target_network,'MAVLinkPacket')
                    packet = target_network;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('target_network','MAVLinkPacket');
                end
            elseif nargin >= 4 && isempty(varargin{1})
                obj.target_network = target_network;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.payload = payload;
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

                packet = MAVLinkPacket(msg_file_transfer_protocol.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_file_transfer_protocol.ID;
                
                packet.payload.putUINT8(obj.target_network);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                for i=1:1:127
                    packet.payload.putUINT8(obj.payload(i));
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

        function set.target_network(obj,value)
            if value == uint8(value)
                obj.target_network = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
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
        
        function set.payload(obj,value)
            if value == uint8(value)
                obj.payload = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end