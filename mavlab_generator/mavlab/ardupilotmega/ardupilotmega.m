classdef ardupilotmega < uint16
    %ARDUPILOTMEGA: Enumeration class for the 'ardupilotmega' dialect
    
    enumeration 
        MAV_CMD_DO_MOTOR_TEST (209) %Mission command to perform motor test
        MAV_CMD_DO_GRIPPER (211) %Mission command to operate EPM gripper
        MAV_CMD_DO_AUTOTUNE_ENABLE (212) %Enable/disable autotune
        MAV_CMD_NAV_ALTITUDE_WAIT (83) %Mission command to wait for an altitude or downwards vertical speed. This is meant for high altitude balloon launches, allowing the aircraft to be idle until either an altitude is reached or a negative vertical speed is reached (indicating early balloon burst). The wiggle time is how often to wiggle the control surfaces to prevent them seizing up.
        MAV_CMD_DO_START_MAG_CAL (42424) %Initiate a magnetometer calibration
        MAV_CMD_DO_ACCEPT_MAG_CAL (42425) %Initiate a magnetometer calibration
        MAV_CMD_DO_CANCEL_MAG_CAL (42426) %Cancel a running magnetometer calibration
        LIMITS_INIT (0) % pre-initialization
        LIMITS_DISABLED (1) % disabled
        LIMITS_ENABLED (2) % checking limits
        LIMITS_TRIGGERED (3) % a limit has been breached
        LIMITS_RECOVERING (4) % taking action eg. RTL
        LIMITS_RECOVERED (5) % we're no longer in breach of a limit
        LIMIT_GPSLOCK (1) % pre-initialization
        LIMIT_GEOFENCE (2) % disabled
        LIMIT_ALTITUDE (4) % checking limits
        FAVORABLE_WIND (1) %Flag set when requiring favorable winds for landing. 
        LAND_IMMEDIATELY (2) %Flag set when plane is to immediately descend to break altitude and land without GCS intervention.  Flag not set when plane is to loiter at Rally point until commanded to land.
        PARACHUTE_DISABLE (0) %Disable parachute release
        PARACHUTE_ENABLE (1) %Enable parachute release
        PARACHUTE_RELEASE (2) %Release parachute
        MOTOR_TEST_THROTTLE_PERCENT (0) %throttle as a percentage from 0 ~ 100
        MOTOR_TEST_THROTTLE_PWM (1) %throttle as an absolute PWM value (normally in range of 1000~2000)
        MOTOR_TEST_THROTTLE_PILOT (2) %throttle pass-through from pilot's transmitter
        GRIPPER_ACTION_RELEASE (0) %gripper release of cargo
        GRIPPER_ACTION_GRAB (1) %gripper grabs onto cargo
        CAMERA_STATUS_TYPE_HEARTBEAT (0) %Camera heartbeat, announce camera component ID at 1hz
        CAMERA_STATUS_TYPE_TRIGGER (1) %Camera image triggered
        CAMERA_STATUS_TYPE_DISCONNECT (2) %Camera connection lost
        CAMERA_STATUS_TYPE_ERROR (3) %Camera unknown error
        CAMERA_STATUS_TYPE_LOWBATT (4) %Camera battery low. Parameter p1 shows reported voltage
        CAMERA_STATUS_TYPE_LOWSTORE (5) %Camera storage low. Parameter p1 shows reported shots remaining
        CAMERA_STATUS_TYPE_LOWSTOREV (6) %Camera storage low. Parameter p1 shows reported video minutes remaining
        CAMERA_FEEDBACK_PHOTO (0) %Shooting photos, not video
        CAMERA_FEEDBACK_VIDEO (1) %Shooting video, not stills
        CAMERA_FEEDBACK_BADEXPOSURE (2) %Unable to achieve requested exposure (e.g. shutter speed too low)
        CAMERA_FEEDBACK_CLOSEDLOOP (3) %Closed loop feedback from camera, we know for sure it has successfully taken a picture
        CAMERA_FEEDBACK_OPENLOOP (4) %Open loop camera, an image trigger has been requested but we can't know for sure it has successfully taken a picture
        MAV_MODE_GIMBAL_UNINITIALIZED (0) %Gimbal is powered on but has not started initializing yet
        MAV_MODE_GIMBAL_CALIBRATING_PITCH (1) %Gimbal is currently running calibration on the pitch axis
        MAV_MODE_GIMBAL_CALIBRATING_ROLL (2) %Gimbal is currently running calibration on the roll axis
        MAV_MODE_GIMBAL_CALIBRATING_YAW (3) %Gimbal is currently running calibration on the yaw axis
        MAV_MODE_GIMBAL_INITIALIZED (4) %Gimbal has finished calibrating and initializing, but is relaxed pending reception of first rate command from copter
        MAV_MODE_GIMBAL_ACTIVE (5) %Gimbal is actively stabilizing
        MAV_MODE_GIMBAL_RATE_CMD_TIMEOUT (6) %Gimbal is relaxed because it missed more than 10 expected rate command messages in a row.  Gimbal will move back to active mode when it receives a new rate command
        GIMBAL_AXIS_YAW (0) %Gimbal yaw axis
        GIMBAL_AXIS_PITCH (1) %Gimbal pitch axis
        GIMBAL_AXIS_ROLL (2) %Gimbal roll axis
        GIMBAL_AXIS_CALIBRATION_STATUS_IN_PROGRESS (0) %Axis calibration is in progress
        GIMBAL_AXIS_CALIBRATION_STATUS_SUCCEEDED (1) %Axis calibration succeeded
        GIMBAL_AXIS_CALIBRATION_STATUS_FAILED (2) %Axis calibration failed
        FACTORY_TEST_AXIS_RANGE_LIMITS (0) %Tests to make sure each axis can move to its mechanical limits
        GIMBAL_AXIS_CALIBRATION_REQUIRED_UNKNOWN (0) %Whether or not this axis requires calibration is unknown at this time
        GIMBAL_AXIS_CALIBRATION_REQUIRED_TRUE (1) %This axis requires calibration
        GIMBAL_AXIS_CALIBRATION_REQUIRED_FALSE (2) %This axis does not require calibration
        GOPRO_HEARTBEAT_STATUS_DISCONNECTED (0) %No GoPro connected
        GOPRO_HEARTBEAT_STATUS_INCOMPATIBLE (1) %The detected GoPro is not HeroBus compatible
        GOPRO_HEARTBEAT_STATUS_CONNECTED_POWER_OFF (2) %A HeroBus compatible GoPro is connected
        GOPRO_HEARTBEAT_STATUS_CONNECTED_POWER_ON (3) %A HeroBus compatible GoPro is connected
        GOPRO_HEARTBEAT_STATUS_RECORDING (4) %A HeroBus compatible GoPro is connected and recording
        GOPRO_HEARTBEAT_STATUS_ERR_OVERTEMP (5) %A HeroBus compatible GoPro is connected and overtemperature
        GOPRO_HEARTBEAT_STATUS_ERR_STORAGE (6) %A HeroBus compatible GoPro is connected and storage is missing or full
        GOPRO_SET_RESPONSE_RESULT_FAILURE (0) %The write message with ID indicated failed
        GOPRO_SET_RESPONSE_RESULT_SUCCESS (1) %The write message with ID indicated succeeded
        GOPRO_COMMAND_POWER (0) %(Get/Set)
        GOPRO_COMMAND_CAPTURE_MODE (1) %(Get/Set)
        GOPRO_COMMAND_SHUTTER (2) %(___/Set)
        GOPRO_COMMAND_BATTERY (3) %(Get/___)
        GOPRO_COMMAND_MODEL (4) %(Get/___)
        GOPRO_COMMAND_REQUEST_FAILED (254) %(Get/___)
        LED_CONTROL_PATTERN_OFF (0) %LED patterns off (return control to regular vehicle control)
        LED_CONTROL_PATTERN_FIRMWAREUPDATE (1) %LEDs show pattern during firmware update
        LED_CONTROL_PATTERN_CUSTOM (255) %Custom Pattern using custom bytes fields
        EKF_ATTITUDE (1) %set if EKF's attitude estimate is good
        EKF_VELOCITY_HORIZ (2) %set if EKF's horizontal velocity estimate is good
        EKF_VELOCITY_VERT (4) %set if EKF's vertical velocity estimate is good
        EKF_POS_HORIZ_REL (8) %set if EKF's horizontal position (relative) estimate is good
        EKF_POS_HORIZ_ABS (16) %set if EKF's horizontal position (absolute) estimate is good
        EKF_POS_VERT_ABS (32) %set if EKF's vertical position (absolute) estimate is good
        EKF_POS_VERT_AGL (64) %set if EKF's vertical position (above ground) estimate is good
        EKF_CONST_POS_MODE (128) %EKF is in constant position mode and does not know it's absolute or relative position
        EKF_PRED_POS_HORIZ_REL (256) %set if EKF's predicted horizontal position (relative) estimate is good
        EKF_PRED_POS_HORIZ_ABS (512) %set if EKF's predicted horizontal position (absolute) estimate is good
        MAG_CAL_NOT_STARTED (0) %No description available
        MAG_CAL_WAITING_TO_START (1) %No description available
        MAG_CAL_RUNNING_STEP_ONE (2) %No description available
        MAG_CAL_RUNNING_STEP_TWO (3) %No description available
        MAG_CAL_SUCCESS (4) %No description available
        MAG_CAL_FAILED (5) %No description available
        PID_TUNING_ROLL (1) %No description available
        PID_TUNING_PITCH (2) %No description available
        PID_TUNING_YAW (3) %No description available
        PID_TUNING_ACCZ (4) %No description available
        PID_TUNING_STEER (5) %No description available
    end
        
end