classdef msg_servo_output_raw < mavlink_message
	%MSG_SERVO_OUTPUT_RAW(packet,time_usec,servo1_raw,servo2_raw,servo3_raw,servo4_raw,servo5_raw,servo6_raw,servo7_raw,servo8_raw,port): MAVLINK Message ID = 36
    %Description:
    %    The RAW values of the servo outputs (for RC input from the remote, use the RC_CHANNELS messages). The standard PPM modulation is as follows: 1000 microseconds: 0