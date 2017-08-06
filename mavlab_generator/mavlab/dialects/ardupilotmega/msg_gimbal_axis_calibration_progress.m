classdef msg_gimbal_axis_calibration_progress < MAVLinkMessage
	%MSG_GIMBAL_AXIS_CALIBRATION_PROGRESS: MAVLink Message ID = 203
    %Description:
    %    Reports progress and success or failure of gimbal axis calibration procedure
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    calibration_axis(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    calibration_axis(uint8): Which gimbal axis we're reporting calibration progress for
    %    calibration_progress(uint8): The current calibration progress for this axis, 0x64=100