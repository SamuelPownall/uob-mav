classdef msg_gimbal_home_offset_calibration_result < mavlink_message
	%MSG_GIMBAL_HOME_OFFSET_CALIBRATION_RESULT: MAVLINK Message ID = 205
    %Description:
    %    Sent by the gimbal after it receives a SET_HOME_OFFSETS message to indicate the result of the home offset calibration
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
    %    calibration_result(uint8): The result of the home offset calibration
	
	properties(Constant)
		ID = 205
		LEN = 1
	end
	
	properties
        calibration_result	%The result of the home offset calibration	|	(uint8)
    end

    methods

        function obj = msg_gimbal_home_offset_calibration_result(packet,calibration_result)
        %Create a new gimbal_home_offset_calibration_result message
        
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
                obj.calibration_result = calibration_result;
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

                packet = mavlink_packet(msg_gimbal_home_offset_calibration_result.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_gimbal_home_offset_calibration_result.ID;
                
                packet.payload.putUINT8(obj.calibration_result);

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
            
            obj.calibration_result = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.calibration_result,2) ~= 1
                result = 'calibration_result';

            else
                result = 0;
            end
        end

        function set.calibration_result(obj,value)
            if value == uint8(value)
                obj.calibration_result = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end