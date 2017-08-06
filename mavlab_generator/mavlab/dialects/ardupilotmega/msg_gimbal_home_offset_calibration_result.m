classdef msg_gimbal_home_offset_calibration_result < MAVLinkMessage
	%MSG_GIMBAL_HOME_OFFSET_CALIBRATION_RESULT: MAVLink Message ID = 205
    %Description:
    %    Sent by the gimbal after it receives a SET_HOME_OFFSETS message to indicate the result of the home offset calibration
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    calibration_result(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    calibration_result(uint8): The result of the home offset calibration
	
	properties(Constant)
		ID = 205
		LEN = 1
	end
	
	properties
        calibration_result	%The result of the home offset calibration	|	(uint8)
    end

    methods(Static)

        function send(out,calibration_result,varargin)

            if nargin == 1 + 1
                msg = msg_gimbal_home_offset_calibration_result(calibration_result,varargin);
            elseif nargin == 2
                msg = msg_gimbal_home_offset_calibration_result(calibration_result);
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

        function obj = msg_gimbal_home_offset_calibration_result(calibration_result,varargin)
        %MSG_GIMBAL_HOME_OFFSET_CALIBRATION_RESULT: Create a new gimbal_home_offset_calibration_result message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(calibration_result,'MAVLinkPacket')
                    packet = calibration_result;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    obj.calibration_result = calibration_result;
                end
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

                packet = MAVLinkPacket(msg_gimbal_home_offset_calibration_result.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_gimbal_home_offset_calibration_result.ID;
                
                packet.payload.putUINT8(obj.calibration_result);

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
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end