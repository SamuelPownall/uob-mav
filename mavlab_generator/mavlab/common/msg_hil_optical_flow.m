classdef msg_hil_optical_flow < mavlink_message
	%MSG_HIL_OPTICAL_FLOW: MAVLINK Message ID = 114
    %Description:
    %    Simulated optical flow from a flow sensor (e.g. PX4FLOW or optical mouse sensor)
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
    %    time_usec(uint64): Timestamp (microseconds, synced to UNIX time or since system boot)
    %    integration_time_us(uint32): Integration time in microseconds. Divide integrated_x and integrated_y by the integration time to obtain average flow. The integration time also indicates the.
    %    integrated_x(single): Flow in radians around X axis (Sensor RH rotation about the X axis induces a positive flow. Sensor linear motion along the positive Y axis induces a negative flow.)
    %    integrated_y(single): Flow in radians around Y axis (Sensor RH rotation about the Y axis induces a positive flow. Sensor linear motion along the positive X axis induces a positive flow.)
    %    integrated_xgyro(single): RH rotation around X axis (rad)
    %    integrated_ygyro(single): RH rotation around Y axis (rad)
    %    integrated_zgyro(single): RH rotation around Z axis (rad)
    %    time_delta_distance_us(uint32): Time in microseconds since the distance was sampled.
    %    distance(single): Distance to the center of the flow field in meters. Positive value (including zero): distance known. Negative value: Unknown distance.
    %    temperature(int16): Temperature * 100 in centi-degrees Celsius
    %    sensor_id(uint8): Sensor ID
    %    quality(uint8): Optical flow quality / confidence. 0: no valid flow, 255: maximum quality
	
	properties(Constant)
		ID = 114
		LEN = 44
	end
	
	properties
        time_usec	%Timestamp (microseconds, synced to UNIX time or since system boot)	|	(uint64)
        integration_time_us	%Integration time in microseconds. Divide integrated_x and integrated_y by the integration time to obtain average flow. The integration time also indicates the.	|	(uint32)
        integrated_x	%Flow in radians around X axis (Sensor RH rotation about the X axis induces a positive flow. Sensor linear motion along the positive Y axis induces a negative flow.)	|	(single)
        integrated_y	%Flow in radians around Y axis (Sensor RH rotation about the Y axis induces a positive flow. Sensor linear motion along the positive X axis induces a positive flow.)	|	(single)
        integrated_xgyro	%RH rotation around X axis (rad)	|	(single)
        integrated_ygyro	%RH rotation around Y axis (rad)	|	(single)
        integrated_zgyro	%RH rotation around Z axis (rad)	|	(single)
        time_delta_distance_us	%Time in microseconds since the distance was sampled.	|	(uint32)
        distance	%Distance to the center of the flow field in meters. Positive value (including zero): distance known. Negative value: Unknown distance.	|	(single)
        temperature	%Temperature * 100 in centi-degrees Celsius	|	(int16)
        sensor_id	%Sensor ID	|	(uint8)
        quality	%Optical flow quality / confidence. 0: no valid flow, 255: maximum quality	|	(uint8)
    end

    methods

        function obj = msg_hil_optical_flow(packet,time_usec,integration_time_us,integrated_x,integrated_y,integrated_xgyro,integrated_ygyro,integrated_zgyro,time_delta_distance_us,distance,temperature,sensor_id,quality)
        %Create a new hil_optical_flow message
        
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
            
            elseif nargin-1 == 12
                obj.time_usec = time_usec;
                obj.integration_time_us = integration_time_us;
                obj.integrated_x = integrated_x;
                obj.integrated_y = integrated_y;
                obj.integrated_xgyro = integrated_xgyro;
                obj.integrated_ygyro = integrated_ygyro;
                obj.integrated_zgyro = integrated_zgyro;
                obj.time_delta_distance_us = time_delta_distance_us;
                obj.distance = distance;
                obj.temperature = temperature;
                obj.sensor_id = sensor_id;
                obj.quality = quality;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        function packet = pack(obj)
        %PACK: Packs this MAVLINK message into a mavlink_packet
        %Description:
        %    Packs the fields of a message into a mavlink_packet which can be encoded
        %    for transmission.

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_hil_optical_flow.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_hil_optical_flow.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                packet.payload.putUINT32(obj.integration_time_us);
                packet.payload.putSINGLE(obj.integrated_x);
                packet.payload.putSINGLE(obj.integrated_y);
                packet.payload.putSINGLE(obj.integrated_xgyro);
                packet.payload.putSINGLE(obj.integrated_ygyro);
                packet.payload.putSINGLE(obj.integrated_zgyro);
                packet.payload.putUINT32(obj.time_delta_distance_us);
                packet.payload.putSINGLE(obj.distance);
                packet.payload.putINT16(obj.temperature);
                packet.payload.putUINT8(obj.sensor_id);
                packet.payload.putUINT8(obj.quality);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        function unpack(obj, payload)
        %UNPACK: Unpacks a mavlink_payload into this MAVLINK message
        %Description:
        %    Extracts the data from a mavlink_payload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(mavlink_payload): The payload to be unpacked into this MAVLINK message

            payload.resetIndex();
            
            obj.time_usec = payload.getUINT64();
            obj.integration_time_us = payload.getUINT32();
            obj.integrated_x = payload.getSINGLE();
            obj.integrated_y = payload.getSINGLE();
            obj.integrated_xgyro = payload.getSINGLE();
            obj.integrated_ygyro = payload.getSINGLE();
            obj.integrated_zgyro = payload.getSINGLE();
            obj.time_delta_distance_us = payload.getUINT32();
            obj.distance = payload.getSINGLE();
            obj.temperature = payload.getINT16();
            obj.sensor_id = payload.getUINT8();
            obj.quality = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.integration_time_us,2) ~= 1
                result = 'integration_time_us';
            elseif size(obj.integrated_x,2) ~= 1
                result = 'integrated_x';
            elseif size(obj.integrated_y,2) ~= 1
                result = 'integrated_y';
            elseif size(obj.integrated_xgyro,2) ~= 1
                result = 'integrated_xgyro';
            elseif size(obj.integrated_ygyro,2) ~= 1
                result = 'integrated_ygyro';
            elseif size(obj.integrated_zgyro,2) ~= 1
                result = 'integrated_zgyro';
            elseif size(obj.time_delta_distance_us,2) ~= 1
                result = 'time_delta_distance_us';
            elseif size(obj.distance,2) ~= 1
                result = 'distance';
            elseif size(obj.temperature,2) ~= 1
                result = 'temperature';
            elseif size(obj.sensor_id,2) ~= 1
                result = 'sensor_id';
            elseif size(obj.quality,2) ~= 1
                result = 'quality';

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
        
        function set.integration_time_us(obj,value)
            if value == uint32(value)
                obj.integration_time_us = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.integrated_x(obj,value)
            obj.integrated_x = single(value);
        end
        
        function set.integrated_y(obj,value)
            obj.integrated_y = single(value);
        end
        
        function set.integrated_xgyro(obj,value)
            obj.integrated_xgyro = single(value);
        end
        
        function set.integrated_ygyro(obj,value)
            obj.integrated_ygyro = single(value);
        end
        
        function set.integrated_zgyro(obj,value)
            obj.integrated_zgyro = single(value);
        end
        
        function set.time_delta_distance_us(obj,value)
            if value == uint32(value)
                obj.time_delta_distance_us = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.distance(obj,value)
            obj.distance = single(value);
        end
        
        function set.temperature(obj,value)
            if value == int16(value)
                obj.temperature = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.sensor_id(obj,value)
            if value == uint8(value)
                obj.sensor_id = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.quality(obj,value)
            if value == uint8(value)
                obj.quality = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end