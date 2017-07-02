classdef msg_camera_settings < mavlink_message
    %MAVLINK Message Class
    %Name: camera_settings	ID: 260
    %Description: WIP: Settings of a camera, can be requested using MAV_CMD_REQUEST_CAMERA_SETTINGS and written using MAV_CMD_SET_CAMERA_SETTINGS
            
    properties(Constant)
        ID = 260
        LEN = 28
    end
    
    properties        
		time_boot_ms	%Timestamp (milliseconds since system boot) (uint32[1])
		aperture	%Aperture is 1/value (single[1])
		shutter_speed	%Shutter speed in s (single[1])
		iso_sensitivity	%ISO sensitivity (single[1])
		white_balance	%Color temperature in K (single[1])
		camera_id	%Camera ID if there are multiple (uint8[1])
		aperture_locked	%Aperture locked (0: auto, 1: locked) (uint8[1])
		shutter_speed_locked	%Shutter speed locked (0: auto, 1: locked) (uint8[1])
		iso_sensitivity_locked	%ISO sensitivity locked (0: auto, 1: locked) (uint8[1])
		white_balance_locked	%Color temperature locked (0: auto, 1: locked) (uint8[1])
		mode_id	%Reserved for a camera mode ID (uint8[1])
		color_mode_id	%Reserved for a color mode ID (uint8[1])
		image_format_id	%Reserved for image format ID (uint8[1])
	end

    
    methods
        
        %Constructor: msg_camera_settings
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_camera_settings(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
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

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
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
            
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_settings.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
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
                fprintf(2,'MAVLAB-ERROR | camera_settings.set.camera_id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.aperture_locked(obj,value)
            if value == uint8(value)
                obj.aperture_locked = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_settings.set.aperture_locked()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.shutter_speed_locked(obj,value)
            if value == uint8(value)
                obj.shutter_speed_locked = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_settings.set.shutter_speed_locked()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.iso_sensitivity_locked(obj,value)
            if value == uint8(value)
                obj.iso_sensitivity_locked = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_settings.set.iso_sensitivity_locked()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.white_balance_locked(obj,value)
            if value == uint8(value)
                obj.white_balance_locked = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_settings.set.white_balance_locked()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.mode_id(obj,value)
            if value == uint8(value)
                obj.mode_id = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_settings.set.mode_id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.color_mode_id(obj,value)
            if value == uint8(value)
                obj.color_mode_id = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_settings.set.color_mode_id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.image_format_id(obj,value)
            if value == uint8(value)
                obj.image_format_id = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_settings.set.image_format_id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end