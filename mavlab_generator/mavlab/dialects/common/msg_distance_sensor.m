classdef msg_distance_sensor < MAVLinkMessage
	%MSG_DISTANCE_SENSOR: MAVLink Message ID = 132
    %Description:
    %    No description available
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_boot_ms(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    time_boot_ms(uint32): Time since system boot
    %    min_distance(uint16): Minimum distance the sensor can measure in centimeters
    %    max_distance(uint16): Maximum distance the sensor can measure in centimeters
    %    current_distance(uint16): Current distance reading
    %    type(uint8): Type from MAV_DISTANCE_SENSOR enum.
    %    id(uint8): Onboard ID of the sensor
    %    orientation(uint8): Direction the sensor faces from MAV_SENSOR_ORIENTATION enum.
    %    covariance(uint8): Measurement covariance in centimeters, 0 for unknown / invalid readings
	
	properties(Constant)
		ID = 132
		LEN = 14
	end
	
	properties
        time_boot_ms	%Time since system boot	|	(uint32)
        min_distance	%Minimum distance the sensor can measure in centimeters	|	(uint16)
        max_distance	%Maximum distance the sensor can measure in centimeters	|	(uint16)
        current_distance	%Current distance reading	|	(uint16)
        type	%Type from MAV_DISTANCE_SENSOR enum.	|	(uint8)
        id	%Onboard ID of the sensor	|	(uint8)
        orientation	%Direction the sensor faces from MAV_SENSOR_ORIENTATION enum.	|	(uint8)
        covariance	%Measurement covariance in centimeters, 0 for unknown / invalid readings	|	(uint8)
    end

    methods(Static)

        function send(out,time_boot_ms,min_distance,max_distance,current_distance,type,id,orientation,covariance,varargin)

            if nargin == 8 + 1
                msg = msg_distance_sensor(time_boot_ms,min_distance,max_distance,current_distance,type,id,orientation,covariance,varargin);
            elseif nargin == 2
                msg = msg_distance_sensor(time_boot_ms);
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

        function obj = msg_distance_sensor(time_boot_ms,min_distance,max_distance,current_distance,type,id,orientation,covariance,varargin)
        %MSG_DISTANCE_SENSOR: Create a new distance_sensor message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(time_boot_ms,'MAVLinkPacket')
                    packet = time_boot_ms;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('time_boot_ms','MAVLinkPacket');
                end
            elseif nargin >= 8 && isempty(varargin{1})
                obj.time_boot_ms = time_boot_ms;
                obj.min_distance = min_distance;
                obj.max_distance = max_distance;
                obj.current_distance = current_distance;
                obj.type = type;
                obj.id = id;
                obj.orientation = orientation;
                obj.covariance = covariance;
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

                packet = MAVLinkPacket(msg_distance_sensor.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
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
            
            obj.time_boot_ms = payload.getUINT32();
            obj.min_distance = payload.getUINT16();
            obj.max_distance = payload.getUINT16();
            obj.current_distance = payload.getUINT16();
            obj.type = payload.getUINT8();
            obj.id = payload.getUINT8();
            obj.orientation = payload.getUINT8();
            obj.covariance = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_boot_ms,2) ~= 1
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
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.min_distance(obj,value)
            if value == uint16(value)
                obj.min_distance = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.max_distance(obj,value)
            if value == uint16(value)
                obj.max_distance = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.current_distance(obj,value)
            if value == uint16(value)
                obj.current_distance = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.type(obj,value)
            if value == uint8(value)
                obj.type = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.id(obj,value)
            if value == uint8(value)
                obj.id = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.orientation(obj,value)
            if value == uint8(value)
                obj.orientation = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.covariance(obj,value)
            if value == uint8(value)
                obj.covariance = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end