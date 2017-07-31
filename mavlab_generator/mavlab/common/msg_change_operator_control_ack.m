classdef msg_change_operator_control_ack < mavlink_message
	%MSG_CHANGE_OPERATOR_CONTROL_ACK: MAVLINK Message ID = 6
    %Description:
    %    Accept / deny control of this MAV
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    gcs_system_id(mavlink_packet): Alternative way to construct a message using a mavlink_packet
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

    methods

        function obj = msg_change_operator_control_ack(gcs_system_id,control_request,ack,varargin)
        %Create a new change_operator_control_ack message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(gcs_system_id,'mavlink_packet')
                    packet = gcs_system_id;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('gcs_system_id','mavlink_packet');
                end
            
            elseif nargin == 3
                obj.gcs_system_id = gcs_system_id;
                obj.control_request = control_request;
                obj.ack = ack;
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

                packet = mavlink_packet(msg_change_operator_control_ack.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_change_operator_control_ack.ID;
                
                packet.payload.putUINT8(obj.gcs_system_id);
                packet.payload.putUINT8(obj.control_request);
                packet.payload.putUINT8(obj.ack);

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
        
        function set.ack(obj,value)
            if value == uint8(value)
                obj.ack = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end