classdef msg_landing_target < MAVLinkMessage
	%MSG_LANDING_TARGET: MAVLink Message ID = 149
    %Description:
    %    The location of a landing area captured from a downward facing camera
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_usec(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    time_usec(uint64): Timestamp (micros since boot or Unix epoch)
    %    angle_x(single): X-axis angular offset (in radians) of the target from the center of the image
    %    angle_y(single): Y-axis angular offset (in radians) of the target from the center of the image
    %    distance(single): Distance to the target from the vehicle in meters
    %    size_x(single): Size in radians of target along x-axis
    %    size_y(single): Size in radians of target along y-axis
    %    target_num(uint8): The ID of the target if multiple targets are present
    %    frame(uint8): MAV_FRAME enum specifying the whether the following feilds are earth-frame, body-frame, etc.
	
	properties(Constant)
		ID = 149
		LEN = 30
	end
	
	properties
        time_usec	%Timestamp (micros since boot or Unix epoch)	|	(uint64)
        angle_x	%X-axis angular offset (in radians) of the target from the center of the image	|	(single)
        angle_y	%Y-axis angular offset (in radians) of the target from the center of the image	|	(single)
        distance	%Distance to the target from the vehicle in meters	|	(single)
        size_x	%Size in radians of target along x-axis	|	(single)
        size_y	%Size in radians of target along y-axis	|	(single)
        target_num	%The ID of the target if multiple targets are present	|	(uint8)
        frame	%MAV_FRAME enum specifying the whether the following feilds are earth-frame, body-frame, etc.	|	(uint8)
    end

    methods(Static)

        function send(out,time_usec,angle_x,angle_y,distance,size_x,size_y,target_num,frame,varargin)

            if nargin == 8 + 1
                msg = msg_landing_target(time_usec,angle_x,angle_y,distance,size_x,size_y,target_num,frame,varargin);
            elseif nargin == 2
                msg = msg_landing_target(time_usec);
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

        function obj = msg_landing_target(time_usec,angle_x,angle_y,distance,size_x,size_y,target_num,frame,varargin)
        %MSG_LANDING_TARGET: Create a new landing_target message object
        
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
                obj.angle_x = angle_x;
                obj.angle_y = angle_y;
                obj.distance = distance;
                obj.size_x = size_x;
                obj.size_y = size_y;
                obj.target_num = target_num;
                obj.frame = frame;
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

                packet = MAVLinkPacket(msg_landing_target.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_landing_target.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                packet.payload.putSINGLE(obj.angle_x);
                packet.payload.putSINGLE(obj.angle_y);
                packet.payload.putSINGLE(obj.distance);
                packet.payload.putSINGLE(obj.size_x);
                packet.payload.putSINGLE(obj.size_y);
                packet.payload.putUINT8(obj.target_num);
                packet.payload.putUINT8(obj.frame);

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
            obj.angle_x = payload.getSINGLE();
            obj.angle_y = payload.getSINGLE();
            obj.distance = payload.getSINGLE();
            obj.size_x = payload.getSINGLE();
            obj.size_y = payload.getSINGLE();
            obj.target_num = payload.getUINT8();
            obj.frame = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.angle_x,2) ~= 1
                result = 'angle_x';
            elseif size(obj.angle_y,2) ~= 1
                result = 'angle_y';
            elseif size(obj.distance,2) ~= 1
                result = 'distance';
            elseif size(obj.size_x,2) ~= 1
                result = 'size_x';
            elseif size(obj.size_y,2) ~= 1
                result = 'size_y';
            elseif size(obj.target_num,2) ~= 1
                result = 'target_num';
            elseif size(obj.frame,2) ~= 1
                result = 'frame';

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
        
        function set.angle_x(obj,value)
            obj.angle_x = single(value);
        end
        
        function set.angle_y(obj,value)
            obj.angle_y = single(value);
        end
        
        function set.distance(obj,value)
            obj.distance = single(value);
        end
        
        function set.size_x(obj,value)
            obj.size_x = single(value);
        end
        
        function set.size_y(obj,value)
            obj.size_y = single(value);
        end
        
        function set.target_num(obj,value)
            if value == uint8(value)
                obj.target_num = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.frame(obj,value)
            if value == uint8(value)
                obj.frame = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end