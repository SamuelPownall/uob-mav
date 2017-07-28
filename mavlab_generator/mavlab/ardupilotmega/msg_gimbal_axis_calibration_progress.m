classdef msg_gimbal_axis_calibration_progress < mavlink_message
	%MSG_GIMBAL_AXIS_CALIBRATION_PROGRESS(packet,calibration_axis,calibration_progress,calibration_status): MAVLINK Message ID = 203
    %Description:
    %    
            Reports progress and success or failure of gimbal axis calibration procedure
        
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    calibration_axis(uint8): Which gimbal axis we're reporting calibration progress for
    %    calibration_progress(uint8): The current calibration progress for this axis, 0x64=100