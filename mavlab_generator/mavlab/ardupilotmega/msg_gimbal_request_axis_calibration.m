classdef msg_gimbal_request_axis_calibration < mavlink_message
    %MAVLINK Message Class
    %Name: gimbal_request_axis_calibration	ID: 213
    %Description: 
			Requests any currently uncalibrated gimbal axes to run the axis calibration procedure.  An axis is considered uncalibrated if its commutation calibration
			slope and intercept are 0
		
            
    properties(Constant)
        ID = 213
        LEN = 2
    end
    
    properties        
		target_system	%System ID (uint8)
		target_component	%Component ID (uint8)
	end
    
    methods
        
        %Constructor: msg_gimbal_request_axis_calibration
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_gimbal_request_axis_calibration(packet,target_system,target_component)
        
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
                
            elseif nargin == 3
                
				obj.target_system = target_system;
				obj.target_component = target_component;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_gimbal_request_axis_calibration.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_gimbal_request_axis_calibration.ID;
                
				packet.payload.putUINT8(obj.target_system);

				packet.payload.putUINT8(obj.target_component);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.target_system,2) ~= 1
                result = 'target_system';                                        
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';                            
            else
                result = 0;
            end
            
        end
                                
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end