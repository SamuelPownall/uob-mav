classdef msg_hil_rc_inputs_raw < MAVLinkMessage
	%MSG_HIL_RC_INPUTS_RAW: MAVLink Message ID = 92
    %Description:
    %    Sent from simulation to autopilot. The RAW values of the RC channels received. The standard PPM modulation is as follows: 1000 microseconds: 0