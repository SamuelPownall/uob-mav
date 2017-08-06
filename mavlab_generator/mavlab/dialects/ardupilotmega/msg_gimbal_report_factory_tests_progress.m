classdef msg_gimbal_report_factory_tests_progress < MAVLinkMessage
	%MSG_GIMBAL_REPORT_FACTORY_TESTS_PROGRESS: MAVLink Message ID = 210
    %Description:
    %    Reports the current status of a section of a running factory test
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    test(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    test(uint8): Which factory test is currently running
    %    test_section(uint8): Which section of the test is currently running.  The meaning of this is test-dependent
    %    test_section_progress(uint8): The progress of the current test section, 0x64=100