classdef msg_camera_capture_status < mavlink_message
    %MAVLINK Message Class
    %Name: camera_capture_status	ID: 262
    %Description: WIP: Information about the status of a capture
            
    properties(Constant)
        ID = 262
        LEN = 23
    end
    
    properties        
		time_boot_ms	%Timestamp (milliseconds since system boot) (uint32[1])
		image_interval	%Image capture interval in seconds (single[1])
		video_framerate	%Video frame rate in Hz (single[1])
		image_resolution_h	%Image resolution in pixels horizontal (uint16[1])
		image_resolution_v	%Image resolution in pixels vertical (uint16[1])
		video_resolution_h	%Video resolution in pixels horizontal (uint16[1])
		video_resolution_v	%Video resolution in pixels vertical (uint16[1])
		camera_id	%Camera ID if there are multiple (uint8[1])
		image_status	%Current status of image capturing (0: not running, 1: interval capture in progress) (uint8[1])
		video_status	%Current status of video capturing (0: not running, 1: capture in progress) (uint8[1])
	end

    
    methods
        
        %Constructor: msg_camera_capture_status
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_camera_capture_status(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
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

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
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
            
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_capture_status.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
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
                fprintf(2,'MAVLAB-ERROR | camera_capture_status.set.image_resolution_h()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.image_resolution_v(obj,value)
            if value == uint16(value)
                obj.image_resolution_v = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_capture_status.set.image_resolution_v()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.video_resolution_h(obj,value)
            if value == uint16(value)
                obj.video_resolution_h = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_capture_status.set.video_resolution_h()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.video_resolution_v(obj,value)
            if value == uint16(value)
                obj.video_resolution_v = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_capture_status.set.video_resolution_v()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.camera_id(obj,value)
            if value == uint8(value)
                obj.camera_id = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_capture_status.set.camera_id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.image_status(obj,value)
            if value == uint8(value)
                obj.image_status = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_capture_status.set.image_status()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.video_status(obj,value)
            if value == uint8(value)
                obj.video_status = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_capture_status.set.video_status()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end