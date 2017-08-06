classdef msg_rc_channels_override < MAVLinkMessage
	%MSG_RC_CHANNELS_OVERRIDE: MAVLink Message ID = 70
    %Description:
    %    The RAW values of the RC channels sent to the MAV to override info received from the RC radio. A value of UINT16_MAX means no change to that channel. A value of 0 means control of that channel should be released back to the RC radio. The standard PPM modulation is as follows: 1000 microseconds: 0