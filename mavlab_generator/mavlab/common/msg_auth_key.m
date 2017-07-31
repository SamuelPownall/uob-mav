classdef msg_auth_key < mavlink_message
	%MSG_AUTH_KEY: MAVLINK Message ID = 7
    %Description:
    %    Emit an encrypted signature / key identifying this system. PLEASE NOTE: This protocol has been kept simple, so transmitting the key requires an encrypted channel for true safety.
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    key(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    key(uint8[32]): key
	
	properties(Constant)
		ID = 7
		LEN = 32
	end
	
	properties
        key	%key	|	(uint8[32])
    end

    methods

        function obj = msg_auth_key(key,varargin)
        %MSG_AUTH_KEY: Create a new auth_key message object
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1 
                if isa(key,'mavlink_packet')
                    packet = key;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    obj.key = key;
                end
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

                packet = mavlink_packet(msg_auth_key.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_auth_key.ID;
                
                for i=1:1:32
                    packet.payload.putUINT8(obj.key(i));
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
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end