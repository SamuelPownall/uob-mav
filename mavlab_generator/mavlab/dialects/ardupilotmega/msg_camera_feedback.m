classdef msg_camera_feedback < MAVLinkMessage
	%MSG_CAMERA_FEEDBACK: MAVLink Message ID = 180
    %Description:
    %    Camera Capture Feedback
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_usec(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    time_usec(uint64): Image timestamp (microseconds since UNIX epoch), as passed in by CAMERA_STATUS message (or autopilot if no CCB)
    %    lat(int32): Latitude in (deg * 1E7)
    %    lng(int32): Longitude in (deg * 1E7)
    %    alt_msl(single): Altitude Absolute (meters AMSL)
    %    alt_rel(single): Altitude Relative (meters above HOME location)
    %    roll(single): Camera Roll angle (earth frame, degrees, +-180)
    %    pitch(single): Camera Pitch angle (earth frame, degrees, +-180)
    %    yaw(single): Camera Yaw (earth frame, degrees, 0-360, true)
    %    foc_len(single): Focal Length (mm)
    %    img_idx(uint16): Image index
    %    target_system(uint8): System ID
    %    cam_idx(uint8): Camera ID
    %    flags(uint8): See CAMERA_FEEDBACK_FLAGS enum for definition of the bitmask
	
	properties(Constant)
		ID = 180
		LEN = 45
	end
	
	properties
        time_usec	%Image timestamp (microseconds since UNIX epoch), as passed in by CAMERA_STATUS message (or autopilot if no CCB)	|	(uint64)
        lat	%Latitude in (deg * 1E7)	|	(int32)
        lng	%Longitude in (deg * 1E7)	|	(int32)
        alt_msl	%Altitude Absolute (meters AMSL)	|	(single)
        alt_rel	%Altitude Relative (meters above HOME location)	|	(single)
        roll	%Camera Roll angle (earth frame, degrees, +-180)	|	(single)
        pitch	%Camera Pitch angle (earth frame, degrees, +-180)	|	(single)
        yaw	%Camera Yaw (earth frame, degrees, 0-360, true)	|	(single)
        foc_len	%Focal Length (mm)	|	(single)
        img_idx	%Image index	|	(uint16)
        target_system	%System ID	|	(uint8)
        cam_idx	%Camera ID	|	(uint8)
        flags	%See CAMERA_FEEDBACK_FLAGS enum for definition of the bitmask	|	(uint8)
    end

    methods(Static)

        function send(out,time_usec,lat,lng,alt_msl,alt_rel,roll,pitch,yaw,foc_len,img_idx,target_system,cam_idx,flags,varargin)

            if nargin == 13 + 1
                msg = msg_camera_feedback(time_usec,lat,lng,alt_msl,alt_rel,roll,pitch,yaw,foc_len,img_idx,target_system,cam_idx,flags,varargin);
            elseif nargin == 2
                msg = msg_camera_feedback(time_usec);
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

        function obj = msg_camera_feedback(time_usec,lat,lng,alt_msl,alt_rel,roll,pitch,yaw,foc_len,img_idx,target_system,cam_idx,flags,varargin)
        %MSG_CAMERA_FEEDBACK: Create a new camera_feedback message object
        
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
            elseif nargin >= 13 && isempty(varargin{1})
                obj.time_usec = time_usec;
                obj.lat = lat;
                obj.lng = lng;
                obj.alt_msl = alt_msl;
                obj.alt_rel = alt_rel;
                obj.roll = roll;
                obj.pitch = pitch;
                obj.yaw = yaw;
                obj.foc_len = foc_len;
                obj.img_idx = img_idx;
                obj.target_system = target_system;
                obj.cam_idx = cam_idx;
                obj.flags = flags;
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

                packet = MAVLinkPacket(msg_camera_feedback.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_camera_feedback.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                packet.payload.putINT32(obj.lat);
                packet.payload.putINT32(obj.lng);
                packet.payload.putSINGLE(obj.alt_msl);
                packet.payload.putSINGLE(obj.alt_rel);
                packet.payload.putSINGLE(obj.roll);
                packet.payload.putSINGLE(obj.pitch);
                packet.payload.putSINGLE(obj.yaw);
                packet.payload.putSINGLE(obj.foc_len);
                packet.payload.putUINT16(obj.img_idx);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.cam_idx);
                packet.payload.putUINT8(obj.flags);

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
            obj.lat = payload.getINT32();
            obj.lng = payload.getINT32();
            obj.alt_msl = payload.getSINGLE();
            obj.alt_rel = payload.getSINGLE();
            obj.roll = payload.getSINGLE();
            obj.pitch = payload.getSINGLE();
            obj.yaw = payload.getSINGLE();
            obj.foc_len = payload.getSINGLE();
            obj.img_idx = payload.getUINT16();
            obj.target_system = payload.getUINT8();
            obj.cam_idx = payload.getUINT8();
            obj.flags = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.lat,2) ~= 1
                result = 'lat';
            elseif size(obj.lng,2) ~= 1
                result = 'lng';
            elseif size(obj.alt_msl,2) ~= 1
                result = 'alt_msl';
            elseif size(obj.alt_rel,2) ~= 1
                result = 'alt_rel';
            elseif size(obj.roll,2) ~= 1
                result = 'roll';
            elseif size(obj.pitch,2) ~= 1
                result = 'pitch';
            elseif size(obj.yaw,2) ~= 1
                result = 'yaw';
            elseif size(obj.foc_len,2) ~= 1
                result = 'foc_len';
            elseif size(obj.img_idx,2) ~= 1
                result = 'img_idx';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.cam_idx,2) ~= 1
                result = 'cam_idx';
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
                MAVLink.throwTypeError('value','uint64');
            end
        end
        
        function set.lat(obj,value)
            if value == int32(value)
                obj.lat = int32(value);
            else
                MAVLink.throwTypeError('value','int32');
            end
        end
        
        function set.lng(obj,value)
            if value == int32(value)
                obj.lng = int32(value);
            else
                MAVLink.throwTypeError('value','int32');
            end
        end
        
        function set.alt_msl(obj,value)
            obj.alt_msl = single(value);
        end
        
        function set.alt_rel(obj,value)
            obj.alt_rel = single(value);
        end
        
        function set.roll(obj,value)
            obj.roll = single(value);
        end
        
        function set.pitch(obj,value)
            obj.pitch = single(value);
        end
        
        function set.yaw(obj,value)
            obj.yaw = single(value);
        end
        
        function set.foc_len(obj,value)
            obj.foc_len = single(value);
        end
        
        function set.img_idx(obj,value)
            if value == uint16(value)
                obj.img_idx = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.cam_idx(obj,value)
            if value == uint8(value)
                obj.cam_idx = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.flags(obj,value)
            if value == uint8(value)
                obj.flags = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end