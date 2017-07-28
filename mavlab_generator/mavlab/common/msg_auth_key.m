classdef msg_auth_key < mavlink_message
	%MSG_AUTH_KEY(packet,key): MAVLINK Message ID = 7
    %Description:
    %    Emit an encrypted signature / key identifying this system. PLEASE NOTE: This protocol has been kept simple, so transmitting the key requires an encrypted channel for true safety.
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    key(uint8[32]): key
	
	properties(Constant)
		ID = 7
		LEN = 32
	end
	
	properties
        key	%key	|	(uint8[32])
    end

    methods

        %Constructor: msg_auth_key
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_auth_key(packet,key)
        
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
            
            elseif nargin-1 == 1
                obj.key = key;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

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

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            for i=1:1:32
                obj.key(i) = payload.getUINT8();
            end

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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