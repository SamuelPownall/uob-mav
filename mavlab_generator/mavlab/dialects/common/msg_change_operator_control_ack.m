classdef msg_change_operator_control_ack < MAVLinkMessage
	%MSG_CHANGE_OPERATOR_CONTROL_ACK: MAVLink Message ID = 6
    %Description:
    %    Accept / deny control of this MAV
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    gcs_system_id(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    gcs_system_id(uint8): ID of the GCS this message
    %    control_request(uint8): 0: request control of this MAV, 1: Release control of this MAV
    %    ack(uint8): 0: ACK, 1: NACK: Wrong passkey, 2: NACK: Unsupported passkey encryption method, 3: NACK: Already under control
	
	properties(Constant)
		ID = 6
		LEN = 3
	end
	
	properties
        gcs_system_id	%ID of the GCS this message	|	(uint8)
        control_request	%0: request control of this MAV, 1: Release control of this MAV	|	(uint8)
        ack	%0: ACK, 1: NACK: Wrong passkey, 2: NACK: Unsupported passkey encryption method, 3: NACK: Already under control	|	(uint8)
    end

    methods(Static)

        function send(out,gcs_system_id,control_request,ack,varargin)

            if nargin == 3 + 1
                msg = msg_change_operator_control_ack(gcs_system_id,control_request,ack,varargin);
            elseif nargin == 2
                msg = msg_change_operator_control_ack(gcs_system_id);
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

        function obj = msg_change_operator_control_ack(gcs_system_id,control_request,ack,varargin)
        %MSG_CHANGE_OPERATOR_CONTROL_ACK: Create a new change_operator_control_ack message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(gcs_system_id,'MAVLinkPacket')
                    packet = gcs_system_id;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('gcs_system_id','MAVLinkPacket');
                end
            elseif nargin >= 3 && isempty(varargin{1})
                obj.gcs_system_id = gcs_system_id;
                obj.control_request = control_request;
                obj.ack = ack;
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

                packet = MAVLinkPacket(msg_change_operator_control_ack.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_change_operator_control_ack.ID;
                
                packet.payload.putUINT8(obj.gcs_system_id);
                packet.payload.putUINT8(obj.control_request);
                packet.payload.putUINT8(obj.ack);

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
            
            obj.gcs_system_id = payload.getUINT8();
            obj.control_request = payload.getUINT8();
            obj.ack = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.gcs_system_id,2) ~= 1
                result = 'gcs_system_id';
            elseif size(obj.control_request,2) ~= 1
                result = 'control_request';
            elseif size(obj.ack,2) ~= 1
                result = 'ack';

            else
                result = 0;
            end
        end

        function set.gcs_system_id(obj,value)
            if value == uint8(value)
                obj.gcs_system_id = uint8(value);
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
        
        function set.ack(obj,value)
            if value == uint8(value)
                obj.ack = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end