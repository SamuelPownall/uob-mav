classdef msg_battery_status < MAVLinkMessage
	%MSG_BATTERY_STATUS: MAVLink Message ID = 147
    %Description:
    %    Battery information
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    current_consumed(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    current_consumed(int32): Consumed charge, in milliampere hours (1 = 1 mAh), -1: autopilot does not provide mAh consumption estimate
    %    energy_consumed(int32): Consumed energy, in 100*Joules (intergrated U*I*dt)  (1 = 100 Joule), -1: autopilot does not provide energy consumption estimate
    %    temperature(int16): Temperature of the battery in centi-degrees celsius. INT16_MAX for unknown temperature.
    %    voltages(uint16[10]): Battery voltage of cells, in millivolts (1 = 1 millivolt). Cells above the valid cell count for this battery should have the UINT16_MAX value.
    %    current_battery(int16): Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current
    %    id(uint8): Battery ID
    %    battery_function(uint8): Function of the battery
    %    type(uint8): Type (chemistry) of the battery
    %    battery_remaining(int8): Remaining battery energy: (0