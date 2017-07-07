classdef msg_sensor_offsets < mavlink_message
    %MAVLINK Message Class
    %Name: sensor_offsets	ID: 150
    %Description: Offsets and calibrations values for hardware
        sensors. This makes it easier to debug the calibration process.
            
    properties(Constant)
        ID = 150
        LEN = 42
    end
    
    properties        
		mag_declination	%magnetic declination (radians) (single)
		raw_press	%raw pressure from barometer (int32)
		raw_temp	%raw temperature from barometer (int32)
		gyro_cal_x	%gyro X calibration (single)
		gyro_cal_y	%gyro Y calibration (single)
		gyro_cal_z	%gyro Z calibration (single)
		accel_cal_x	%accel X calibration (single)
		accel_cal_y	%accel Y calibration (single)
		accel_cal_z	%accel Z calibration (single)
		mag_ofs_x	%magnetometer X offset (int16)
		mag_ofs_y	%magnetometer Y offset (int16)
		mag_ofs_z	%magnetometer Z offset (int16)
	end
    
    methods
        
        %Constructor: msg_sensor_offsets
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_sensor_offsets(packet,mag_declination,raw_press,raw_temp,gyro_cal_x,gyro_cal_y,gyro_cal_z,accel_cal_x,accel_cal_y,accel_cal_z,mag_ofs_x,mag_ofs_y,mag_ofs_z)
        
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
                
            elseif nargin == 13
                
				obj.mag_declination = mag_declination;
				obj.raw_press = raw_press;
				obj.raw_temp = raw_temp;
				obj.gyro_cal_x = gyro_cal_x;
				obj.gyro_cal_y = gyro_cal_y;
				obj.gyro_cal_z = gyro_cal_z;
				obj.accel_cal_x = accel_cal_x;
				obj.accel_cal_y = accel_cal_y;
				obj.accel_cal_z = accel_cal_z;
				obj.mag_ofs_x = mag_ofs_x;
				obj.mag_ofs_y = mag_ofs_y;
				obj.mag_ofs_z = mag_ofs_z;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_sensor_offsets.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_sensor_offsets.ID;
                
				packet.payload.putSINGLE(obj.mag_declination);

				packet.payload.putINT32(obj.raw_press);

				packet.payload.putINT32(obj.raw_temp);

				packet.payload.putSINGLE(obj.gyro_cal_x);

				packet.payload.putSINGLE(obj.gyro_cal_y);

				packet.payload.putSINGLE(obj.gyro_cal_z);

				packet.payload.putSINGLE(obj.accel_cal_x);

				packet.payload.putSINGLE(obj.accel_cal_y);

				packet.payload.putSINGLE(obj.accel_cal_z);

				packet.payload.putINT16(obj.mag_ofs_x);

				packet.payload.putINT16(obj.mag_ofs_y);

				packet.payload.putINT16(obj.mag_ofs_z);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.mag_declination = payload.getSINGLE();

			obj.raw_press = payload.getINT32();

			obj.raw_temp = payload.getINT32();

			obj.gyro_cal_x = payload.getSINGLE();

			obj.gyro_cal_y = payload.getSINGLE();

			obj.gyro_cal_z = payload.getSINGLE();

			obj.accel_cal_x = payload.getSINGLE();

			obj.accel_cal_y = payload.getSINGLE();

			obj.accel_cal_z = payload.getSINGLE();

			obj.mag_ofs_x = payload.getINT16();

			obj.mag_ofs_y = payload.getINT16();

			obj.mag_ofs_z = payload.getINT16();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.mag_declination,2) ~= 1
                result = 'mag_declination';                                        
            elseif size(obj.raw_press,2) ~= 1
                result = 'raw_press';                                        
            elseif size(obj.raw_temp,2) ~= 1
                result = 'raw_temp';                                        
            elseif size(obj.gyro_cal_x,2) ~= 1
                result = 'gyro_cal_x';                                        
            elseif size(obj.gyro_cal_y,2) ~= 1
                result = 'gyro_cal_y';                                        
            elseif size(obj.gyro_cal_z,2) ~= 1
                result = 'gyro_cal_z';                                        
            elseif size(obj.accel_cal_x,2) ~= 1
                result = 'accel_cal_x';                                        
            elseif size(obj.accel_cal_y,2) ~= 1
                result = 'accel_cal_y';                                        
            elseif size(obj.accel_cal_z,2) ~= 1
                result = 'accel_cal_z';                                        
            elseif size(obj.mag_ofs_x,2) ~= 1
                result = 'mag_ofs_x';                                        
            elseif size(obj.mag_ofs_y,2) ~= 1
                result = 'mag_ofs_y';                                        
            elseif size(obj.mag_ofs_z,2) ~= 1
                result = 'mag_ofs_z';                            
            else
                result = 0;
            end
            
        end
                            
        function set.mag_declination(obj,value)
            obj.mag_declination = single(value);
        end
                                    
        function set.raw_press(obj,value)
            if value == int32(value)
                obj.raw_press = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                                    
        function set.raw_temp(obj,value)
            if value == int32(value)
                obj.raw_temp = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                                
        function set.gyro_cal_x(obj,value)
            obj.gyro_cal_x = single(value);
        end
                                
        function set.gyro_cal_y(obj,value)
            obj.gyro_cal_y = single(value);
        end
                                
        function set.gyro_cal_z(obj,value)
            obj.gyro_cal_z = single(value);
        end
                                
        function set.accel_cal_x(obj,value)
            obj.accel_cal_x = single(value);
        end
                                
        function set.accel_cal_y(obj,value)
            obj.accel_cal_y = single(value);
        end
                                
        function set.accel_cal_z(obj,value)
            obj.accel_cal_z = single(value);
        end
                                    
        function set.mag_ofs_x(obj,value)
            if value == int16(value)
                obj.mag_ofs_x = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
                                    
        function set.mag_ofs_y(obj,value)
            if value == int16(value)
                obj.mag_ofs_y = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
                                    
        function set.mag_ofs_z(obj,value)
            if value == int16(value)
                obj.mag_ofs_z = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
                        
	end
end