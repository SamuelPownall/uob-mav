classdef msg_optical_flow < MAVLinkMessage
	%MSG_OPTICAL_FLOW: MAVLink Message ID = 100
    %Description:
    %    Optical flow from a flow sensor (e.g. optical mouse sensor)
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_usec(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    time_usec(uint64): Timestamp (UNIX)
    %    flow_comp_m_x(single): Flow in meters in x-sensor direction, angular-speed compensated
    %    flow_comp_m_y(single): Flow in meters in y-sensor direction, angular-speed compensated
    %    ground_distance(single): Ground distance in meters. Positive value: distance known. Negative value: Unknown distance
    %    flow_x(int16): Flow in pixels * 10 in x-sensor direction (dezi-pixels)
    %    flow_y(int16): Flow in pixels * 10 in y-sensor direction (dezi-pixels)
    %    sensor_id(uint8): Sensor ID
    %    quality(uint8): Optical flow quality / confidence. 0: bad, 255: maximum quality
	
	properties(Constant)
		ID = 100
		LEN = 26
	end
	
	properties
        time_usec	%Timestamp (UNIX)	|	(uint64)
        flow_comp_m_x	%Flow in meters in x-sensor direction, angular-speed compensated	|	(single)
        flow_comp_m_y	%Flow in meters in y-sensor direction, angular-speed compensated	|	(single)
        ground_distance	%Ground distance in meters. Positive value: distance known. Negative value: Unknown distance	|	(single)
        flow_x	%Flow in pixels * 10 in x-sensor direction (dezi-pixels)	|	(int16)
        flow_y	%Flow in pixels * 10 in y-sensor direction (dezi-pixels)	|	(int16)
        sensor_id	%Sensor ID	|	(uint8)
        quality	%Optical flow quality / confidence. 0: bad, 255: maximum quality	|	(uint8)
    end

    methods(Static)

        function send(out,time_usec,flow_comp_m_x,flow_comp_m_y,ground_distance,flow_x,flow_y,sensor_id,quality,varargin)

            if nargin == 8 + 1
                msg = msg_optical_flow(time_usec,flow_comp_m_x,flow_comp_m_y,ground_distance,flow_x,flow_y,sensor_id,quality,varargin);
            elseif nargin == 2
                msg = msg_optical_flow(time_usec);
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

        function obj = msg_optical_flow(time_usec,flow_comp_m_x,flow_comp_m_y,ground_distance,flow_x,flow_y,sensor_id,quality,varargin)
        %MSG_OPTICAL_FLOW: Create a new optical_flow message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(time_usec,'MAVLinkPacket')
                    packet = time_usec;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('time_usec','MAVLinkPacket');
                end
            elseif nargin >= 8 && isempty(varargin{1})
                obj.time_usec = time_usec;
                obj.flow_comp_m_x = flow_comp_m_x;
                obj.flow_comp_m_y = flow_comp_m_y;
                obj.ground_distance = ground_distance;
                obj.flow_x = flow_x;
                obj.flow_y = flow_y;
                obj.sensor_id = sensor_id;
                obj.quality = quality;
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

                packet = MAVLinkPacket(msg_optical_flow.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_optical_flow.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                packet.payload.putSINGLE(obj.flow_comp_m_x);
                packet.payload.putSINGLE(obj.flow_comp_m_y);
                packet.payload.putSINGLE(obj.ground_distance);
                packet.payload.putINT16(obj.flow_x);
                packet.payload.putINT16(obj.flow_y);
                packet.payload.putUINT8(obj.sensor_id);
                packet.payload.putUINT8(obj.quality);

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
            
            obj.time_usec = payload.getUINT64();
            obj.flow_comp_m_x = payload.getSINGLE();
            obj.flow_comp_m_y = payload.getSINGLE();
            obj.ground_distance = payload.getSINGLE();
            obj.flow_x = payload.getINT16();
            obj.flow_y = payload.getINT16();
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
            elseif size(obj.flow_comp_m_x,2) ~= 1
                result = 'flow_comp_m_x';
            elseif size(obj.flow_comp_m_y,2) ~= 1
                result = 'flow_comp_m_y';
            elseif size(obj.ground_distance,2) ~= 1
                result = 'ground_distance';
            elseif size(obj.flow_x,2) ~= 1
                result = 'flow_x';
            elseif size(obj.flow_y,2) ~= 1
                result = 'flow_y';
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
                MAVLink.throwTypeError('value','uint64');
            end
        end
        
        function set.flow_comp_m_x(obj,value)
            obj.flow_comp_m_x = single(value);
        end
        
        function set.flow_comp_m_y(obj,value)
            obj.flow_comp_m_y = single(value);
        end
        
        function set.ground_distance(obj,value)
            obj.ground_distance = single(value);
        end
        
        function set.flow_x(obj,value)
            if value == int16(value)
                obj.flow_x = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.flow_y(obj,value)
            if value == int16(value)
                obj.flow_y = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.sensor_id(obj,value)
            if value == uint8(value)
                obj.sensor_id = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.quality(obj,value)
            if value == uint8(value)
                obj.quality = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end