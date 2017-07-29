classdef msg_servo_output_raw < mavlink_message
	%MSG_SERVO_OUTPUT_RAW: MAVLINK Message ID = 36
    %Description:
    %    The RAW values of the servo outputs (for RC input from the remote, use the RC_CHANNELS messages). The standard PPM modulation is as follows: 1000 microseconds: 0