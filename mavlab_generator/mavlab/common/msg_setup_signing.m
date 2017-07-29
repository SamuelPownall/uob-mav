classdef msg_setup_signing < mavlink_handle
	%MSG_SETUP_SIGNING(packet,initial_timestamp,target_system,target_component,secret_key): MAVLINK Message ID = 256
    %Description:
    %    Setup a MAVLink2 signing key. If called with secret_key of all zero and zero initial_timestamp will disable signing
    %    If constructing from fields, packet argument should be set to []
	%Fields:
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

    methods

        %Constructor: msg_setup_signing
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_setup_signing(packet,initial_timestamp,target_system,target_component,secret_key)
        
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
            
            elseif nargin-1 == 4
                obj.initial_timestamp = initial_timestamp;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.secret_key = secret_key;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_setup_signing.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_setup_signing.ID;
                
                packet.payload.putUINT64(obj.initial_timestamp);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                for i=1:1:32
                    packet.payload.putUINT8(obj.secret_key(i));
                end

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.initial_timestamp = payload.getUINT64();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            for i=1:1:32
                obj.secret_key(i) = payload.getUINT8();
            end

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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
                mavlink.throwTypeError('value','uint64');
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
        
        function set.secret_key(obj,value)
            if value == uint8(value)
                obj.secret_key = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end