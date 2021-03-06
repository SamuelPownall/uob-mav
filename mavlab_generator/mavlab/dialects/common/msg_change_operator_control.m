classdef msg_change_operator_control < MAVLinkMessage
	%MSG_CHANGE_OPERATOR_CONTROL: MAVLink Message ID = 5
    %Description:
    %    Request to control this MAV
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    target_system(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,target_system,control_request,version,passkey,varargin)

            if nargin == 4 + 1
                msg = msg_change_operator_control(target_system,control_request,version,passkey,varargin);
            elseif nargin == 2
                msg = msg_change_operator_control(target_system);
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

        function obj = msg_change_operator_control(target_system,control_request,version,passkey,varargin)
        %MSG_CHANGE_OPERATOR_CONTROL: Create a new change_operator_control message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(target_system,'MAVLinkPacket')
                    packet = target_system;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('target_system','MAVLinkPacket');
                end
            elseif nargin >= 4 && isempty(varargin{1})
                obj.target_system = target_system;
                obj.control_request = control_request;
                obj.version = version;
                obj.passkey = passkey;
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

                packet = MAVLinkPacket(msg_change_operator_control.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_change_operator_control.ID;
                
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.control_request);
                packet.payload.putUINT8(obj.version);
                for i=1:1:25
                    packet.payload.putUINT8(obj.passkey(i));
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
            
            obj.target_system = payload.getUINT8();
            obj.control_request = payload.getUINT8();
            obj.version = payload.getUINT8();
            for i=1:1:25
                obj.passkey(i) = payload.getUINT8();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

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
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.control_request(obj,value)
            if value == uint8(value)
                obj.control_request = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.version(obj,value)
            if value == uint8(value)
                obj.version = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.passkey(obj,value)
            if value == uint8(value)
                obj.passkey = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end