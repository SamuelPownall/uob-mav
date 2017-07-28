classdef msg_sys_status < mavlink_message
	%MSG_SYS_STATUS(packet,onboard_control_sensors_present,onboard_control_sensors_enabled,onboard_control_sensors_health,load,voltage_battery,current_battery,drop_rate_comm,errors_comm,errors_count1,errors_count2,errors_count3,errors_count4,battery_remaining): MAVLINK Message ID = 1
    %Description:
    %    The general system state. If the system is following the MAVLink standard, the system state is mainly defined by three orthogonal states/modes: The system mode, which is either LOCKED (motors shut down and locked), MANUAL (system under RC control), GUIDED (system with autonomous position control, position setpoint controlled manually) or AUTO (system guided by path/waypoint planner). The NAV_MODE defined the current flight state: LIFTOFF (often an open-loop maneuver), LANDING, WAYPOINTS or VECTOR. This represents the internal navigation state machine. The system status shows wether the system is currently active or not and if an emergency occured. During the CRITICAL and EMERGENCY states the MAV is still considered to be active, but should start emergency procedures autonomously. After a failure occured it should first move from active to critical to allow manual intervention and then move to emergency after a certain timeout.
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    onboard_control_sensors_present(uint32): Bitmask showing which onboard controllers and sensors are present. Value of 0: not present. Value of 1: present. Indices defined by ENUM MAV_SYS_STATUS_SENSOR
    %    onboard_control_sensors_enabled(uint32): Bitmask showing which onboard controllers and sensors are enabled:  Value of 0: not enabled. Value of 1: enabled. Indices defined by ENUM MAV_SYS_STATUS_SENSOR
    %    onboard_control_sensors_health(uint32): Bitmask showing which onboard controllers and sensors are operational or have an error:  Value of 0: not enabled. Value of 1: enabled. Indices defined by ENUM MAV_SYS_STATUS_SENSOR
    %    load(uint16): Maximum usage in percent of the mainloop time, (0