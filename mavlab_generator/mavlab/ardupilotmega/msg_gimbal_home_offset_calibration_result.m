classdef msg_gimbal_home_offset_calibration_result < mavlink_handle
	%MSG_GIMBAL_HOME_OFFSET_CALIBRATION_RESULT(packet,calibration_result): MAVLINK Message ID = 205
    %Description:
    %    
            Sent by the gimbal after it receives a SET_HOME_OFFSETS message to indicate the result of the home offset calibration
        
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    calibration_result(uint8): The result of the home offset calibration
	
	properties(Constant)
		ID = 205
		LEN = 1
	end
	
	properties
        calibration_result	%The result of the home offset calibration	|	(uint8)
    end

    methods

        %Constructor: msg_gimbal_home_offset_calibration_result
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_gimbal_home_offset_calibration_result(packet,calibration_result)
        
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

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

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

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.calibration_result = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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