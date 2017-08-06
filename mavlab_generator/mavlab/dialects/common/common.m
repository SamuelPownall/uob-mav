classdef common < uint16
%COMMON: Enumeration class for the 'common' dialect
    
    enumeration 
        MAV_AUTOPILOT_GENERIC (0) %Generic autopilot, full support for everything
        MAV_AUTOPILOT_RESERVED (1) %Reserved for future use.
        MAV_AUTOPILOT_SLUGS (2) %SLUGS autopilot, http://slugsuav.soe.ucsc.edu
        MAV_AUTOPILOT_ARDUPILOTMEGA (3) %ArduPilotMega / ArduCopter, http://diydrones.com
        MAV_AUTOPILOT_OPENPILOT (4) %OpenPilot, http://openpilot.org
        MAV_AUTOPILOT_GENERIC_WAYPOINTS_ONLY (5) %Generic autopilot only supporting simple waypoints
        MAV_AUTOPILOT_GENERIC_WAYPOINTS_AND_SIMPLE_NAVIGATION_ONLY (6) %Generic autopilot supporting waypoints and other simple navigation commands
        MAV_AUTOPILOT_GENERIC_MISSION_FULL (7) %Generic autopilot supporting the full mission command set
        MAV_AUTOPILOT_INVALID (8) %No valid autopilot, e.g. a GCS or other MAVLink component
        MAV_AUTOPILOT_PPZ (9) %PPZ UAV - http://nongnu.org/paparazzi
        MAV_AUTOPILOT_UDB (10) %UAV Dev Board
        MAV_AUTOPILOT_FP (11) %FlexiPilot
        MAV_AUTOPILOT_PX4 (12) %PX4 Autopilot - http://pixhawk.ethz.ch/px4/
        MAV_AUTOPILOT_SMACCMPILOT (13) %SMACCMPilot - http://smaccmpilot.org
        MAV_AUTOPILOT_AUTOQUAD (14) %AutoQuad -- http://autoquad.org
        MAV_AUTOPILOT_ARMAZILA (15) %Armazila -- http://armazila.com
        MAV_AUTOPILOT_AEROB (16) %Aerob -- http://aerob.ru
        MAV_AUTOPILOT_ASLUAV (17) %ASLUAV autopilot -- http://www.asl.ethz.ch
        MAV_TYPE_GENERIC (0) %Generic micro air vehicle.
        MAV_TYPE_FIXED_WING (1) %Fixed wing aircraft.
        MAV_TYPE_QUADROTOR (2) %Quadrotor
        MAV_TYPE_COAXIAL (3) %Coaxial helicopter
        MAV_TYPE_HELICOPTER (4) %Normal helicopter with tail rotor.
        MAV_TYPE_ANTENNA_TRACKER (5) %Ground installation
        MAV_TYPE_GCS (6) %Operator control unit / ground control station
        MAV_TYPE_AIRSHIP (7) %Airship, controlled
        MAV_TYPE_FREE_BALLOON (8) %Free balloon, uncontrolled
        MAV_TYPE_ROCKET (9) %Rocket
        MAV_TYPE_GROUND_ROVER (10) %Ground rover
        MAV_TYPE_SURFACE_BOAT (11) %Surface vessel, boat, ship
        MAV_TYPE_SUBMARINE (12) %Submarine
        MAV_TYPE_HEXAROTOR (13) %Hexarotor
        MAV_TYPE_OCTOROTOR (14) %Octorotor
        MAV_TYPE_TRICOPTER (15) %Tricopter
        MAV_TYPE_FLAPPING_WING (16) %Flapping wing
        MAV_TYPE_KITE (17) %Kite
        MAV_TYPE_ONBOARD_CONTROLLER (18) %Onboard companion controller
        MAV_TYPE_VTOL_DUOROTOR (19) %Two-rotor VTOL using control surfaces in vertical operation in addition. Tailsitter.
        MAV_TYPE_VTOL_QUADROTOR (20) %Quad-rotor VTOL using a V-shaped quad config in vertical operation. Tailsitter.
        MAV_TYPE_VTOL_TILTROTOR (21) %Tiltrotor VTOL
        MAV_TYPE_VTOL_RESERVED2 (22) %VTOL reserved 2
        MAV_TYPE_VTOL_RESERVED3 (23) %VTOL reserved 3
        MAV_TYPE_VTOL_RESERVED4 (24) %VTOL reserved 4
        MAV_TYPE_VTOL_RESERVED5 (25) %VTOL reserved 5
        MAV_TYPE_GIMBAL (26) %Onboard gimbal
        MAV_TYPE_ADSB (27) %Onboard ADSB peripheral
        FIRMWARE_VERSION_TYPE_DEV (0) %development release
        FIRMWARE_VERSION_TYPE_ALPHA (64) %alpha release
        FIRMWARE_VERSION_TYPE_BETA (128) %beta release
        FIRMWARE_VERSION_TYPE_RC (192) %release candidate
        FIRMWARE_VERSION_TYPE_OFFICIAL (255) %official stable release
        MAV_MODE_FLAG_SAFETY_ARMED (128) %0b10000000 MAV safety set to armed. Motors are enabled / running / can start. Ready to fly. Additional note: this flag is to be ignore when sent in the command MAV_CMD_DO_SET_MODE and MAV_CMD_COMPONENT_ARM_DISARM shall be used instead. The flag can still be used to report the armed state.
        MAV_MODE_FLAG_MANUAL_INPUT_ENABLED (64) %0b01000000 remote control input is enabled.
        MAV_MODE_FLAG_HIL_ENABLED (32) %0b00100000 hardware in the loop simulation. All motors / actuators are blocked, but internal software is full operational.
        MAV_MODE_FLAG_STABILIZE_ENABLED (16) %0b00010000 system stabilizes electronically its attitude (and optionally position). It needs however further control inputs to move around.
        MAV_MODE_FLAG_GUIDED_ENABLED (8) %0b00001000 guided mode enabled, system flies MISSIONs / mission items.
        MAV_MODE_FLAG_AUTO_ENABLED (4) %0b00000100 autonomous mode enabled, system finds its own goal positions. Guided flag can be set or not, depends on the actual implementation.
        MAV_MODE_FLAG_TEST_ENABLED (2) %0b00000010 system has a test mode enabled. This flag is intended for temporary system tests and should not be used for stable implementations.
        MAV_MODE_FLAG_CUSTOM_MODE_ENABLED (1) %0b00000001 Reserved for future use.
        MAV_MODE_FLAG_DECODE_POSITION_SAFETY (128) %First bit:  10000000
        MAV_MODE_FLAG_DECODE_POSITION_MANUAL (64) %Second bit: 01000000
        MAV_MODE_FLAG_DECODE_POSITION_HIL (32) %Third bit:  00100000
        MAV_MODE_FLAG_DECODE_POSITION_STABILIZE (16) %Fourth bit: 00010000
        MAV_MODE_FLAG_DECODE_POSITION_GUIDED (8) %Fifth bit:  00001000
        MAV_MODE_FLAG_DECODE_POSITION_AUTO (4) %Sixt bit:   00000100
        MAV_MODE_FLAG_DECODE_POSITION_TEST (2) %Seventh bit: 00000010
        MAV_MODE_FLAG_DECODE_POSITION_CUSTOM_MODE (1) %Eighth bit: 00000001
        MAV_GOTO_DO_HOLD (0) %Hold at the current position.
        MAV_GOTO_DO_CONTINUE (1) %Continue with the next item in mission execution.
        MAV_GOTO_HOLD_AT_CURRENT_POSITION (2) %Hold at the current position of the system
        MAV_GOTO_HOLD_AT_SPECIFIED_POSITION (3) %Hold at the position specified in the parameters of the DO_HOLD action
        MAV_MODE_PREFLIGHT (0) %System is not ready to fly, booting, calibrating, etc. No flag is set.
        MAV_MODE_STABILIZE_DISARMED (80) %System is allowed to be active, under assisted RC control.
        MAV_MODE_STABILIZE_ARMED (208) %System is allowed to be active, under assisted RC control.
        MAV_MODE_MANUAL_DISARMED (64) %System is allowed to be active, under manual (RC) control, no stabilization
        MAV_MODE_MANUAL_ARMED (192) %System is allowed to be active, under manual (RC) control, no stabilization
        MAV_MODE_GUIDED_DISARMED (88) %System is allowed to be active, under autonomous control, manual setpoint
        MAV_MODE_GUIDED_ARMED (216) %System is allowed to be active, under autonomous control, manual setpoint
        MAV_MODE_AUTO_DISARMED (92) %System is allowed to be active, under autonomous control and navigation (the trajectory is decided onboard and not pre-programmed by MISSIONs)
        MAV_MODE_AUTO_ARMED (220) %System is allowed to be active, under autonomous control and navigation (the trajectory is decided onboard and not pre-programmed by MISSIONs)
        MAV_MODE_TEST_DISARMED (66) %UNDEFINED mode. This solely depends on the autopilot - use with caution, intended for developers only.
        MAV_MODE_TEST_ARMED (194) %UNDEFINED mode. This solely depends on the autopilot - use with caution, intended for developers only.
        MAV_STATE_UNINIT (0) %Uninitialized system, state is unknown.
        MAV_STATE_BOOT (0) %System is booting up.
        MAV_STATE_CALIBRATING (1) %System is calibrating and not flight-ready.
        MAV_STATE_STANDBY (2) %System is grounded and on standby. It can be launched any time.
        MAV_STATE_ACTIVE (3) %System is active and might be already airborne. Motors are engaged.
        MAV_STATE_CRITICAL (4) %System is in a non-normal flight mode. It can however still navigate.
        MAV_STATE_EMERGENCY (5) %System is in a non-normal flight mode. It lost control over parts or over the whole airframe. It is in mayday and going down.
        MAV_STATE_POWEROFF (6) %System just initialized its power-down sequence, will shut down now.
        MAV_COMP_ID_ALL (0) %No description available
        MAV_COMP_ID_GPS (220) %No description available
        MAV_COMP_ID_MISSIONPLANNER (190) %No description available
        MAV_COMP_ID_PATHPLANNER (195) %No description available
        MAV_COMP_ID_MAPPER (180) %No description available
        MAV_COMP_ID_CAMERA (100) %No description available
        MAV_COMP_ID_IMU (200) %No description available
        MAV_COMP_ID_IMU_2 (201) %No description available
        MAV_COMP_ID_IMU_3 (202) %No description available
        MAV_COMP_ID_UDP_BRIDGE (240) %No description available
        MAV_COMP_ID_UART_BRIDGE (241) %No description available
        MAV_COMP_ID_SYSTEM_CONTROL (250) %No description available
        MAV_COMP_ID_SERVO1 (140) %No description available
        MAV_COMP_ID_SERVO2 (141) %No description available
        MAV_COMP_ID_SERVO3 (142) %No description available
        MAV_COMP_ID_SERVO4 (143) %No description available
        MAV_COMP_ID_SERVO5 (144) %No description available
        MAV_COMP_ID_SERVO6 (145) %No description available
        MAV_COMP_ID_SERVO7 (146) %No description available
        MAV_COMP_ID_SERVO8 (147) %No description available
        MAV_COMP_ID_SERVO9 (148) %No description available
        MAV_COMP_ID_SERVO10 (149) %No description available
        MAV_COMP_ID_SERVO11 (150) %No description available
        MAV_COMP_ID_SERVO12 (151) %No description available
        MAV_COMP_ID_SERVO13 (152) %No description available
        MAV_COMP_ID_SERVO14 (153) %No description available
        MAV_COMP_ID_GIMBAL (154) %No description available
        MAV_COMP_ID_LOG (155) %No description available
        MAV_COMP_ID_ADSB (156) %No description available
        MAV_COMP_ID_OSD (157) %On Screen Display (OSD) devices for video links
        MAV_COMP_ID_PERIPHERAL (158) %Generic autopilot peripheral component ID. Meant for devices that do not implement the parameter sub-protocol
        MAV_COMP_ID_QX1_GIMBAL (159) %No description available
        MAV_SYS_STATUS_SENSOR_3D_GYRO (1) %0x01 3D gyro
        MAV_SYS_STATUS_SENSOR_3D_ACCEL (2) %0x02 3D accelerometer
        MAV_SYS_STATUS_SENSOR_3D_MAG (4) %0x04 3D magnetometer
        MAV_SYS_STATUS_SENSOR_ABSOLUTE_PRESSURE (8) %0x08 absolute pressure
        MAV_SYS_STATUS_SENSOR_DIFFERENTIAL_PRESSURE (16) %0x10 differential pressure
        MAV_SYS_STATUS_SENSOR_GPS (32) %0x20 GPS
        MAV_SYS_STATUS_SENSOR_OPTICAL_FLOW (64) %0x40 optical flow
        MAV_SYS_STATUS_SENSOR_VISION_POSITION (128) %0x80 computer vision position
        MAV_SYS_STATUS_SENSOR_LASER_POSITION (256) %0x100 laser based position
        MAV_SYS_STATUS_SENSOR_EXTERNAL_GROUND_TRUTH (512) %0x200 external ground truth (Vicon or Leica)
        MAV_SYS_STATUS_SENSOR_ANGULAR_RATE_CONTROL (1024) %0x400 3D angular rate control
        MAV_SYS_STATUS_SENSOR_ATTITUDE_STABILIZATION (2048) %0x800 attitude stabilization
        MAV_SYS_STATUS_SENSOR_YAW_POSITION (4096) %0x1000 yaw position
        MAV_SYS_STATUS_SENSOR_Z_ALTITUDE_CONTROL (8192) %0x2000 z/altitude control
        MAV_SYS_STATUS_SENSOR_XY_POSITION_CONTROL (16384) %0x4000 x/y position control
        MAV_SYS_STATUS_SENSOR_MOTOR_OUTPUTS (32768) %0x8000 motor outputs / control
        MAV_SYS_STATUS_SENSOR_RC_RECEIVER (65536) %0x10000 rc receiver
        MAV_SYS_STATUS_SENSOR_3D_GYRO2 (131072) %0x20000 2nd 3D gyro
        MAV_SYS_STATUS_SENSOR_3D_ACCEL2 (262144) %0x40000 2nd 3D accelerometer
        MAV_SYS_STATUS_SENSOR_3D_MAG2 (524288) %0x80000 2nd 3D magnetometer
        MAV_SYS_STATUS_GEOFENCE (1048576) %0x100000 geofence
        MAV_SYS_STATUS_AHRS (2097152) %0x200000 AHRS subsystem health
        MAV_SYS_STATUS_TERRAIN (4194304) %0x400000 Terrain subsystem health
        MAV_SYS_STATUS_REVERSE_MOTOR (8388608) %0x800000 Motors are reversed
        MAV_SYS_STATUS_LOGGING (16777216) %0x1000000 Logging
        MAV_FRAME_GLOBAL (0) %Global coordinate frame, WGS84 coordinate system. First value / x: latitude, second value / y: longitude, third value / z: positive altitude over mean sea level (MSL)
        MAV_FRAME_LOCAL_NED (1) %Local coordinate frame, Z-up (x: north, y: east, z: down).
        MAV_FRAME_MISSION (2) %NOT a coordinate frame, indicates a mission command.
        MAV_FRAME_GLOBAL_RELATIVE_ALT (3) %Global coordinate frame, WGS84 coordinate system, relative altitude over ground with respect to the home position. First value / x: latitude, second value / y: longitude, third value / z: positive altitude with 0 being at the altitude of the home location.
        MAV_FRAME_LOCAL_ENU (4) %Local coordinate frame, Z-down (x: east, y: north, z: up)
        MAV_FRAME_GLOBAL_INT (5) %Global coordinate frame, WGS84 coordinate system. First value / x: latitude in degrees*1.0e-7, second value / y: longitude in degrees*1.0e-7, third value / z: positive altitude over mean sea level (MSL)
        MAV_FRAME_GLOBAL_RELATIVE_ALT_INT (6) %Global coordinate frame, WGS84 coordinate system, relative altitude over ground with respect to the home position. First value / x: latitude in degrees*10e-7, second value / y: longitude in degrees*10e-7, third value / z: positive altitude with 0 being at the altitude of the home location.
        MAV_FRAME_LOCAL_OFFSET_NED (7) %Offset to the current local frame. Anything expressed in this frame should be added to the current local frame position.
        MAV_FRAME_BODY_NED (8) %Setpoint in body NED frame. This makes sense if all position control is externalized - e.g. useful to command 2 m/s^2 acceleration to the right.
        MAV_FRAME_BODY_OFFSET_NED (9) %Offset in body NED frame. This makes sense if adding setpoints to the current flight path, to avoid an obstacle - e.g. useful to command 2 m/s^2 acceleration to the east.
        MAV_FRAME_GLOBAL_TERRAIN_ALT (10) %Global coordinate frame with above terrain level altitude. WGS84 coordinate system, relative altitude over terrain with respect to the waypoint coordinate. First value / x: latitude in degrees, second value / y: longitude in degrees, third value / z: positive altitude in meters with 0 being at ground level in terrain model.
        MAV_FRAME_GLOBAL_TERRAIN_ALT_INT (11) %Global coordinate frame with above terrain level altitude. WGS84 coordinate system, relative altitude over terrain with respect to the waypoint coordinate. First value / x: latitude in degrees*10e-7, second value / y: longitude in degrees*10e-7, third value / z: positive altitude in meters with 0 being at ground level in terrain model.
        MAVLINK_DATA_STREAM_IMG_JPEG (0) %No description available
        MAVLINK_DATA_STREAM_IMG_BMP (1) %No description available
        MAVLINK_DATA_STREAM_IMG_RAW8U (2) %No description available
        MAVLINK_DATA_STREAM_IMG_RAW32U (3) %No description available
        MAVLINK_DATA_STREAM_IMG_PGM (4) %No description available
        MAVLINK_DATA_STREAM_IMG_PNG (5) %No description available
        FENCE_ACTION_NONE (0) %Disable fenced mode
        FENCE_ACTION_GUIDED (1) %Switched to guided mode to return point (fence point 0)
        FENCE_ACTION_REPORT (2) %Report fence breach, but don't take action
        FENCE_ACTION_GUIDED_THR_PASS (3) %Switched to guided mode to return point (fence point 0) with manual throttle control
        FENCE_ACTION_RTL (4) %Switch to RTL (return to launch) mode and head for the return point.
        FENCE_BREACH_NONE (0) %No last fence breach
        FENCE_BREACH_MINALT (1) %Breached minimum altitude
        FENCE_BREACH_MAXALT (2) %Breached maximum altitude
        FENCE_BREACH_BOUNDARY (3) %Breached fence boundary
        MAV_MOUNT_MODE_RETRACT (0) %Load and keep safe position (Roll,Pitch,Yaw) from permant memory and stop stabilization
        MAV_MOUNT_MODE_NEUTRAL (1) %Load and keep neutral position (Roll,Pitch,Yaw) from permanent memory.
        MAV_MOUNT_MODE_MAVLINK_TARGETING (2) %Load neutral position and start MAVLink Roll,Pitch,Yaw control with stabilization
        MAV_MOUNT_MODE_RC_TARGETING (3) %Load neutral position and start RC Roll,Pitch,Yaw control with stabilization
        MAV_MOUNT_MODE_GPS_POINT (4) %Load neutral position and start to point to Lat,Lon,Alt
        MAV_CMD_NAV_WAYPOINT (16) %Navigate to MISSION.
        MAV_CMD_NAV_LOITER_UNLIM (17) %Loiter around this MISSION an unlimited amount of time
        MAV_CMD_NAV_LOITER_TURNS (18) %Loiter around this MISSION for X turns
        MAV_CMD_NAV_LOITER_TIME (19) %Loiter around this MISSION for X seconds
        MAV_CMD_NAV_RETURN_TO_LAUNCH (20) %Return to launch location
        MAV_CMD_NAV_LAND (21) %Land at location
        MAV_CMD_NAV_TAKEOFF (22) %Takeoff from ground / hand
        MAV_CMD_NAV_LAND_LOCAL (23) %Land at local position (local frame only)
        MAV_CMD_NAV_TAKEOFF_LOCAL (24) %Takeoff from local position (local frame only)
        MAV_CMD_NAV_FOLLOW (25) %Vehicle following, i.e. this waypoint represents the position of a moving vehicle
        MAV_CMD_NAV_CONTINUE_AND_CHANGE_ALT (30) %Continue on the current course and climb/descend to specified altitude.  When the altitude is reached continue to the next command (i.e., don't proceed to the next command until the desired altitude is reached.
        MAV_CMD_NAV_LOITER_TO_ALT (31) %Begin loiter at the specified Latitude and Longitude.  If Lat=Lon=0, then loiter at the current position.  Don't consider the navigation command complete (don't leave loiter) until the altitude has been reached.  Additionally, if the Heading Required parameter is non-zero the  aircraft will not leave the loiter until heading toward the next waypoint.
        MAV_CMD_DO_FOLLOW (32) %Being following a target
        MAV_CMD_DO_FOLLOW_REPOSITION (33) %Reposition the MAV after a follow target command has been sent
        MAV_CMD_NAV_ROI (80) %Sets the region of interest (ROI) for a sensor set or the vehicle itself. This can then be used by the vehicles control system to control the vehicle attitude and the attitude of various sensors such as cameras.
        MAV_CMD_NAV_PATHPLANNING (81) %Control autonomous path planning on the MAV.
        MAV_CMD_NAV_SPLINE_WAYPOINT (82) %Navigate to MISSION using a spline path.
        MAV_CMD_NAV_VTOL_TAKEOFF (84) %Takeoff from ground using VTOL mode
        MAV_CMD_NAV_VTOL_LAND (85) %Land using VTOL mode
        MAV_CMD_NAV_GUIDED_ENABLE (92) %hand control over to an external controller
        MAV_CMD_NAV_DELAY (93) %Delay the next navigation command a number of seconds or until a specified time
        MAV_CMD_NAV_LAST (95) %NOP - This command is only used to mark the upper limit of the NAV/ACTION commands in the enumeration
        MAV_CMD_CONDITION_DELAY (112) %Delay mission state machine.
        MAV_CMD_CONDITION_CHANGE_ALT (113) %Ascend/descend at rate.  Delay mission state machine until desired altitude reached.
        MAV_CMD_CONDITION_DISTANCE (114) %Delay mission state machine until within desired distance of next NAV point.
        MAV_CMD_CONDITION_YAW (115) %Reach a certain target angle.
        MAV_CMD_CONDITION_LAST (159) %NOP - This command is only used to mark the upper limit of the CONDITION commands in the enumeration
        MAV_CMD_DO_SET_MODE (176) %Set system mode.
        MAV_CMD_DO_JUMP (177) %Jump to the desired command in the mission list.  Repeat this action only the specified number of times
        MAV_CMD_DO_CHANGE_SPEED (178) %Change speed and/or throttle set points.
        MAV_CMD_DO_SET_HOME (179) %Changes the home location either to the current location or a specified location.
        MAV_CMD_DO_SET_PARAMETER (180) %Set a system parameter.  Caution!  Use of this command requires knowledge of the numeric enumeration value of the parameter.
        MAV_CMD_DO_SET_RELAY (181) %Set a relay to a condition.
        MAV_CMD_DO_REPEAT_RELAY (182) %Cycle a relay on and off for a desired number of cyles with a desired period.
        MAV_CMD_DO_SET_SERVO (183) %Set a servo to a desired PWM value.
        MAV_CMD_DO_REPEAT_SERVO (184) %Cycle a between its nominal setting and a desired PWM for a desired number of cycles with a desired period.
        MAV_CMD_DO_FLIGHTTERMINATION (185) %Terminate flight immediately
        MAV_CMD_DO_CHANGE_ALTITUDE (186) %Change altitude set point.
        MAV_CMD_DO_LAND_START (189) %Mission command to perform a landing. This is used as a marker in a mission to tell the autopilot where a sequence of mission items that represents a landing starts. It may also be sent via a COMMAND_LONG to trigger a landing, in which case the nearest (geographically) landing sequence in the mission will be used. The Latitude/Longitude is optional, and may be set to 0/0 if not needed. If specified then it will be used to help find the closest landing sequence.
        MAV_CMD_DO_RALLY_LAND (190) %Mission command to perform a landing from a rally point.
        MAV_CMD_DO_GO_AROUND (191) %Mission command to safely abort an autonmous landing.
        MAV_CMD_DO_REPOSITION (192) %Reposition the vehicle to a specific WGS84 global position.
        MAV_CMD_DO_PAUSE_CONTINUE (193) %If in a GPS controlled position mode, hold the current position or continue.
        MAV_CMD_DO_SET_REVERSE (194) %Set moving direction to forward or reverse.
        MAV_CMD_DO_CONTROL_VIDEO (200) %Control onboard camera system.
        MAV_CMD_DO_SET_ROI (201) %Sets the region of interest (ROI) for a sensor set or the vehicle itself. This can then be used by the vehicles control system to control the vehicle attitude and the attitude of various sensors such as cameras.
        MAV_CMD_DO_DIGICAM_CONFIGURE (202) %Mission command to configure an on-board camera controller system.
        MAV_CMD_DO_DIGICAM_CONTROL (203) %Mission command to control an on-board camera controller system.
        MAV_CMD_DO_MOUNT_CONFIGURE (204) %Mission command to configure a camera or antenna mount
        MAV_CMD_DO_MOUNT_CONTROL (205) %Mission command to control a camera or antenna mount
        MAV_CMD_DO_SET_CAM_TRIGG_DIST (206) %Mission command to set CAM_TRIGG_DIST for this flight
        MAV_CMD_DO_FENCE_ENABLE (207) %Mission command to enable the geofence
        MAV_CMD_DO_PARACHUTE (208) %Mission command to trigger a parachute
        MAV_CMD_DO_MOTOR_TEST (209) %Mission command to perform motor test
        MAV_CMD_DO_INVERTED_FLIGHT (210) %Change to/from inverted flight
        MAV_CMD_NAV_SET_YAW_SPEED (213) %Sets a desired vehicle turn angle and speed change
        MAV_CMD_DO_MOUNT_CONTROL_QUAT (220) %Mission command to control a camera or antenna mount, using a quaternion as reference.
        MAV_CMD_DO_GUIDED_MASTER (221) %set id of master controller
        MAV_CMD_DO_GUIDED_LIMITS (222) %set limits for external control
        MAV_CMD_DO_ENGINE_CONTROL (223) %Control vehicle engine. This is interpreted by the vehicles engine controller to change the target engine state. It is intended for vehicles with internal combustion engines
        MAV_CMD_DO_LAST (240) %NOP - This command is only used to mark the upper limit of the DO commands in the enumeration
        MAV_CMD_PREFLIGHT_CALIBRATION (241) %Trigger calibration. This command will be only accepted if in pre-flight mode.
        MAV_CMD_PREFLIGHT_SET_SENSOR_OFFSETS (242) %Set sensor offsets. This command will be only accepted if in pre-flight mode.
        MAV_CMD_PREFLIGHT_UAVCAN (243) %Trigger UAVCAN config. This command will be only accepted if in pre-flight mode.
        MAV_CMD_PREFLIGHT_STORAGE (245) %Request storage of different parameter values and logs. This command will be only accepted if in pre-flight mode.
        MAV_CMD_PREFLIGHT_REBOOT_SHUTDOWN (246) %Request the reboot or shutdown of system components.
        MAV_CMD_OVERRIDE_GOTO (252) %Hold / continue the current action
        MAV_CMD_MISSION_START (300) %start running a mission
        MAV_CMD_COMPONENT_ARM_DISARM (400) %Arms / Disarms a component
        MAV_CMD_GET_HOME_POSITION (410) %Request the home position from the vehicle.
        MAV_CMD_START_RX_PAIR (500) %Starts receiver pairing
        MAV_CMD_GET_MESSAGE_INTERVAL (510) %Request the interval between messages for a particular MAVLink message ID
        MAV_CMD_SET_MESSAGE_INTERVAL (511) %Request the interval between messages for a particular MAVLink message ID. This interface replaces REQUEST_DATA_STREAM
        MAV_CMD_REQUEST_AUTOPILOT_CAPABILITIES (520) %Request autopilot capabilities
        MAV_CMD_REQUEST_CAMERA_INFORMATION (521) %WIP: Request camera information (CAMERA_INFORMATION)
        MAV_CMD_REQUEST_CAMERA_SETTINGS (522) %WIP: Request camera settings (CAMERA_SETTINGS)
        MAV_CMD_SET_CAMERA_SETTINGS_1 (523) %WIP: Set the camera settings part 1 (CAMERA_SETTINGS)
        MAV_CMD_SET_CAMERA_SETTINGS_2 (524) %WIP: Set the camera settings part 2 (CAMERA_SETTINGS)
        MAV_CMD_REQUEST_STORAGE_INFORMATION (525) %WIP: Request storage information (STORAGE_INFORMATION)
        MAV_CMD_STORAGE_FORMAT (526) %WIP: Format a storage medium
        MAV_CMD_REQUEST_CAMERA_CAPTURE_STATUS (527) %WIP: Request camera capture status (CAMERA_CAPTURE_STATUS)
        MAV_CMD_REQUEST_FLIGHT_INFORMATION (528) %WIP: Request flight information (FLIGHT_INFORMATION)
        MAV_CMD_IMAGE_START_CAPTURE (2000) %Start image capture sequence
        MAV_CMD_IMAGE_STOP_CAPTURE (2001) %Stop image capture sequence
        MAV_CMD_DO_TRIGGER_CONTROL (2003) %Enable or disable on-board camera triggering system.
        MAV_CMD_VIDEO_START_CAPTURE (2500) %Starts video capture
        MAV_CMD_VIDEO_STOP_CAPTURE (2501) %Stop the current video capture
        MAV_CMD_LOGGING_START (2510) %Request to start streaming logging data over MAVLink (see also LOGGING_DATA message)
        MAV_CMD_LOGGING_STOP (2511) %Request to stop streaming log data over MAVLink
        MAV_CMD_AIRFRAME_CONFIGURATION (2520) %No description available
        MAV_CMD_PANORAMA_CREATE (2800) %Create a panorama at the current position
        MAV_CMD_DO_VTOL_TRANSITION (3000) %Request VTOL transition
        MAV_CMD_SET_GUIDED_SUBMODE_STANDARD (4000) %This command sets the submode to standard guided when vehicle is in guided mode. The vehicle holds position and altitude and the user can input the desired velocites along all three axes.
        MAV_CMD_SET_GUIDED_SUBMODE_CIRCLE (4001) %This command sets submode circle when vehicle is in guided mode. Vehicle flies along a circle facing the center of the circle. The user can input the velocity along the circle and change the radius. If no input is given the vehicle will hold position.
        MAV_CMD_PAYLOAD_PREPARE_DEPLOY (30001) %Deploy payload on a Lat / Lon / Alt position. This includes the navigation to reach the required release position and velocity.
        MAV_CMD_PAYLOAD_CONTROL_DEPLOY (30002) %Control the payload deployment.
        MAV_CMD_WAYPOINT_USER_1 (31000) %User defined waypoint item. Ground Station will show the Vehicle as flying through this item.
        MAV_CMD_WAYPOINT_USER_2 (31001) %User defined waypoint item. Ground Station will show the Vehicle as flying through this item.
        MAV_CMD_WAYPOINT_USER_3 (31002) %User defined waypoint item. Ground Station will show the Vehicle as flying through this item.
        MAV_CMD_WAYPOINT_USER_4 (31003) %User defined waypoint item. Ground Station will show the Vehicle as flying through this item.
        MAV_CMD_WAYPOINT_USER_5 (31004) %User defined waypoint item. Ground Station will show the Vehicle as flying through this item.
        MAV_CMD_SPATIAL_USER_1 (31005) %User defined spatial item. Ground Station will not show the Vehicle as flying through this item. Example: ROI item.
        MAV_CMD_SPATIAL_USER_2 (31006) %User defined spatial item. Ground Station will not show the Vehicle as flying through this item. Example: ROI item.
        MAV_CMD_SPATIAL_USER_3 (31007) %User defined spatial item. Ground Station will not show the Vehicle as flying through this item. Example: ROI item.
        MAV_CMD_SPATIAL_USER_4 (31008) %User defined spatial item. Ground Station will not show the Vehicle as flying through this item. Example: ROI item.
        MAV_CMD_SPATIAL_USER_5 (31009) %User defined spatial item. Ground Station will not show the Vehicle as flying through this item. Example: ROI item.
        MAV_CMD_USER_1 (31010) %User defined command. Ground Station will not show the Vehicle as flying through this item. Example: MAV_CMD_DO_SET_PARAMETER item.
        MAV_CMD_USER_2 (31011) %User defined command. Ground Station will not show the Vehicle as flying through this item. Example: MAV_CMD_DO_SET_PARAMETER item.
        MAV_CMD_USER_3 (31012) %User defined command. Ground Station will not show the Vehicle as flying through this item. Example: MAV_CMD_DO_SET_PARAMETER item.
        MAV_CMD_USER_4 (31013) %User defined command. Ground Station will not show the Vehicle as flying through this item. Example: MAV_CMD_DO_SET_PARAMETER item.
        MAV_CMD_USER_5 (31014) %User defined command. Ground Station will not show the Vehicle as flying through this item. Example: MAV_CMD_DO_SET_PARAMETER item.
        MAV_DATA_STREAM_ALL (0) %Enable all data streams
        MAV_DATA_STREAM_RAW_SENSORS (1) %Enable IMU_RAW, GPS_RAW, GPS_STATUS packets.
        MAV_DATA_STREAM_EXTENDED_STATUS (2) %Enable GPS_STATUS, CONTROL_STATUS, AUX_STATUS
        MAV_DATA_STREAM_RC_CHANNELS (3) %Enable RC_CHANNELS_SCALED, RC_CHANNELS_RAW, SERVO_OUTPUT_RAW
        MAV_DATA_STREAM_RAW_CONTROLLER (4) %Enable ATTITUDE_CONTROLLER_OUTPUT, POSITION_CONTROLLER_OUTPUT, NAV_CONTROLLER_OUTPUT.
        MAV_DATA_STREAM_POSITION (6) %Enable LOCAL_POSITION, GLOBAL_POSITION/GLOBAL_POSITION_INT messages.
        MAV_DATA_STREAM_EXTRA1 (10) %Dependent on the autopilot
        MAV_DATA_STREAM_EXTRA2 (11) %Dependent on the autopilot
        MAV_DATA_STREAM_EXTRA3 (12) %Dependent on the autopilot
        MAV_ROI_NONE (0) %No region of interest.
        MAV_ROI_WPNEXT (1) %Point toward next MISSION.
        MAV_ROI_WPINDEX (2) %Point toward given MISSION.
        MAV_ROI_LOCATION (3) %Point toward fixed location.
        MAV_ROI_TARGET (4) %Point toward of given id.
        MAV_CMD_ACK_OK (0) %Command / mission item is ok.
        MAV_CMD_ACK_ERR_FAIL (1) %Generic error message if none of the other reasons fails or if no detailed error reporting is implemented.
        MAV_CMD_ACK_ERR_ACCESS_DENIED (2) %The system is refusing to accept this command from this source / communication partner.
        MAV_CMD_ACK_ERR_NOT_SUPPORTED (3) %Command or mission item is not supported, other commands would be accepted.
        MAV_CMD_ACK_ERR_COORDINATE_FRAME_NOT_SUPPORTED (4) %The coordinate frame of this command / mission item is not supported.
        MAV_CMD_ACK_ERR_COORDINATES_OUT_OF_RANGE (5) %The coordinate frame of this command is ok, but he coordinate values exceed the safety limits of this system. This is a generic error, please use the more specific error messages below if possible.
        MAV_CMD_ACK_ERR_X_LAT_OUT_OF_RANGE (6) %The X or latitude value is out of range.
        MAV_CMD_ACK_ERR_Y_LON_OUT_OF_RANGE (7) %The Y or longitude value is out of range.
        MAV_CMD_ACK_ERR_Z_ALT_OUT_OF_RANGE (8) %The Z or altitude value is out of range.
        MAV_PARAM_TYPE_UINT8 (1) %8-bit unsigned integer
        MAV_PARAM_TYPE_INT8 (2) %8-bit signed integer
        MAV_PARAM_TYPE_UINT16 (3) %16-bit unsigned integer
        MAV_PARAM_TYPE_INT16 (4) %16-bit signed integer
        MAV_PARAM_TYPE_UINT32 (5) %32-bit unsigned integer
        MAV_PARAM_TYPE_INT32 (6) %32-bit signed integer
        MAV_PARAM_TYPE_UINT64 (7) %64-bit unsigned integer
        MAV_PARAM_TYPE_INT64 (8) %64-bit signed integer
        MAV_PARAM_TYPE_REAL32 (9) %32-bit floating-point
        MAV_PARAM_TYPE_REAL64 (10) %64-bit floating-point
        MAV_RESULT_ACCEPTED (0) %Command ACCEPTED and EXECUTED
        MAV_RESULT_TEMPORARILY_REJECTED (1) %Command TEMPORARY REJECTED/DENIED
        MAV_RESULT_DENIED (2) %Command PERMANENTLY DENIED
        MAV_RESULT_UNSUPPORTED (3) %Command UNKNOWN/UNSUPPORTED
        MAV_RESULT_FAILED (4) %Command executed, but failed
        MAV_MISSION_ACCEPTED (0) %mission accepted OK
        MAV_MISSION_ERROR (1) %generic error / not accepting mission commands at all right now
        MAV_MISSION_UNSUPPORTED_FRAME (2) %coordinate frame is not supported
        MAV_MISSION_UNSUPPORTED (3) %command is not supported
        MAV_MISSION_NO_SPACE (4) %mission item exceeds storage space
        MAV_MISSION_INVALID (5) %one of the parameters has an invalid value
        MAV_MISSION_INVALID_PARAM1 (6) %param1 has an invalid value
        MAV_MISSION_INVALID_PARAM2 (7) %param2 has an invalid value
        MAV_MISSION_INVALID_PARAM3 (8) %param3 has an invalid value
        MAV_MISSION_INVALID_PARAM4 (9) %param4 has an invalid value
        MAV_MISSION_INVALID_PARAM5_X (10) %x/param5 has an invalid value
        MAV_MISSION_INVALID_PARAM6_Y (11) %y/param6 has an invalid value
        MAV_MISSION_INVALID_PARAM7 (12) %param7 has an invalid value
        MAV_MISSION_INVALID_SEQUENCE (13) %received waypoint out of sequence
        MAV_MISSION_DENIED (14) %not accepting any mission commands from this communication partner
        MAV_SEVERITY_EMERGENCY (0) %System is unusable. This is a "panic" condition.
        MAV_SEVERITY_ALERT (1) %Action should be taken immediately. Indicates error in non-critical systems.
        MAV_SEVERITY_CRITICAL (2) %Action must be taken immediately. Indicates failure in a primary system.
        MAV_SEVERITY_ERROR (3) %Indicates an error in secondary/redundant systems.
        MAV_SEVERITY_WARNING (4) %Indicates about a possible future error if this is not resolved within a given timeframe. Example would be a low battery warning.
        MAV_SEVERITY_NOTICE (5) %An unusual event has occured, though not an error condition. This should be investigated for the root cause.
        MAV_SEVERITY_INFO (6) %Normal operational messages. Useful for logging. No action is required for these messages.
        MAV_SEVERITY_DEBUG (7) %Useful non-operational messages that can assist in debugging. These should not occur during normal operation.
        MAV_POWER_STATUS_BRICK_VALID (1) %main brick power supply valid
        MAV_POWER_STATUS_SERVO_VALID (2) %main servo power supply valid for FMU
        MAV_POWER_STATUS_USB_CONNECTED (4) %USB power is connected
        MAV_POWER_STATUS_PERIPH_OVERCURRENT (8) %peripheral supply is in over-current state
        MAV_POWER_STATUS_PERIPH_HIPOWER_OVERCURRENT (16) %hi-power peripheral supply is in over-current state
        MAV_POWER_STATUS_CHANGED (32) %Power status has changed since boot
        SERIAL_CONTROL_DEV_TELEM1 (0) %First telemetry port
        SERIAL_CONTROL_DEV_TELEM2 (1) %Second telemetry port
        SERIAL_CONTROL_DEV_GPS1 (2) %First GPS port
        SERIAL_CONTROL_DEV_GPS2 (3) %Second GPS port
        SERIAL_CONTROL_DEV_SHELL (10) %system shell
        SERIAL_CONTROL_FLAG_REPLY (1) %Set if this is a reply
        SERIAL_CONTROL_FLAG_RESPOND (2) %Set if the sender wants the receiver to send a response as another SERIAL_CONTROL message
        SERIAL_CONTROL_FLAG_EXCLUSIVE (4) %Set if access to the serial port should be removed from whatever driver is currently using it, giving exclusive access to the SERIAL_CONTROL protocol. The port can be handed back by sending a request without this flag set
        SERIAL_CONTROL_FLAG_BLOCKING (8) %Block on writes to the serial port
        SERIAL_CONTROL_FLAG_MULTI (16) %Send multiple replies until port is drained
        MAV_DISTANCE_SENSOR_LASER (0) %Laser rangefinder, e.g. LightWare SF02/F or PulsedLight units
        MAV_DISTANCE_SENSOR_ULTRASOUND (1) %Ultrasound rangefinder, e.g. MaxBotix units
        MAV_DISTANCE_SENSOR_INFRARED (2) %Infrared rangefinder, e.g. Sharp units
        MAV_SENSOR_ROTATION_NONE (0) %Roll: 0, Pitch: 0, Yaw: 0
        MAV_SENSOR_ROTATION_YAW_45 (1) %Roll: 0, Pitch: 0, Yaw: 45
        MAV_SENSOR_ROTATION_YAW_90 (2) %Roll: 0, Pitch: 0, Yaw: 90
        MAV_SENSOR_ROTATION_YAW_135 (3) %Roll: 0, Pitch: 0, Yaw: 135
        MAV_SENSOR_ROTATION_YAW_180 (4) %Roll: 0, Pitch: 0, Yaw: 180
        MAV_SENSOR_ROTATION_YAW_225 (5) %Roll: 0, Pitch: 0, Yaw: 225
        MAV_SENSOR_ROTATION_YAW_270 (6) %Roll: 0, Pitch: 0, Yaw: 270
        MAV_SENSOR_ROTATION_YAW_315 (7) %Roll: 0, Pitch: 0, Yaw: 315
        MAV_SENSOR_ROTATION_ROLL_180 (8) %Roll: 180, Pitch: 0, Yaw: 0
        MAV_SENSOR_ROTATION_ROLL_180_YAW_45 (9) %Roll: 180, Pitch: 0, Yaw: 45
        MAV_SENSOR_ROTATION_ROLL_180_YAW_90 (10) %Roll: 180, Pitch: 0, Yaw: 90
        MAV_SENSOR_ROTATION_ROLL_180_YAW_135 (11) %Roll: 180, Pitch: 0, Yaw: 135
        MAV_SENSOR_ROTATION_PITCH_180 (12) %Roll: 0, Pitch: 180, Yaw: 0
        MAV_SENSOR_ROTATION_ROLL_180_YAW_225 (13) %Roll: 180, Pitch: 0, Yaw: 225
        MAV_SENSOR_ROTATION_ROLL_180_YAW_270 (14) %Roll: 180, Pitch: 0, Yaw: 270
        MAV_SENSOR_ROTATION_ROLL_180_YAW_315 (15) %Roll: 180, Pitch: 0, Yaw: 315
        MAV_SENSOR_ROTATION_ROLL_90 (16) %Roll: 90, Pitch: 0, Yaw: 0
        MAV_SENSOR_ROTATION_ROLL_90_YAW_45 (17) %Roll: 90, Pitch: 0, Yaw: 45
        MAV_SENSOR_ROTATION_ROLL_90_YAW_90 (18) %Roll: 90, Pitch: 0, Yaw: 90
        MAV_SENSOR_ROTATION_ROLL_90_YAW_135 (19) %Roll: 90, Pitch: 0, Yaw: 135
        MAV_SENSOR_ROTATION_ROLL_270 (20) %Roll: 270, Pitch: 0, Yaw: 0
        MAV_SENSOR_ROTATION_ROLL_270_YAW_45 (21) %Roll: 270, Pitch: 0, Yaw: 45
        MAV_SENSOR_ROTATION_ROLL_270_YAW_90 (22) %Roll: 270, Pitch: 0, Yaw: 90
        MAV_SENSOR_ROTATION_ROLL_270_YAW_135 (23) %Roll: 270, Pitch: 0, Yaw: 135
        MAV_SENSOR_ROTATION_PITCH_90 (24) %Roll: 0, Pitch: 90, Yaw: 0
        MAV_SENSOR_ROTATION_PITCH_270 (25) %Roll: 0, Pitch: 270, Yaw: 0
        MAV_SENSOR_ROTATION_PITCH_180_YAW_90 (26) %Roll: 0, Pitch: 180, Yaw: 90
        MAV_SENSOR_ROTATION_PITCH_180_YAW_270 (27) %Roll: 0, Pitch: 180, Yaw: 270
        MAV_SENSOR_ROTATION_ROLL_90_PITCH_90 (28) %Roll: 90, Pitch: 90, Yaw: 0
        MAV_SENSOR_ROTATION_ROLL_180_PITCH_90 (29) %Roll: 180, Pitch: 90, Yaw: 0
        MAV_SENSOR_ROTATION_ROLL_270_PITCH_90 (30) %Roll: 270, Pitch: 90, Yaw: 0
        MAV_SENSOR_ROTATION_ROLL_90_PITCH_180 (31) %Roll: 90, Pitch: 180, Yaw: 0
        MAV_SENSOR_ROTATION_ROLL_270_PITCH_180 (32) %Roll: 270, Pitch: 180, Yaw: 0
        MAV_SENSOR_ROTATION_ROLL_90_PITCH_270 (33) %Roll: 90, Pitch: 270, Yaw: 0
        MAV_SENSOR_ROTATION_ROLL_180_PITCH_270 (34) %Roll: 180, Pitch: 270, Yaw: 0
        MAV_SENSOR_ROTATION_ROLL_270_PITCH_270 (35) %Roll: 270, Pitch: 270, Yaw: 0
        MAV_SENSOR_ROTATION_ROLL_90_PITCH_180_YAW_90 (36) %Roll: 90, Pitch: 180, Yaw: 90
        MAV_SENSOR_ROTATION_ROLL_90_YAW_270 (37) %Roll: 90, Pitch: 0, Yaw: 270
        MAV_SENSOR_ROTATION_ROLL_315_PITCH_315_YAW_315 (38) %Roll: 315, Pitch: 315, Yaw: 315
        MAV_PROTOCOL_CAPABILITY_MISSION_FLOAT (1) %Autopilot supports MISSION float message type.
        MAV_PROTOCOL_CAPABILITY_PARAM_FLOAT (2) %Autopilot supports the new param float message type.
        MAV_PROTOCOL_CAPABILITY_MISSION_INT (4) %Autopilot supports MISSION_INT scaled integer message type.
        MAV_PROTOCOL_CAPABILITY_COMMAND_INT (8) %Autopilot supports COMMAND_INT scaled integer message type.
        MAV_PROTOCOL_CAPABILITY_PARAM_UNION (16) %Autopilot supports the new param union message type.
        MAV_PROTOCOL_CAPABILITY_FTP (32) %Autopilot supports the new FILE_TRANSFER_PROTOCOL message type.
        MAV_PROTOCOL_CAPABILITY_SET_ATTITUDE_TARGET (64) %Autopilot supports commanding attitude offboard.
        MAV_PROTOCOL_CAPABILITY_SET_POSITION_TARGET_LOCAL_NED (128) %Autopilot supports commanding position and velocity targets in local NED frame.
        MAV_PROTOCOL_CAPABILITY_SET_POSITION_TARGET_GLOBAL_INT (256) %Autopilot supports commanding position and velocity targets in global scaled integers.
        MAV_PROTOCOL_CAPABILITY_TERRAIN (512) %Autopilot supports terrain protocol / data handling.
        MAV_PROTOCOL_CAPABILITY_SET_ACTUATOR_TARGET (1024) %Autopilot supports direct actuator control.
        MAV_PROTOCOL_CAPABILITY_FLIGHT_TERMINATION (2048) %Autopilot supports the flight termination command.
        MAV_PROTOCOL_CAPABILITY_COMPASS_CALIBRATION (4096) %Autopilot supports onboard compass calibration.
        MAV_PROTOCOL_CAPABILITY_MAVLINK2 (8192) %Autopilot supports mavlink version 2.
        MAV_ESTIMATOR_TYPE_NAIVE (1) %This is a naive estimator without any real covariance feedback.
        MAV_ESTIMATOR_TYPE_VISION (2) %Computer vision based estimate. Might be up to scale.
        MAV_ESTIMATOR_TYPE_VIO (3) %Visual-inertial estimate.
        MAV_ESTIMATOR_TYPE_GPS (4) %Plain GPS estimate.
        MAV_ESTIMATOR_TYPE_GPS_INS (5) %Estimator integrating GPS and inertial sensing.
        MAV_BATTERY_TYPE_UNKNOWN (0) %Not specified.
        MAV_BATTERY_TYPE_LIPO (1) %Lithium polymer battery
        MAV_BATTERY_TYPE_LIFE (2) %Lithium-iron-phosphate battery
        MAV_BATTERY_TYPE_LION (3) %Lithium-ION battery
        MAV_BATTERY_TYPE_NIMH (4) %Nickel metal hydride battery
        MAV_BATTERY_FUNCTION_UNKNOWN (0) %Battery function is unknown
        MAV_BATTERY_FUNCTION_ALL (1) %Battery supports all flight systems
        MAV_BATTERY_FUNCTION_PROPULSION (2) %Battery for the propulsion system
        MAV_BATTERY_FUNCTION_AVIONICS (3) %Avionics battery
        MAV_BATTERY_TYPE_PAYLOAD (4) %Payload battery
        MAV_VTOL_STATE_UNDEFINED (0) %MAV is not configured as VTOL
        MAV_VTOL_STATE_TRANSITION_TO_FW (1) %VTOL is in transition from multicopter to fixed-wing
        MAV_VTOL_STATE_TRANSITION_TO_MC (2) %VTOL is in transition from fixed-wing to multicopter
        MAV_VTOL_STATE_MC (3) %VTOL is in multicopter state
        MAV_VTOL_STATE_FW (4) %VTOL is in fixed-wing state
        MAV_LANDED_STATE_UNDEFINED (0) %MAV landed state is unknown
        MAV_LANDED_STATE_ON_GROUND (1) %MAV is landed (on ground)
        MAV_LANDED_STATE_IN_AIR (2) %MAV is in air
        ADSB_ALTITUDE_TYPE_PRESSURE_QNH (0) %Altitude reported from a Baro source using QNH reference
        ADSB_ALTITUDE_TYPE_GEOMETRIC (1) %Altitude reported from a GNSS source
        ADSB_EMITTER_TYPE_NO_INFO (0) %No description available
        ADSB_EMITTER_TYPE_LIGHT (1) %No description available
        ADSB_EMITTER_TYPE_SMALL (2) %No description available
        ADSB_EMITTER_TYPE_LARGE (3) %No description available
        ADSB_EMITTER_TYPE_HIGH_VORTEX_LARGE (4) %No description available
        ADSB_EMITTER_TYPE_HEAVY (5) %No description available
        ADSB_EMITTER_TYPE_HIGHLY_MANUV (6) %No description available
        ADSB_EMITTER_TYPE_ROTOCRAFT (7) %No description available
        ADSB_EMITTER_TYPE_UNASSIGNED (8) %No description available
        ADSB_EMITTER_TYPE_GLIDER (9) %No description available
        ADSB_EMITTER_TYPE_LIGHTER_AIR (10) %No description available
        ADSB_EMITTER_TYPE_PARACHUTE (11) %No description available
        ADSB_EMITTER_TYPE_ULTRA_LIGHT (12) %No description available
        ADSB_EMITTER_TYPE_UNASSIGNED2 (13) %No description available
        ADSB_EMITTER_TYPE_UAV (14) %No description available
        ADSB_EMITTER_TYPE_SPACE (15) %No description available
        ADSB_EMITTER_TYPE_UNASSGINED3 (16) %No description available
        ADSB_EMITTER_TYPE_EMERGENCY_SURFACE (17) %No description available
        ADSB_EMITTER_TYPE_SERVICE_SURFACE (18) %No description available
        ADSB_EMITTER_TYPE_POINT_OBSTACLE (19) %No description available
        ADSB_FLAGS_VALID_COORDS (1) %No description available
        ADSB_FLAGS_VALID_ALTITUDE (2) %No description available
        ADSB_FLAGS_VALID_HEADING (4) %No description available
        ADSB_FLAGS_VALID_VELOCITY (8) %No description available
        ADSB_FLAGS_VALID_CALLSIGN (16) %No description available
        ADSB_FLAGS_VALID_SQUAWK (32) %No description available
        ADSB_FLAGS_SIMULATED (64) %No description available
        MAV_DO_REPOSITION_FLAGS_CHANGE_MODE (1) %The aircraft should immediately transition into guided. This should not be set for follow me applications
        ESTIMATOR_ATTITUDE (1) %True if the attitude estimate is good
        ESTIMATOR_VELOCITY_HORIZ (2) %True if the horizontal velocity estimate is good
        ESTIMATOR_VELOCITY_VERT (4) %True if the  vertical velocity estimate is good
        ESTIMATOR_POS_HORIZ_REL (8) %True if the horizontal position (relative) estimate is good
        ESTIMATOR_POS_HORIZ_ABS (16) %True if the horizontal position (absolute) estimate is good
        ESTIMATOR_POS_VERT_ABS (32) %True if the vertical position (absolute) estimate is good
        ESTIMATOR_POS_VERT_AGL (64) %True if the vertical position (above ground) estimate is good
        ESTIMATOR_CONST_POS_MODE (128) %True if the EKF is in a constant position mode and is not using external measurements (eg GPS or optical flow)
        ESTIMATOR_PRED_POS_HORIZ_REL (256) %True if the EKF has sufficient data to enter a mode that will provide a (relative) position estimate
        ESTIMATOR_PRED_POS_HORIZ_ABS (512) %True if the EKF has sufficient data to enter a mode that will provide a (absolute) position estimate
        ESTIMATOR_GPS_GLITCH (1024) %True if the EKF has detected a GPS glitch
        MOTOR_TEST_THROTTLE_PERCENT (0) %throttle as a percentage from 0 ~ 100
        MOTOR_TEST_THROTTLE_PWM (1) %throttle as an absolute PWM value (normally in range of 1000~2000)
        MOTOR_TEST_THROTTLE_PILOT (2) %throttle pass-through from pilot's transmitter
        GPS_INPUT_IGNORE_FLAG_ALT (1) %ignore altitude field
        GPS_INPUT_IGNORE_FLAG_HDOP (2) %ignore hdop field
        GPS_INPUT_IGNORE_FLAG_VDOP (4) %ignore vdop field
        GPS_INPUT_IGNORE_FLAG_VEL_HORIZ (8) %ignore horizontal velocity field (vn and ve)
        GPS_INPUT_IGNORE_FLAG_VEL_VERT (16) %ignore vertical velocity field (vd)
        GPS_INPUT_IGNORE_FLAG_SPEED_ACCURACY (32) %ignore speed accuracy field
        GPS_INPUT_IGNORE_FLAG_HORIZONTAL_ACCURACY (64) %ignore horizontal accuracy field
        GPS_INPUT_IGNORE_FLAG_VERTICAL_ACCURACY (128) %ignore vertical accuracy field
        MAV_COLLISION_ACTION_NONE (0) %Ignore any potential collisions
        MAV_COLLISION_ACTION_REPORT (1) %Report potential collision
        MAV_COLLISION_ACTION_ASCEND_OR_DESCEND (2) %Ascend or Descend to avoid threat
        MAV_COLLISION_ACTION_MOVE_HORIZONTALLY (3) %Move horizontally to avoid threat
        MAV_COLLISION_ACTION_MOVE_PERPENDICULAR (4) %Aircraft to move perpendicular to the collision's velocity vector
        MAV_COLLISION_ACTION_RTL (5) %Aircraft to fly directly back to its launch point
        MAV_COLLISION_ACTION_HOVER (6) %Aircraft to stop in place
        MAV_COLLISION_THREAT_LEVEL_NONE (0) %Not a threat
        MAV_COLLISION_THREAT_LEVEL_LOW (1) %Craft is mildly concerned about this threat
        MAV_COLLISION_THREAT_LEVEL_HIGH (2) %Craft is panicing, and may take actions to avoid threat
        MAV_COLLISION_SRC_ADSB (0) %ID field references ADSB_VEHICLE packets
        MAV_COLLISION_SRC_MAVLINK_GPS_GLOBAL_INT (1) %ID field references MAVLink SRC ID
        GPS_FIX_TYPE_NO_GPS (0) %No GPS connected
        GPS_FIX_TYPE_NO_FIX (1) %No position information, GPS is connected
        GPS_FIX_TYPE_2D_FIX (2) %2D position
        GPS_FIX_TYPE_3D_FIX (3) %3D position
        GPS_FIX_TYPE_DGPS (4) %DGPS/SBAS aided 3D position
        GPS_FIX_TYPE_RTK_FLOAT (5) %RTK float, 3D position
        GPS_FIX_TYPE_RTK_FIXED (6) %RTK Fixed, 3D position
        GPS_FIX_TYPE_STATIC (7) %Static fixed, typically used for base stations
    end
        
end