classdef msg_estimator_status < mavlink_message
    %MAVLINK Message Class
    %Name: estimator_status	ID: 230
    %Description: Estimator status message including flags, innovation test ratios and estimated accuracies. The flags message is an integer bitmask containing information on which EKF outputs are valid. See the ESTIMATOR_STATUS_FLAGS enum definition for further information. The innovaton test ratios show the magnitude of the sensor innovation divided by the innovation check threshold. Under normal operation the innovaton test ratios should be below 0.5 with occasional values up to 1.0. Values greater than 1.0 should be rare under normal operation and indicate that a measurement has been rejected by the filter. The user should be notified if an innovation test ratio greater than 1.0 is recorded. Notifications for values in the range between 0.5 and 1.0 should be optional and controllable by the user.
            
    properties(Constant)
        ID = 230
        LEN = 42
    end
    
    properties        
		time_usec	%Timestamp (micros since boot or Unix epoch) (uint64)
		vel_ratio	%Velocity innovation test ratio (single)
		pos_horiz_ratio	%Horizontal position innovation test ratio (single)
		pos_vert_ratio	%Vertical position innovation test ratio (single)
		mag_ratio	%Magnetometer innovation test ratio (single)
		hagl_ratio	%Height above terrain innovation test ratio (single)
		tas_ratio	%True airspeed innovation test ratio (single)
		pos_horiz_accuracy	%Horizontal position 1-STD accuracy relative to the EKF local origin (m) (single)
		pos_vert_accuracy	%Vertical position 1-STD accuracy relative to the EKF local origin (m) (single)
		flags	%Integer bitmask indicating which EKF outputs are valid. See definition for ESTIMATOR_STATUS_FLAGS. (uint16)
	end
    
    methods
        
        %Constructor: msg_estimator_status
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_estimator_status(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_estimator_status.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_estimator_status.ID;
                
				packet.payload.putUINT64(obj.time_usec);

				packet.payload.putSINGLE(obj.vel_ratio);

				packet.payload.putSINGLE(obj.pos_horiz_ratio);

				packet.payload.putSINGLE(obj.pos_vert_ratio);

				packet.payload.putSINGLE(obj.mag_ratio);

				packet.payload.putSINGLE(obj.hagl_ratio);

				packet.payload.putSINGLE(obj.tas_ratio);

				packet.payload.putSINGLE(obj.pos_horiz_accuracy);

				packet.payload.putSINGLE(obj.pos_vert_accuracy);

				packet.payload.putUINT16(obj.flags);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();

			obj.vel_ratio = payload.getSINGLE();

			obj.pos_horiz_ratio = payload.getSINGLE();

			obj.pos_vert_ratio = payload.getSINGLE();

			obj.mag_ratio = payload.getSINGLE();

			obj.hagl_ratio = payload.getSINGLE();

			obj.tas_ratio = payload.getSINGLE();

			obj.pos_horiz_accuracy = payload.getSINGLE();

			obj.pos_vert_accuracy = payload.getSINGLE();

			obj.flags = payload.getUINT16();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_usec,2) ~= 1
                result = 'time_usec';                                        
            elseif size(obj.vel_ratio,2) ~= 1
                result = 'vel_ratio';                                        
            elseif size(obj.pos_horiz_ratio,2) ~= 1
                result = 'pos_horiz_ratio';                                        
            elseif size(obj.pos_vert_ratio,2) ~= 1
                result = 'pos_vert_ratio';                                        
            elseif size(obj.mag_ratio,2) ~= 1
                result = 'mag_ratio';                                        
            elseif size(obj.hagl_ratio,2) ~= 1
                result = 'hagl_ratio';                                        
            elseif size(obj.tas_ratio,2) ~= 1
                result = 'tas_ratio';                                        
            elseif size(obj.pos_horiz_accuracy,2) ~= 1
                result = 'pos_horiz_accuracy';                                        
            elseif size(obj.pos_vert_accuracy,2) ~= 1
                result = 'pos_vert_accuracy';                                        
            elseif size(obj.flags,2) ~= 1
                result = 'flags';                            
            else
                result = 0;
            end
            
        end
                                
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                mavlink.throwTypeError('value','uint64');
            end
        end
                                
        function set.vel_ratio(obj,value)
            obj.vel_ratio = single(value);
        end
                                
        function set.pos_horiz_ratio(obj,value)
            obj.pos_horiz_ratio = single(value);
        end
                                
        function set.pos_vert_ratio(obj,value)
            obj.pos_vert_ratio = single(value);
        end
                                
        function set.mag_ratio(obj,value)
            obj.mag_ratio = single(value);
        end
                                
        function set.hagl_ratio(obj,value)
            obj.hagl_ratio = single(value);
        end
                                
        function set.tas_ratio(obj,value)
            obj.tas_ratio = single(value);
        end
                                
        function set.pos_horiz_accuracy(obj,value)
            obj.pos_horiz_accuracy = single(value);
        end
                                
        function set.pos_vert_accuracy(obj,value)
            obj.pos_vert_accuracy = single(value);
        end
                                    
        function set.flags(obj,value)
            if value == uint16(value)
                obj.flags = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                        
	end
end