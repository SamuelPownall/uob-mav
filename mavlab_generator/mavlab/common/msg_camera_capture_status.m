classdef msg_camera_capture_status < mavlink_message
	%MSG_CAMERA_CAPTURE_STATUS: MAVLINK Message ID = 262
    %Description:
    %    WIP: Information about the status of a capture
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
    %    time_boot_ms(uint32): Timestamp (milliseconds since system boot)
    %    image_interval(single): Image capture interval in seconds
    %    video_framerate(single): Video frame rate in Hz
    %    image_resolution_h(uint16): Image resolution in pixels horizontal
    %    image_resolution_v(uint16): Image resolution in pixels vertical
    %    video_resolution_h(uint16): Video resolution in pixels horizontal
    %    video_resolution_v(uint16): Video resolution in pixels vertical
    %    camera_id(uint8): Camera ID if there are multiple
    %    image_status(uint8): Current status of image capturing (0: not running, 1: interval capture in progress)
    %    video_status(uint8): Current status of video capturing (0: not running, 1: capture in progress)
	
	properties(Constant)
		ID = 262
		LEN = 23
	end
	
	properties
        time_boot_ms	%Timestamp (milliseconds since system boot)	|	(uint32)
        image_interval	%Image capture interval in seconds	|	(single)
        video_framerate	%Video frame rate in Hz	|	(single)
        image_resolution_h	%Image resolution in pixels horizontal	|	(uint16)
        image_resolution_v	%Image resolution in pixels vertical	|	(uint16)
        video_resolution_h	%Video resolution in pixels horizontal	|	(uint16)
        video_resolution_v	%Video resolution in pixels vertical	|	(uint16)
        camera_id	%Camera ID if there are multiple	|	(uint8)
        image_status	%Current status of image capturing (0: not running, 1: interval capture in progress)	|	(uint8)
        video_status	%Current status of video capturing (0: not running, 1: capture in progress)	|	(uint8)
    end

    methods

        function obj = msg_camera_capture_status(packet,time_boot_ms,image_interval,video_framerate,image_resolution_h,image_resolution_v,video_resolution_h,video_resolution_v,camera_id,image_status,video_status)
        %Create a new camera_capture_status message
        
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
            
            elseif nargin-1 == 10
                obj.time_boot_ms = time_boot_ms;
                obj.image_interval = image_interval;
                obj.video_framerate = video_framerate;
                obj.image_resolution_h = image_resolution_h;
                obj.image_resolution_v = image_resolution_v;
                obj.video_resolution_h = video_resolution_h;
                obj.video_resolution_v = video_resolution_v;
                obj.camera_id = camera_id;
                obj.image_status = image_status;
                obj.video_status = video_status;
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

                packet = mavlink_packet(msg_camera_capture_status.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_camera_capture_status.ID;
                
                packet.payload.putUINT32(obj.time_boot_ms);
                packet.payload.putSINGLE(obj.image_interval);
                packet.payload.putSINGLE(obj.video_framerate);
                packet.payload.putUINT16(obj.image_resolution_h);
                packet.payload.putUINT16(obj.image_resolution_v);
                packet.payload.putUINT16(obj.video_resolution_h);
                packet.payload.putUINT16(obj.video_resolution_v);
                packet.payload.putUINT8(obj.camera_id);
                packet.payload.putUINT8(obj.image_status);
                packet.payload.putUINT8(obj.video_status);

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
            
            obj.time_boot_ms = payload.getUINT32();
            obj.image_interval = payload.getSINGLE();
            obj.video_framerate = payload.getSINGLE();
            obj.image_resolution_h = payload.getUINT16();
            obj.image_resolution_v = payload.getUINT16();
            obj.video_resolution_h = payload.getUINT16();
            obj.video_resolution_v = payload.getUINT16();
            obj.camera_id = payload.getUINT8();
            obj.image_status = payload.getUINT8();
            obj.video_status = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';
            elseif size(obj.image_interval,2) ~= 1
                result = 'image_interval';
            elseif size(obj.video_framerate,2) ~= 1
                result = 'video_framerate';
            elseif size(obj.image_resolution_h,2) ~= 1
                result = 'image_resolution_h';
            elseif size(obj.image_resolution_v,2) ~= 1
                result = 'image_resolution_v';
            elseif size(obj.video_resolution_h,2) ~= 1
                result = 'video_resolution_h';
            elseif size(obj.video_resolution_v,2) ~= 1
                result = 'video_resolution_v';
            elseif size(obj.camera_id,2) ~= 1
                result = 'camera_id';
            elseif size(obj.image_status,2) ~= 1
                result = 'image_status';
            elseif size(obj.video_status,2) ~= 1
                result = 'video_status';

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
        
        function set.image_interval(obj,value)
            obj.image_interval = single(value);
        end
        
        function set.video_framerate(obj,value)
            obj.video_framerate = single(value);
        end
        
        function set.image_resolution_h(obj,value)
            if value == uint16(value)
                obj.image_resolution_h = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.image_resolution_v(obj,value)
            if value == uint16(value)
                obj.image_resolution_v = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.video_resolution_h(obj,value)
            if value == uint16(value)
                obj.video_resolution_h = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.video_resolution_v(obj,value)
            if value == uint16(value)
                obj.video_resolution_v = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.camera_id(obj,value)
            if value == uint8(value)
                obj.camera_id = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.image_status(obj,value)
            if value == uint8(value)
                obj.image_status = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.video_status(obj,value)
            if value == uint8(value)
                obj.video_status = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end