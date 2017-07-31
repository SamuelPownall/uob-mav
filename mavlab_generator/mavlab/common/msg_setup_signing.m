classdef msg_setup_signing < mavlink_message
	%MSG_SETUP_SIGNING: MAVLINK Message ID = 256
    %Description:
    %    Setup a MAVLink2 signing key. If called with secret_key of all zero and zero initial_timestamp will disable signing
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    initial_timestamp(mavlink_packet): Alternative way to construct a message using a mavlink_packet
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

        function obj = msg_setup_signing(initial_timestamp,target_system,target_component,secret_key,varargin)
        %MSG_SETUP_SIGNING: Create a new setup_signing message object
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1 
                if isa(initial_timestamp,'mavlink_packet')
                    packet = initial_timestamp;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('initial_timestamp','mavlink_packet');
                end
            elseif nargin == 4
                obj.initial_timestamp = initial_timestamp;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.secret_key = secret_key;
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

        function unpack(obj, payload)
        %UNPACK: Unpacks a mavlink_payload into this MAVLINK message
        %Description:
        %    Extracts the data from a mavlink_payload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(mavlink_payload): The payload to be unpacked into this MAVLINK message

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