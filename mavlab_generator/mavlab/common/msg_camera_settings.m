classdef msg_camera_settings < mavlink_message
	%MSG_CAMERA_SETTINGS(packet,time_boot_ms,aperture,shutter_speed,iso_sensitivity,white_balance,camera_id,aperture_locked,shutter_speed_locked,iso_sensitivity_locked,white_balance_locked,mode_id,color_mode_id,image_format_id): MAVLINK Message ID = 260
    %Description:
    %    WIP: Settings of a camera, can be requested using MAV_CMD_REQUEST_CAMERA_SETTINGS and written using MAV_CMD_SET_CAMERA_SETTINGS
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    time_boot_ms(uint32): Timestamp (milliseconds since system boot)
    %    aperture(single): Aperture is 1/value
    %    shutter_speed(single): Shutter speed in s
    %    iso_sensitivity(single): ISO sensitivity
    %    white_balance(single): Color temperature in K
    %    camera_id(uint8): Camera ID if there are multiple
    %    aperture_locked(uint8): Aperture locked (0: auto, 1: locked)
    %    shutter_speed_locked(uint8): Shutter speed locked (0: auto, 1: locked)
    %    iso_sensitivity_locked(uint8): ISO sensitivity locked (0: auto, 1: locked)
    %    white_balance_locked(uint8): Color temperature locked (0: auto, 1: locked)
    %    mode_id(uint8): Reserved for a camera mode ID
    %    color_mode_id(uint8): Reserved for a color mode ID
    %    image_format_id(uint8): Reserved for image format ID
	
	properties(Constant)
		ID = 260
		LEN = 28
	end
	
	properties
        time_boot_ms	%Timestamp (milliseconds since system boot)	|	(uint32)
        aperture	%Aperture is 1/value	|	(single)
        shutter_speed	%Shutter speed in s	|	(single)
        iso_sensitivity	%ISO sensitivity	|	(single)
        white_balance	%Color temperature in K	|	(single)
        camera_id	%Camera ID if there are multiple	|	(uint8)
        aperture_locked	%Aperture locked (0: auto, 1: locked)	|	(uint8)
        shutter_speed_locked	%Shutter speed locked (0: auto, 1: locked)	|	(uint8)
        iso_sensitivity_locked	%ISO sensitivity locked (0: auto, 1: locked)	|	(uint8)
        white_balance_locked	%Color temperature locked (0: auto, 1: locked)	|	(uint8)
        mode_id	%Reserved for a camera mode ID	|	(uint8)
        color_mode_id	%Reserved for a color mode ID	|	(uint8)
        image_format_id	%Reserved for image format ID	|	(uint8)
    end

    methods

        %Constructor: msg_camera_settings
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_camera_settings(packet,time_boot_ms,aperture,shutter_speed,iso_sensitivity,white_balance,camera_id,aperture_locked,shutter_speed_locked,iso_sensitivity_locked,white_balance_locked,mode_id,color_mode_id,image_format_id)
        
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
            
            elseif nargin-1 == 13
                obj.time_boot_ms = time_boot_ms;
                obj.aperture = aperture;
                obj.shutter_speed = shutter_speed;
                obj.iso_sensitivity = iso_sensitivity;
                obj.white_balance = white_balance;
                obj.camera_id = camera_id;
                obj.aperture_locked = aperture_locked;
                obj.shutter_speed_locked = shutter_speed_locked;
                obj.iso_sensitivity_locked = iso_sensitivity_locked;
                obj.white_balance_locked = white_balance_locked;
                obj.mode_id = mode_id;
                obj.color_mode_id = color_mode_id;
                obj.image_format_id = image_format_id;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_camera_settings.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_camera_settings.ID;
                
                packet.payload.putUINT32(obj.time_boot_ms);
                packet.payload.putSINGLE(obj.aperture);
                packet.payload.putSINGLE(obj.shutter_speed);
                packet.payload.putSINGLE(obj.iso_sensitivity);
                packet.payload.putSINGLE(obj.white_balance);
                packet.payload.putUINT8(obj.camera_id);
                packet.payload.putUINT8(obj.aperture_locked);
                packet.payload.putUINT8(obj.shutter_speed_locked);
                packet.payload.putUINT8(obj.iso_sensitivity_locked);
                packet.payload.putUINT8(obj.white_balance_locked);
                packet.payload.putUINT8(obj.mode_id);
                packet.payload.putUINT8(obj.color_mode_id);
                packet.payload.putUINT8(obj.image_format_id);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.time_boot_ms = payload.getUINT32();
            obj.aperture = payload.getSINGLE();
            obj.shutter_speed = payload.getSINGLE();
            obj.iso_sensitivity = payload.getSINGLE();
            obj.white_balance = payload.getSINGLE();
            obj.camera_id = payload.getUINT8();
            obj.aperture_locked = payload.getUINT8();
            obj.shutter_speed_locked = payload.getUINT8();
            obj.iso_sensitivity_locked = payload.getUINT8();
            obj.white_balance_locked = payload.getUINT8();
            obj.mode_id = payload.getUINT8();
            obj.color_mode_id = payload.getUINT8();
            obj.image_format_id = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';
            elseif size(obj.aperture,2) ~= 1
                result = 'aperture';
            elseif size(obj.shutter_speed,2) ~= 1
                result = 'shutter_speed';
            elseif size(obj.iso_sensitivity,2) ~= 1
                result = 'iso_sensitivity';
            elseif size(obj.white_balance,2) ~= 1
                result = 'white_balance';
            elseif size(obj.camera_id,2) ~= 1
                result = 'camera_id';
            elseif size(obj.aperture_locked,2) ~= 1
                result = 'aperture_locked';
            elseif size(obj.shutter_speed_locked,2) ~= 1
                result = 'shutter_speed_locked';
            elseif size(obj.iso_sensitivity_locked,2) ~= 1
                result = 'iso_sensitivity_locked';
            elseif size(obj.white_balance_locked,2) ~= 1
                result = 'white_balance_locked';
            elseif size(obj.mode_id,2) ~= 1
                result = 'mode_id';
            elseif size(obj.color_mode_id,2) ~= 1
                result = 'color_mode_id';
            elseif size(obj.image_format_id,2) ~= 1
                result = 'image_format_id';

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
        
        function set.aperture(obj,value)
            obj.aperture = single(value);
        end
        
        function set.shutter_speed(obj,value)
            obj.shutter_speed = single(value);
        end
        
        function set.iso_sensitivity(obj,value)
            obj.iso_sensitivity = single(value);
        end
        
        function set.white_balance(obj,value)
            obj.white_balance = single(value);
        end
        
        function set.camera_id(obj,value)
            if value == uint8(value)
                obj.camera_id = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.aperture_locked(obj,value)
            if value == uint8(value)
                obj.aperture_locked = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.shutter_speed_locked(obj,value)
            if value == uint8(value)
                obj.shutter_speed_locked = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.iso_sensitivity_locked(obj,value)
            if value == uint8(value)
                obj.iso_sensitivity_locked = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.white_balance_locked(obj,value)
            if value == uint8(value)
                obj.white_balance_locked = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.mode_id(obj,value)
            if value == uint8(value)
                obj.mode_id = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.color_mode_id(obj,value)
            if value == uint8(value)
                obj.color_mode_id = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.image_format_id(obj,value)
            if value == uint8(value)
                obj.image_format_id = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end