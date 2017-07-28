classdef msg_gimbal_report_axis_calibration_status < mavlink_message
	%MSG_GIMBAL_REPORT_AXIS_CALIBRATION_STATUS(packet,yaw_requires_calibration,pitch_requires_calibration,roll_requires_calibration): MAVLINK Message ID = 212
    %Description:
    %    
    		Reports the calibration status for each gimbal axis (whether the axis requires calibration or not)
    	
    %    If constructing from fields, packet argument should be set to []
	%Fields:
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

        %Constructor: msg_gimbal_report_axis_calibration_status
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_gimbal_report_axis_calibration_status(packet,yaw_requires_calibration,pitch_requires_calibration,roll_requires_calibration)
        
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

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

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

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.yaw_requires_calibration = payload.getUINT8();
            obj.pitch_requires_calibration = payload.getUINT8();
            obj.roll_requires_calibration = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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