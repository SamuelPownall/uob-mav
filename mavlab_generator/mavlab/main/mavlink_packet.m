classdef mavlink_packet < handle
    %MAVLINK_PACKET Class
    %Used to encode and decode MAVLINK packets
    
    %Constant public variables
    properties(Constant)
        STX = 254;  %The 'magic' byte
    end
    
    %Private variables
    properties
        len;        %Length of the packet payload
        seq;        %Sequence number of the current packet
        sysid;      %ID of the sending system
        compid;     %ID of the sending component
        msgid;      %ID of the message type contained in the payload
        payload;    %The packet payload
        crc;        %The crc object for this packet
    end
    
    %Publically accessible object variables
    methods
        
        %Constructor: mavlink_packet
        %payloadLength should be an integer between 0 and MAX_PAYLOAD_SIZE
        function obj = mavlink_packet(payloadLength)
            obj.len = payloadLength;
            obj.payload = mavlink_payload(payloadLength);
        end
        
        %Function: Generate the CRC checksum for the packet
        function generateCRC(obj)   
            if isempty(obj.crc)
                obj.crc = mavlink_crc();
            else
                obj.crc.start_checksum();
            end
            
            obj.crc.updateChecksum(uint8(obj.len));
            obj.crc.updateChecksum(uint8(obj.seq));
            obj.crc.updateChecksum(uint8(obj.sysid));
            obj.crc.updateChecksum(uint8(obj.compid));
            obj.crc.updateChecksum(uint8(obj.msgid));
            
            obj.payload.resetIndex();
            for i = 1:1:obj.payload.getLength()
                obj.crc.updateChecksum(obj.payload.getUINT8());
            end
            obj.crc.finishChecksum(uint8(obj.msgid));
        end
        
        %Function: Encode the packet into a byte buffer for transmission
        function byteBuffer = encode(obj)
            obj.seq = 1;
            obj.generateCRC();
            byteBuffer = cat(1,uint8(obj.STX),uint8(obj.len),uint8(obj.seq),uint8(obj.sysid),...
                uint8(obj.compid),uint8(obj.msgid),obj.payload.getByteBuffer(),obj.crc.getLSB(), obj.crc.getMSB());
        end
        
        %Getter: isPayloadFull
        function fillStatus = isPayloadFull(obj)
            fillStatus = obj.payload.isPayloadFull();
        end
        
        %Function: Unpack the payload and return the correct message type
        function message = unpack(obj)
            message = [];
            switch obj.msgid 
                case 150
                    message = msg_sensor_offsets(obj);
                case 151
                    message = msg_set_mag_offsets(obj);
                case 152
                    message = msg_meminfo(obj);
                case 153
                    message = msg_ap_adc(obj);
                case 154
                    message = msg_digicam_configure(obj);
                case 155
                    message = msg_digicam_control(obj);
                case 156
                    message = msg_mount_configure(obj);
                case 157
                    message = msg_mount_control(obj);
                case 158
                    message = msg_mount_status(obj);
                case 160
                    message = msg_fence_point(obj);
                case 161
                    message = msg_fence_fetch_point(obj);
                case 162
                    message = msg_fence_status(obj);
                case 163
                    message = msg_ahrs(obj);
                case 164
                    message = msg_simstate(obj);
                case 165
                    message = msg_hwstatus(obj);
                case 166
                    message = msg_radio(obj);
                case 167
                    message = msg_limits_status(obj);
                case 168
                    message = msg_wind(obj);
                case 169
                    message = msg_data16(obj);
                case 170
                    message = msg_data32(obj);
                case 171
                    message = msg_data64(obj);
                case 172
                    message = msg_data96(obj);
                case 173
                    message = msg_rangefinder(obj);
                case 174
                    message = msg_airspeed_autocal(obj);
                case 175
                    message = msg_rally_point(obj);
                case 176
                    message = msg_rally_fetch_point(obj);
                case 177
                    message = msg_compassmot_status(obj);
                case 178
                    message = msg_ahrs2(obj);
                case 179
                    message = msg_camera_status(obj);
                case 180
                    message = msg_camera_feedback(obj);
                case 181
                    message = msg_battery2(obj);
                case 182
                    message = msg_ahrs3(obj);
                case 183
                    message = msg_autopilot_version_request(obj);
                case 186
                    message = msg_led_control(obj);
                case 191
                    message = msg_mag_cal_progress(obj);
                case 192
                    message = msg_mag_cal_report(obj);
                case 193
                    message = msg_ekf_status_report(obj);
                case 194
                    message = msg_pid_tuning(obj);
                case 200
                    message = msg_gimbal_report(obj);
                case 201
                    message = msg_gimbal_control(obj);
                case 202
                    message = msg_gimbal_reset(obj);
                case 203
                    message = msg_gimbal_axis_calibration_progress(obj);
                case 204
                    message = msg_gimbal_set_home_offsets(obj);
                case 205
                    message = msg_gimbal_home_offset_calibration_result(obj);
                case 206
                    message = msg_gimbal_set_factory_parameters(obj);
                case 207
                    message = msg_gimbal_factory_parameters_loaded(obj);
                case 208
                    message = msg_gimbal_erase_firmware_and_config(obj);
                case 209
                    message = msg_gimbal_perform_factory_tests(obj);
                case 210
                    message = msg_gimbal_report_factory_tests_progress(obj);
                case 211
                    message = msg_gimbal_request_axis_calibration_status(obj);
                case 212
                    message = msg_gimbal_report_axis_calibration_status(obj);
                case 213
                    message = msg_gimbal_request_axis_calibration(obj);
                case 215
                    message = msg_gopro_heartbeat(obj);
                case 216
                    message = msg_gopro_get_request(obj);
                case 217
                    message = msg_gopro_get_response(obj);
                case 218
                    message = msg_gopro_set_request(obj);
                case 219
                    message = msg_gopro_set_response(obj);
                case 0
                    message = msg_heartbeat(obj);
                case 1
                    message = msg_sys_status(obj);
                case 2
                    message = msg_system_time(obj);
                case 4
                    message = msg_ping(obj);
                case 5
                    message = msg_change_operator_control(obj);
                case 6
                    message = msg_change_operator_control_ack(obj);
                case 7
                    message = msg_auth_key(obj);
                case 11
                    message = msg_set_mode(obj);
                case 20
                    message = msg_param_request_read(obj);
                case 21
                    message = msg_param_request_list(obj);
                case 22
                    message = msg_param_value(obj);
                case 23
                    message = msg_param_set(obj);
                case 24
                    message = msg_gps_raw_int(obj);
                case 25
                    message = msg_gps_status(obj);
                case 26
                    message = msg_scaled_imu(obj);
                case 27
                    message = msg_raw_imu(obj);
                case 28
                    message = msg_raw_pressure(obj);
                case 29
                    message = msg_scaled_pressure(obj);
                case 30
                    message = msg_attitude(obj);
                case 31
                    message = msg_attitude_quaternion(obj);
                case 32
                    message = msg_local_position_ned(obj);
                case 33
                    message = msg_global_position_int(obj);
                case 34
                    message = msg_rc_channels_scaled(obj);
                case 35
                    message = msg_rc_channels_raw(obj);
                case 36
                    message = msg_servo_output_raw(obj);
                case 37
                    message = msg_mission_request_partial_list(obj);
                case 38
                    message = msg_mission_write_partial_list(obj);
                case 39
                    message = msg_mission_item(obj);
                case 40
                    message = msg_mission_request(obj);
                case 41
                    message = msg_mission_set_current(obj);
                case 42
                    message = msg_mission_current(obj);
                case 43
                    message = msg_mission_request_list(obj);
                case 44
                    message = msg_mission_count(obj);
                case 45
                    message = msg_mission_clear_all(obj);
                case 46
                    message = msg_mission_item_reached(obj);
                case 47
                    message = msg_mission_ack(obj);
                case 48
                    message = msg_set_gps_global_origin(obj);
                case 49
                    message = msg_gps_global_origin(obj);
                case 50
                    message = msg_param_map_rc(obj);
                case 51
                    message = msg_mission_request_int(obj);
                case 54
                    message = msg_safety_set_allowed_area(obj);
                case 55
                    message = msg_safety_allowed_area(obj);
                case 61
                    message = msg_attitude_quaternion_cov(obj);
                case 62
                    message = msg_nav_controller_output(obj);
                case 63
                    message = msg_global_position_int_cov(obj);
                case 64
                    message = msg_local_position_ned_cov(obj);
                case 65
                    message = msg_rc_channels(obj);
                case 66
                    message = msg_request_data_stream(obj);
                case 67
                    message = msg_data_stream(obj);
                case 69
                    message = msg_manual_control(obj);
                case 70
                    message = msg_rc_channels_override(obj);
                case 73
                    message = msg_mission_item_int(obj);
                case 74
                    message = msg_vfr_hud(obj);
                case 75
                    message = msg_command_int(obj);
                case 76
                    message = msg_command_long(obj);
                case 77
                    message = msg_command_ack(obj);
                case 81
                    message = msg_manual_setpoint(obj);
                case 82
                    message = msg_set_attitude_target(obj);
                case 83
                    message = msg_attitude_target(obj);
                case 84
                    message = msg_set_position_target_local_ned(obj);
                case 85
                    message = msg_position_target_local_ned(obj);
                case 86
                    message = msg_set_position_target_global_int(obj);
                case 87
                    message = msg_position_target_global_int(obj);
                case 89
                    message = msg_local_position_ned_system_global_offset(obj);
                case 90
                    message = msg_hil_state(obj);
                case 91
                    message = msg_hil_controls(obj);
                case 92
                    message = msg_hil_rc_inputs_raw(obj);
                case 93
                    message = msg_hil_actuator_controls(obj);
                case 100
                    message = msg_optical_flow(obj);
                case 101
                    message = msg_global_vision_position_estimate(obj);
                case 102
                    message = msg_vision_position_estimate(obj);
                case 103
                    message = msg_vision_speed_estimate(obj);
                case 104
                    message = msg_vicon_position_estimate(obj);
                case 105
                    message = msg_highres_imu(obj);
                case 106
                    message = msg_optical_flow_rad(obj);
                case 107
                    message = msg_hil_sensor(obj);
                case 108
                    message = msg_sim_state(obj);
                case 109
                    message = msg_radio_status(obj);
                case 110
                    message = msg_file_transfer_protocol(obj);
                case 111
                    message = msg_timesync(obj);
                case 112
                    message = msg_camera_trigger(obj);
                case 113
                    message = msg_hil_gps(obj);
                case 114
                    message = msg_hil_optical_flow(obj);
                case 115
                    message = msg_hil_state_quaternion(obj);
                case 116
                    message = msg_scaled_imu2(obj);
                case 117
                    message = msg_log_request_list(obj);
                case 118
                    message = msg_log_entry(obj);
                case 119
                    message = msg_log_request_data(obj);
                case 120
                    message = msg_log_data(obj);
                case 121
                    message = msg_log_erase(obj);
                case 122
                    message = msg_log_request_end(obj);
                case 123
                    message = msg_gps_inject_data(obj);
                case 124
                    message = msg_gps2_raw(obj);
                case 125
                    message = msg_power_status(obj);
                case 126
                    message = msg_serial_control(obj);
                case 127
                    message = msg_gps_rtk(obj);
                case 128
                    message = msg_gps2_rtk(obj);
                case 129
                    message = msg_scaled_imu3(obj);
                case 130
                    message = msg_data_transmission_handshake(obj);
                case 131
                    message = msg_encapsulated_data(obj);
                case 132
                    message = msg_distance_sensor(obj);
                case 133
                    message = msg_terrain_request(obj);
                case 134
                    message = msg_terrain_data(obj);
                case 135
                    message = msg_terrain_check(obj);
                case 136
                    message = msg_terrain_report(obj);
                case 137
                    message = msg_scaled_pressure2(obj);
                case 138
                    message = msg_att_pos_mocap(obj);
                case 139
                    message = msg_set_actuator_control_target(obj);
                case 140
                    message = msg_actuator_control_target(obj);
                case 141
                    message = msg_altitude(obj);
                case 142
                    message = msg_resource_request(obj);
                case 143
                    message = msg_scaled_pressure3(obj);
                case 144
                    message = msg_follow_target(obj);
                case 146
                    message = msg_control_system_state(obj);
                case 147
                    message = msg_battery_status(obj);
                case 148
                    message = msg_autopilot_version(obj);
                case 149
                    message = msg_landing_target(obj);
                case 230
                    message = msg_estimator_status(obj);
                case 231
                    message = msg_wind_cov(obj);
                case 232
                    message = msg_gps_input(obj);
                case 233
                    message = msg_gps_rtcm_data(obj);
                case 234
                    message = msg_high_latency(obj);
                case 241
                    message = msg_vibration(obj);
                case 242
                    message = msg_home_position(obj);
                case 243
                    message = msg_set_home_position(obj);
                case 244
                    message = msg_message_interval(obj);
                case 245
                    message = msg_extended_sys_state(obj);
                case 246
                    message = msg_adsb_vehicle(obj);
                case 247
                    message = msg_collision(obj);
                case 248
                    message = msg_v2_extension(obj);
                case 249
                    message = msg_memory_vect(obj);
                case 250
                    message = msg_debug_vect(obj);
                case 251
                    message = msg_named_value_float(obj);
                case 252
                    message = msg_named_value_int(obj);
                case 253
                    message = msg_statustext(obj);
                case 254
                    message = msg_debug(obj);
                case 256
                    message = msg_setup_signing(obj);
                case 257
                    message = msg_button_change(obj);
                case 258
                    message = msg_play_tune(obj);
                case 259
                    message = msg_camera_information(obj);
                case 260
                    message = msg_camera_settings(obj);
                case 261
                    message = msg_storage_information(obj);
                case 262
                    message = msg_camera_capture_status(obj);
                case 263
                    message = msg_camera_image_captured(obj);
                case 264
                    message = msg_flight_information(obj);
                case 265
                    message = msg_mount_orientation(obj);
                case 266
                    message = msg_logging_data(obj);
                case 267
                    message = msg_logging_data_acked(obj);
                case 268
                    message = msg_logging_ack(obj);
                otherwise
                    mavlink.throwUnsupportedMessageError(obj.msgid);
            end
        end

    end
end
                