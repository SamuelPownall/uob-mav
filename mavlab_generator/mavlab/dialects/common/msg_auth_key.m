classdef msg_auth_key < MAVLinkMessage
	%MSG_AUTH_KEY: MAVLink Message ID = 7
    %Description:
    %    Emit an encrypted signature / key identifying this system. PLEASE NOTE: This protocol has been kept simple, so transmitting the key requires an encrypted channel for true safety.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    key(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    key(uint8[32]): key
	
	properties(Constant)
		ID = 7
		LEN = 32
	end
	
	properties
        key	%key	|	(uint8[32])
    end

    methods(Static)

        function send(out,key,varargin)

            if nargin == 1 + 1
                msg = msg_auth_key(key,varargin);
            elseif nargin == 2
                msg = msg_auth_key(key);
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

        function obj = msg_auth_key(key,varargin)
        %MSG_AUTH_KEY: Create a new auth_key message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(key,'MAVLinkPacket')
                    packet = key;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    obj.key = key;
                end
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

                packet = MAVLinkPacket(msg_auth_key.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_auth_key.ID;
                
                for i=1:1:32
                    packet.payload.putUINT8(obj.key(i));
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
            
            for i=1:1:32
                obj.key(i) = payload.getUINT8();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.key,2) ~= 32
                result = 'key';

            else
                result = 0;
            end
        end

        function set.key(obj,value)
            if value == uint8(value)
                obj.key = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end