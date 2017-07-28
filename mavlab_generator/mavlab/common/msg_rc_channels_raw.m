classdef msg_rc_channels_raw < mavlink_message
	%MSG_RC_CHANNELS_RAW(packet,time_boot_ms,chan1_raw,chan2_raw,chan3_raw,chan4_raw,chan5_raw,chan6_raw,chan7_raw,chan8_raw,port,rssi): MAVLINK Message ID = 35
    %Description:
    %    The RAW values of the RC channels received. The standard PPM modulation is as follows: 1000 microseconds: 0