classdef msg_gimbal_report_factory_tests_progress < mavlink_handle
	%MSG_GIMBAL_REPORT_FACTORY_TESTS_PROGRESS(packet,test,test_section,test_section_progress,test_status): MAVLINK Message ID = 210
    %Description:
    %    
            Reports the current status of a section of a running factory test
        
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    test(uint8): Which factory test is currently running
    %    test_section(uint8): Which section of the test is currently running.  The meaning of this is test-dependent
    %    test_section_progress(uint8): The progress of the current test section, 0x64=100