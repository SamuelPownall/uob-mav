classdef msg_gimbal_report_factory_tests_progress < mavlink_message
	%MSG_GIMBAL_REPORT_FACTORY_TESTS_PROGRESS: MAVLINK Message ID = 210
    %Description:
    %    Reports the current status of a section of a running factory test
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    test(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    test(uint8): Which factory test is currently running
    %    test_section(uint8): Which section of the test is currently running.  The meaning of this is test-dependent
    %    test_section_progress(uint8): The progress of the current test section, 0x64=100