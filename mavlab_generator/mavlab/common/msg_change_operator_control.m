classdef msg_change_operator_control < mavlink_message
	%MSG_CHANGE_OPERATOR_CONTROL(packet,target_system,control_request,version,passkey): MAVLINK Message ID = 5
    %Description:
    %    Request to control this MAV
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    target_system(uint8): System the GCS requests control for
    %    control_request(uint8): 0: request control of this MAV, 1: Release control of this MAV
    %    version(uint8): 0: key as plaintext, 1-255: future, different hashing/encryption variants. The GCS should in general use the safest mode possible initially and then gradually move down the encryption level if it gets a NACK message indicating an encryption mismatch.
    %    passkey(uint8[25]): Password / Key, depending on version plaintext or encrypted. 25 or less characters, NULL terminated. The characters may involve A-Z, a-z, 0-9, and "!?,.-"
	
	properties(Constant)
		ID = 5
		LEN = 28
	end
	
	properties
        target_system	%System the GCS requests control for	|	(uint8)
        control_request	%0: request control of this MAV, 1: Release control of this MAV	|	(uint8)
        version	%0: key as plaintext, 1-255: future, different hashing/encryption variants. The GCS should in general use the safest mode possible initially and then gradually move down the encryption level if it gets a NACK message indicating an encryption mismatch.	|	(uint8)
        passkey	%Password / Key, depending on version plaintext or encrypted. 25 or less characters, NULL terminated. The characters may involve A-Z, a-z, 0-9, and "!?,.-"	|	(uint8[25])
    end

    methods

        %Constructor: msg_change_operator_control
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_change_operator_control(packet,target_system,control_request,version,passkey)
        
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
                obj.target_system = target_system;
                obj.control_request = control_request;
                obj.version = version;
                obj.passkey = passkey;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_change_operator_control.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_change_operator_control.ID;
                
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.control_request);
                packet.payload.putUINT8(obj.version);
                for i=1:1:25
                    packet.payload.putUINT8(obj.passkey(i));
                end

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.target_system = payload.getUINT8();
            obj.control_request = payload.getUINT8();
            obj.version = payload.getUINT8();
            for i=1:1:25
                obj.passkey(i) = payload.getUINT8();
            end

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.control_request,2) ~= 1
                result = 'control_request';
            elseif size(obj.version,2) ~= 1
                result = 'version';
            elseif size(obj.passkey,2) ~= 25
                result = 'passkey';

            else
                result = 0;
            end
        end

        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.control_request(obj,value)
            if value == uint8(value)
                obj.control_request = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.version(obj,value)
            if value == uint8(value)
                obj.version = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.passkey(obj,value)
            if value == uint8(value)
                obj.passkey = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end