classdef msg_rc_channels_scaled < mavlink_message
	%MSG_RC_CHANNELS_SCALED(packet,time_boot_ms,chan1_scaled,chan2_scaled,chan3_scaled,chan4_scaled,chan5_scaled,chan6_scaled,chan7_scaled,chan8_scaled,port,rssi): MAVLINK Message ID = 34
    %Description:
    %    The scaled values of the RC channels received. (-100