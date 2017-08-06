classdef msg_servo_output_raw < MAVLinkMessage
	%MSG_SERVO_OUTPUT_RAW: MAVLink Message ID = 36
    %Description:
    %    The RAW values of the servo outputs (for RC input from the remote, use the RC_CHANNELS messages). The standard PPM modulation is as follows: 1000 microseconds: 0