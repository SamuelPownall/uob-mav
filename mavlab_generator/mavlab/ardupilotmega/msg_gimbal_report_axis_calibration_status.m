classdef msg_gimbal_report_axis_calibration_status < mavlink_message
	%MSG_GIMBAL_REPORT_AXIS_CALIBRATION_STATUS: MAVLINK Message ID = 212
    %Description:
    %    Reports the calibration status for each gimbal axis (whether the axis requires calibration or not)
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
    %    yaw_requires_calibration(uint8): Whether or not the yaw axis requires calibration, see GIMBAL_AXIS_CALIBRATION_REQUIRED enumeration
    %    pitch_requires_calibration(uint8): Whether or not the pitch axis requires calibration, see GIMBAL_AXIS_CALIBRATION_REQUIRED enumeration
    %    roll_requires_calibration(uint8): Whether or not the roll axis requires calibration, see GIMBAL_AXIS_CALIBRATION_REQUIRED enumeration
	
	properties(Constant)
		ID = 212
		LEN = 3
	end
	
	properties
        yaw_requires_calibration	%Whether or not the yaw axis requires calibration, see GIMBAL_AXIS_CALIBRATION_REQUIRED enumeration	|	(uint8)
        pitch_requires_calibration	%Whether or not the pitch axis requires calibration, see GIMBAL_AXIS_CALIBRATION_REQUIRED enumeration	|	(uint8)
        roll_requires_calibration	%Whether or not the roll axis requires calibration, see GIMBAL_AXIS_CALIBRATION_REQUIRED enumeration	|	(uint8)
    end

    methods

        function obj = msg_gimbal_report_axis_calibration_status(packet,yaw_requires_calibration,pitch_requires_calibration,roll_requires_calibration)
        %Create a new gimbal_report_axis_calibration_status message
        
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
            
            elseif nargin-1 == 3
                obj.yaw_requires_calibration = yaw_requires_calibration;
                obj.pitch_requires_calibration = pitch_requires_calibration;
                obj.roll_requires_calibration = roll_requires_calibration;
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

                packet = mavlink_packet(msg_gimbal_report_axis_calibration_status.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_gimbal_report_axis_calibration_status.ID;
                
                packet.payload.putUINT8(obj.yaw_requires_calibration);
                packet.payload.putUINT8(obj.pitch_requires_calibration);
                packet.payload.putUINT8(obj.roll_requires_calibration);

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
            
            obj.yaw_requires_calibration = payload.getUINT8();
            obj.pitch_requires_calibration = payload.getUINT8();
            obj.roll_requires_calibration = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.yaw_requires_calibration,2) ~= 1
                result = 'yaw_requires_calibration';
            elseif size(obj.pitch_requires_calibration,2) ~= 1
                result = 'pitch_requires_calibration';
            elseif size(obj.roll_requires_calibration,2) ~= 1
                result = 'roll_requires_calibration';

            else
                result = 0;
            end
        end

        function set.yaw_requires_calibration(obj,value)
            if value == uint8(value)
                obj.yaw_requires_calibration = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.pitch_requires_calibration(obj,value)
            if value == uint8(value)
                obj.pitch_requires_calibration = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.roll_requires_calibration(obj,value)
            if value == uint8(value)
                obj.roll_requires_calibration = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end