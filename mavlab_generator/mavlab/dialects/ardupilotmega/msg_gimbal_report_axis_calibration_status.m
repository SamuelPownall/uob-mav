classdef msg_gimbal_report_axis_calibration_status < MAVLinkMessage
	%MSG_GIMBAL_REPORT_AXIS_CALIBRATION_STATUS: MAVLink Message ID = 212
    %Description:
    %    Reports the calibration status for each gimbal axis (whether the axis requires calibration or not)
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    yaw_requires_calibration(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,yaw_requires_calibration,pitch_requires_calibration,roll_requires_calibration,varargin)

            if nargin == 3 + 1
                msg = msg_gimbal_report_axis_calibration_status(yaw_requires_calibration,pitch_requires_calibration,roll_requires_calibration,varargin);
            elseif nargin == 2
                msg = msg_gimbal_report_axis_calibration_status(yaw_requires_calibration);
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

        function obj = msg_gimbal_report_axis_calibration_status(yaw_requires_calibration,pitch_requires_calibration,roll_requires_calibration,varargin)
        %MSG_GIMBAL_REPORT_AXIS_CALIBRATION_STATUS: Create a new gimbal_report_axis_calibration_status message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(yaw_requires_calibration,'MAVLinkPacket')
                    packet = yaw_requires_calibration;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('yaw_requires_calibration','MAVLinkPacket');
                end
            elseif nargin >= 3 && isempty(varargin{1})
                obj.yaw_requires_calibration = yaw_requires_calibration;
                obj.pitch_requires_calibration = pitch_requires_calibration;
                obj.roll_requires_calibration = roll_requires_calibration;
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

                packet = MAVLinkPacket(msg_gimbal_report_axis_calibration_status.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_gimbal_report_axis_calibration_status.ID;
                
                packet.payload.putUINT8(obj.yaw_requires_calibration);
                packet.payload.putUINT8(obj.pitch_requires_calibration);
                packet.payload.putUINT8(obj.roll_requires_calibration);

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
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.pitch_requires_calibration(obj,value)
            if value == uint8(value)
                obj.pitch_requires_calibration = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.roll_requires_calibration(obj,value)
            if value == uint8(value)
                obj.roll_requires_calibration = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end