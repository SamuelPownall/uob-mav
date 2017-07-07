classdef msg_gimbal_report_factory_tests_progress < mavlink_message
    %MAVLINK Message Class
    %Name: gimbal_report_factory_tests_progress	ID: 210
    %Description: 
            Reports the current status of a section of a running factory test
        
            
    properties(Constant)
        ID = 210
        LEN = 4
    end
    
    properties        
		test	%Which factory test is currently running (uint8)
		test_section	%Which section of the test is currently running.  The meaning of this is test-dependent (uint8)
		test_section_progress	%The progress of the current test section, 0x64=100% (uint8)
		test_status	%The status of the currently executing test section.  The meaning of this is test and section-dependent (uint8)
	end
    
    methods
        
        %Constructor: msg_gimbal_report_factory_tests_progress
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_gimbal_report_factory_tests_progress(packet,test,test_section,test_section_progress,test_status)
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(packet,'mavlink_packet')
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('packet','mavlink_packet');
                end
                
            elseif nargin == 5
                
				obj.test = test;
				obj.test_section = test_section;
				obj.test_section_progress = test_section_progress;
				obj.test_status = test_status;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_gimbal_report_factory_tests_progress.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_gimbal_report_factory_tests_progress.ID;
                
				packet.payload.putUINT8(obj.test);

				packet.payload.putUINT8(obj.test_section);

				packet.payload.putUINT8(obj.test_section_progress);

				packet.payload.putUINT8(obj.test_status);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.test = payload.getUINT8();

			obj.test_section = payload.getUINT8();

			obj.test_section_progress = payload.getUINT8();

			obj.test_status = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.test,2) ~= 1
                result = 'test';                                        
            elseif size(obj.test_section,2) ~= 1
                result = 'test_section';                                        
            elseif size(obj.test_section_progress,2) ~= 1
                result = 'test_section_progress';                                        
            elseif size(obj.test_status,2) ~= 1
                result = 'test_status';                            
            else
                result = 0;
            end
            
        end
                                
        function set.test(obj,value)
            if value == uint8(value)
                obj.test = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.test_section(obj,value)
            if value == uint8(value)
                obj.test_section = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.test_section_progress(obj,value)
            if value == uint8(value)
                obj.test_section_progress = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.test_status(obj,value)
            if value == uint8(value)
                obj.test_status = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end