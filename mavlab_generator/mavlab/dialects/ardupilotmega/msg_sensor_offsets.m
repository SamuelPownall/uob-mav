classdef msg_sensor_offsets < MAVLinkMessage
	%MSG_SENSOR_OFFSETS: MAVLink Message ID = 150
    %Description:
    %    Offsets and calibrations values for hardware
        sensors. This makes it easier to debug the calibration process.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    mag_declination(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    mag_declination(single): magnetic declination (radians)
    %    raw_press(int32): raw pressure from barometer
    %    raw_temp(int32): raw temperature from barometer
    %    gyro_cal_x(single): gyro X calibration
    %    gyro_cal_y(single): gyro Y calibration
    %    gyro_cal_z(single): gyro Z calibration
    %    accel_cal_x(single): accel X calibration
    %    accel_cal_y(single): accel Y calibration
    %    accel_cal_z(single): accel Z calibration
    %    mag_ofs_x(int16): magnetometer X offset
    %    mag_ofs_y(int16): magnetometer Y offset
    %    mag_ofs_z(int16): magnetometer Z offset
	
	properties(Constant)
		ID = 150
		LEN = 42
	end
	
	properties
        mag_declination	%magnetic declination (radians)	|	(single)
        raw_press	%raw pressure from barometer	|	(int32)
        raw_temp	%raw temperature from barometer	|	(int32)
        gyro_cal_x	%gyro X calibration	|	(single)
        gyro_cal_y	%gyro Y calibration	|	(single)
        gyro_cal_z	%gyro Z calibration	|	(single)
        accel_cal_x	%accel X calibration	|	(single)
        accel_cal_y	%accel Y calibration	|	(single)
        accel_cal_z	%accel Z calibration	|	(single)
        mag_ofs_x	%magnetometer X offset	|	(int16)
        mag_ofs_y	%magnetometer Y offset	|	(int16)
        mag_ofs_z	%magnetometer Z offset	|	(int16)
    end

    methods(Static)

        function send(out,mag_declination,raw_press,raw_temp,gyro_cal_x,gyro_cal_y,gyro_cal_z,accel_cal_x,accel_cal_y,accel_cal_z,mag_ofs_x,mag_ofs_y,mag_ofs_z,varargin)

            if nargin == 12 + 1
                msg = msg_sensor_offsets(mag_declination,raw_press,raw_temp,gyro_cal_x,gyro_cal_y,gyro_cal_z,accel_cal_x,accel_cal_y,accel_cal_z,mag_ofs_x,mag_ofs_y,mag_ofs_z,varargin);
            elseif nargin == 2
                msg = msg_sensor_offsets(mag_declination);
            else
                MAVLink.throwCustomError('The number of function arguments is not valid');
                return;
            end

            packet = msg.pack();
            if ~isempty(packet)
                buffer = packet.encode();
                write(out,buffer);
            else
                MAVLink.throwCustomError('The packet could not be verified');
            end
        
        end

    end

    methods

        function obj = msg_sensor_offsets(mag_declination,raw_press,raw_temp,gyro_cal_x,gyro_cal_y,gyro_cal_z,accel_cal_x,accel_cal_y,accel_cal_z,mag_ofs_x,mag_ofs_y,mag_ofs_z,varargin)
        %MSG_SENSOR_OFFSETS: Create a new sensor_offsets message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(mag_declination,'MAVLinkPacket')
                    packet = mag_declination;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('mag_declination','MAVLinkPacket');
                end
            elseif nargin >= 12 && isempty(varargin{1})
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
                MAVLink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        function packet = pack(obj)
        %PACK: Packs this MAVLink message into a MAVLinkPacket
        %Description:
        %    Packs the fields of a message into a MAVLinkPacket which can be encoded
        %    for transmission.

            errorField = obj.verify();
            if errorField == 0

                packet = MAVLinkPacket(msg_sensor_offsets.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
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
                MAVLink.throwPackingError(errorField);
            end

        end

        function unpack(obj, payload)
        %UNPACK: Unpacks a MAVLinkPayload into this MAVLink message
        %Description:
        %    Extracts the data from a MAVLinkPayload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(MAVLinkPayload): The payload to be unpacked into this MAVLink message

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
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.mag_declination,2) ~= 1
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
                MAVLink.throwTypeError('value','int32');
            end
        end
        
        function set.raw_temp(obj,value)
            if value == int32(value)
                obj.raw_temp = int32(value);
            else
                MAVLink.throwTypeError('value','int32');
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
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.mag_ofs_y(obj,value)
            if value == int16(value)
                obj.mag_ofs_y = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.mag_ofs_z(obj,value)
            if value == int16(value)
                obj.mag_ofs_z = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
    end

end