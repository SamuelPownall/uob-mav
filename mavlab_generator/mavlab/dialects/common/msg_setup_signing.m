classdef msg_setup_signing < MAVLinkMessage
	%MSG_SETUP_SIGNING: MAVLink Message ID = 256
    %Description:
    %    Setup a MAVLink2 signing key. If called with secret_key of all zero and zero initial_timestamp will disable signing
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    initial_timestamp(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    initial_timestamp(uint64): initial timestamp
    %    target_system(uint8): system id of the target
    %    target_component(uint8): component ID of the target
    %    secret_key(uint8[32]): signing key
	
	properties(Constant)
		ID = 256
		LEN = 42
	end
	
	properties
        initial_timestamp	%initial timestamp	|	(uint64)
        target_system	%system id of the target	|	(uint8)
        target_component	%component ID of the target	|	(uint8)
        secret_key	%signing key	|	(uint8[32])
    end

    methods(Static)

        function send(out,initial_timestamp,target_system,target_component,secret_key,varargin)

            if nargin == 4 + 1
                msg = msg_setup_signing(initial_timestamp,target_system,target_component,secret_key,varargin);
            elseif nargin == 2
                msg = msg_setup_signing(initial_timestamp);
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

        function obj = msg_setup_signing(initial_timestamp,target_system,target_component,secret_key,varargin)
        %MSG_SETUP_SIGNING: Create a new setup_signing message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(initial_timestamp,'MAVLinkPacket')
                    packet = initial_timestamp;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('initial_timestamp','MAVLinkPacket');
                end
            elseif nargin >= 4 && isempty(varargin{1})
                obj.initial_timestamp = initial_timestamp;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.secret_key = secret_key;
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

                packet = MAVLinkPacket(msg_setup_signing.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_setup_signing.ID;
                
                packet.payload.putUINT64(obj.initial_timestamp);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                for i=1:1:32
                    packet.payload.putUINT8(obj.secret_key(i));
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
            
            obj.initial_timestamp = payload.getUINT64();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            for i=1:1:32
                obj.secret_key(i) = payload.getUINT8();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.initial_timestamp,2) ~= 1
                result = 'initial_timestamp';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';
            elseif size(obj.secret_key,2) ~= 32
                result = 'secret_key';

            else
                result = 0;
            end
        end

        function set.initial_timestamp(obj,value)
            if value == uint64(value)
                obj.initial_timestamp = uint64(value);
            else
                MAVLink.throwTypeError('value','uint64');
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
        
        function set.secret_key(obj,value)
            if value == uint8(value)
                obj.secret_key = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end