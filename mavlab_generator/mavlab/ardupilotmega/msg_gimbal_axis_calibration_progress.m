classdef msg_gimbal_axis_calibration_progress < mavlink_message
    %MAVLINK Message Class
    %Name: gimbal_axis_calibration_progress	ID: 203
    %Description:              Reports progress and success or failure of gimbal axis calibration procedure         
            
    properties(Constant)
        ID = 203
        LEN = 3
    end
    
    properties        
		calibration_axis	%Which gimbal axis we're reporting calibration progress for (uint8)
		calibration_progress	%The current calibration progress for this axis, 0x64=100% (uint8)
		calibration_status	%The status of the running calibration (uint8)
	end
    
    methods
        
        %Constructor: msg_gimbal_axis_calibration_progress
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_gimbal_axis_calibration_progress(packet,calibration_axis,calibration_progress,calibration_status)
        
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
                
            elseif nargin == 4
                
				obj.calibration_axis = calibration_axis;
				obj.calibration_progress = calibration_progress;
				obj.calibration_status = calibration_status;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_gimbal_axis_calibration_progress.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_gimbal_axis_calibration_progress.ID;
                
				packet.payload.putUINT8(obj.calibration_axis);

				packet.payload.putUINT8(obj.calibration_progress);

				packet.payload.putUINT8(obj.calibration_status);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.calibration_axis = payload.getUINT8();

			obj.calibration_progress = payload.getUINT8();

			obj.calibration_status = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.calibration_axis,2) ~= 1
                result = 'calibration_axis';                                        
            elseif size(obj.calibration_progress,2) ~= 1
                result = 'calibration_progress';                                        
            elseif size(obj.calibration_status,2) ~= 1
                result = 'calibration_status';                            
            else
                result = 0;
            end
            
        end
                                
        function set.calibration_axis(obj,value)
            if value == uint8(value)
                obj.calibration_axis = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.calibration_progress(obj,value)
            if value == uint8(value)
                obj.calibration_progress = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.calibration_status(obj,value)
            if value == uint8(value)
                obj.calibration_status = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end