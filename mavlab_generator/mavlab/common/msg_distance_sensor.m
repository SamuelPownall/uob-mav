classdef msg_distance_sensor < mavlink_message
    %MAVLINK Message Class
    %Name: distance_sensor	ID: 132
    %Description: None
            
    properties(Constant)
        ID = 132
        LEN = 14
    end
    
    properties        
		time_boot_ms	%Time since system boot (uint32)
		min_distance	%Minimum distance the sensor can measure in centimeters (uint16)
		max_distance	%Maximum distance the sensor can measure in centimeters (uint16)
		current_distance	%Current distance reading (uint16)
		type	%Type from MAV_DISTANCE_SENSOR enum. (uint8)
		id	%Onboard ID of the sensor (uint8)
		orientation	%Direction the sensor faces from MAV_SENSOR_ORIENTATION enum. (uint8)
		covariance	%Measurement covariance in centimeters, 0 for unknown / invalid readings (uint8)
	end
    
    methods
        
        %Constructor: msg_distance_sensor
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_distance_sensor(packet,time_boot_ms,min_distance,max_distance,current_distance,type,id,orientation,covariance)
        
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
                
            elseif nargin == 9
                
				obj.time_boot_ms = time_boot_ms;
				obj.min_distance = min_distance;
				obj.max_distance = max_distance;
				obj.current_distance = current_distance;
				obj.type = type;
				obj.id = id;
				obj.orientation = orientation;
				obj.covariance = covariance;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_distance_sensor.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_distance_sensor.ID;
                
				packet.payload.putUINT32(obj.time_boot_ms);

				packet.payload.putUINT16(obj.min_distance);

				packet.payload.putUINT16(obj.max_distance);

				packet.payload.putUINT16(obj.current_distance);

				packet.payload.putUINT8(obj.type);

				packet.payload.putUINT8(obj.id);

				packet.payload.putUINT8(obj.orientation);

				packet.payload.putUINT8(obj.covariance);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_boot_ms = payload.getUINT32();

			obj.min_distance = payload.getUINT16();

			obj.max_distance = payload.getUINT16();

			obj.current_distance = payload.getUINT16();

			obj.type = payload.getUINT8();

			obj.id = payload.getUINT8();

			obj.orientation = payload.getUINT8();

			obj.covariance = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';                                        
            elseif size(obj.min_distance,2) ~= 1
                result = 'min_distance';                                        
            elseif size(obj.max_distance,2) ~= 1
                result = 'max_distance';                                        
            elseif size(obj.current_distance,2) ~= 1
                result = 'current_distance';                                        
            elseif size(obj.type,2) ~= 1
                result = 'type';                                        
            elseif size(obj.id,2) ~= 1
                result = 'id';                                        
            elseif size(obj.orientation,2) ~= 1
                result = 'orientation';                                        
            elseif size(obj.covariance,2) ~= 1
                result = 'covariance';                            
            else
                result = 0;
            end
            
        end
                                
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
                                    
        function set.min_distance(obj,value)
            if value == uint16(value)
                obj.min_distance = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.max_distance(obj,value)
            if value == uint16(value)
                obj.max_distance = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.current_distance(obj,value)
            if value == uint16(value)
                obj.current_distance = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.type(obj,value)
            if value == uint8(value)
                obj.type = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.id(obj,value)
            if value == uint8(value)
                obj.id = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.orientation(obj,value)
            if value == uint8(value)
                obj.orientation = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.covariance(obj,value)
            if value == uint8(value)
                obj.covariance = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end