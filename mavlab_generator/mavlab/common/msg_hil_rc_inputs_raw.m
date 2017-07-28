classdef msg_hil_rc_inputs_raw < mavlink_message
	%MSG_HIL_RC_INPUTS_RAW(packet,time_usec,chan1_raw,chan2_raw,chan3_raw,chan4_raw,chan5_raw,chan6_raw,chan7_raw,chan8_raw,chan9_raw,chan10_raw,chan11_raw,chan12_raw,rssi): MAVLINK Message ID = 92
    %Description:
    %    Sent from simulation to autopilot. The RAW values of the RC channels received. The standard PPM modulation is as follows: 1000 microseconds: 0