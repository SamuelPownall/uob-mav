classdef msg_camera_information < MAVLinkMessage
	%MSG_CAMERA_INFORMATION: MAVLink Message ID = 259
    %Description:
    %    WIP: Information about a camera
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_boot_ms(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    time_boot_ms(uint32): Timestamp (milliseconds since system boot)
    %    focal_length(single): Focal length in mm
    %    sensor_size_h(single): Image sensor size horizontal in mm
    %    sensor_size_v(single): Image sensor size vertical in mm
    %    resolution_h(uint16): Image resolution in pixels horizontal
    %    resolution_v(uint16): Image resolution in pixels vertical
    %    camera_id(uint8): Camera ID if there are multiple
    %    vendor_name(uint8[32]): Name of the camera vendor
    %    model_name(uint8[32]): Name of the camera model
    %    lense_id(uint8): Reserved for a lense ID
	
	properties(Constant)
		ID = 259
		LEN = 86
	end
	
	properties
        time_boot_ms	%Timestamp (milliseconds since system boot)	|	(uint32)
        focal_length	%Focal length in mm	|	(single)
        sensor_size_h	%Image sensor size horizontal in mm	|	(single)
        sensor_size_v	%Image sensor size vertical in mm	|	(single)
        resolution_h	%Image resolution in pixels horizontal	|	(uint16)
        resolution_v	%Image resolution in pixels vertical	|	(uint16)
        camera_id	%Camera ID if there are multiple	|	(uint8)
        vendor_name	%Name of the camera vendor	|	(uint8[32])
        model_name	%Name of the camera model	|	(uint8[32])
        lense_id	%Reserved for a lense ID	|	(uint8)
    end

    methods(Static)

        function send(out,time_boot_ms,focal_length,sensor_size_h,sensor_size_v,resolution_h,resolution_v,camera_id,vendor_name,model_name,lense_id,varargin)

            if nargin == 10 + 1
                msg = msg_camera_information(time_boot_ms,focal_length,sensor_size_h,sensor_size_v,resolution_h,resolution_v,camera_id,vendor_name,model_name,lense_id,varargin);
            elseif nargin == 2
                msg = msg_camera_information(time_boot_ms);
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

        function obj = msg_camera_information(time_boot_ms,focal_length,sensor_size_h,sensor_size_v,resolution_h,resolution_v,camera_id,vendor_name,model_name,lense_id,varargin)
        %MSG_CAMERA_INFORMATION: Create a new camera_information message object
        
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
            elseif nargin >= 10 && isempty(varargin{1})
                obj.time_boot_ms = time_boot_ms;
                obj.focal_length = focal_length;
                obj.sensor_size_h = sensor_size_h;
                obj.sensor_size_v = sensor_size_v;
                obj.resolution_h = resolution_h;
                obj.resolution_v = resolution_v;
                obj.camera_id = camera_id;
                obj.vendor_name = vendor_name;
                obj.model_name = model_name;
                obj.lense_id = lense_id;
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

                packet = MAVLinkPacket(msg_camera_information.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_camera_information.ID;
                
                packet.payload.putUINT32(obj.time_boot_ms);
                packet.payload.putSINGLE(obj.focal_length);
                packet.payload.putSINGLE(obj.sensor_size_h);
                packet.payload.putSINGLE(obj.sensor_size_v);
                packet.payload.putUINT16(obj.resolution_h);
                packet.payload.putUINT16(obj.resolution_v);
                packet.payload.putUINT8(obj.camera_id);
                for i=1:1:32
                    packet.payload.putUINT8(obj.vendor_name(i));
                end
                for i=1:1:32
                    packet.payload.putUINT8(obj.model_name(i));
                end
                packet.payload.putUINT8(obj.lense_id);

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
            obj.focal_length = payload.getSINGLE();
            obj.sensor_size_h = payload.getSINGLE();
            obj.sensor_size_v = payload.getSINGLE();
            obj.resolution_h = payload.getUINT16();
            obj.resolution_v = payload.getUINT16();
            obj.camera_id = payload.getUINT8();
            for i=1:1:32
                obj.vendor_name(i) = payload.getUINT8();
            end
            for i=1:1:32
                obj.model_name(i) = payload.getUINT8();
            end
            obj.lense_id = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';
            elseif size(obj.focal_length,2) ~= 1
                result = 'focal_length';
            elseif size(obj.sensor_size_h,2) ~= 1
                result = 'sensor_size_h';
            elseif size(obj.sensor_size_v,2) ~= 1
                result = 'sensor_size_v';
            elseif size(obj.resolution_h,2) ~= 1
                result = 'resolution_h';
            elseif size(obj.resolution_v,2) ~= 1
                result = 'resolution_v';
            elseif size(obj.camera_id,2) ~= 1
                result = 'camera_id';
            elseif size(obj.vendor_name,2) ~= 32
                result = 'vendor_name';
            elseif size(obj.model_name,2) ~= 32
                result = 'model_name';
            elseif size(obj.lense_id,2) ~= 1
                result = 'lense_id';

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
        
        function set.focal_length(obj,value)
            obj.focal_length = single(value);
        end
        
        function set.sensor_size_h(obj,value)
            obj.sensor_size_h = single(value);
        end
        
        function set.sensor_size_v(obj,value)
            obj.sensor_size_v = single(value);
        end
        
        function set.resolution_h(obj,value)
            if value == uint16(value)
                obj.resolution_h = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.resolution_v(obj,value)
            if value == uint16(value)
                obj.resolution_v = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.camera_id(obj,value)
            if value == uint8(value)
                obj.camera_id = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.vendor_name(obj,value)
            if value == uint8(value)
                obj.vendor_name = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.model_name(obj,value)
            if value == uint8(value)
                obj.model_name = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.lense_id(obj,value)
            if value == uint8(value)
                obj.lense_id = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end