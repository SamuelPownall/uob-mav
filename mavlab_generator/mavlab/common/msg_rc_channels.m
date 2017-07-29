classdef msg_rc_channels < mavlink_handle
	%MSG_RC_CHANNELS(packet,time_boot_ms,chan1_raw,chan2_raw,chan3_raw,chan4_raw,chan5_raw,chan6_raw,chan7_raw,chan8_raw,chan9_raw,chan10_raw,chan11_raw,chan12_raw,chan13_raw,chan14_raw,chan15_raw,chan16_raw,chan17_raw,chan18_raw,chancount,rssi): MAVLINK Message ID = 65
    %Description:
    %    The PPM values of the RC channels received. The standard PPM modulation is as follows: 1000 microseconds: 0