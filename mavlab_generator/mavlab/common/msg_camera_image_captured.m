classdef msg_camera_image_captured < mavlink_message
    %MAVLINK Message Class
    %Name: camera_image_captured	ID: 263
    %Description: WIP: Information about a captured image
            
    properties(Constant)
        ID = 263
        LEN = 255
    end
    
    properties        
		time_utc	%Timestamp (microseconds since UNIX epoch) in UTC. 0 for unknown. (uint64[1])
		time_boot_ms	%Timestamp (milliseconds since system boot) (uint32[1])
		lat	%Latitude, expressed as degrees * 1E7 where image was taken (int32[1])
		lon	%Longitude, expressed as degrees * 1E7 where capture was taken (int32[1])
		alt	%Altitude in meters, expressed as * 1E3 (AMSL, not WGS84) where image was taken (int32[1])
		relative_alt	%Altitude above ground in meters, expressed as * 1E3 where image was taken (int32[1])
		q	%Quaternion of camera orientation (w, x, y, z order, zero-rotation is 0, 0, 0, 0) (single[4])
		camera_id	%Camera ID if there are multiple (uint8[1])
		file_path	%File path of image taken. (uint8[210])
	end

    
    methods
        
        %Constructor: msg_camera_image_captured
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_camera_image_captured(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_camera_image_captured.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_camera_image_captured.ID;
                
			packet.payload.putUINT64(obj.time_utc);

			packet.payload.putUINT32(obj.time_boot_ms);

			packet.payload.putINT32(obj.lat);

			packet.payload.putINT32(obj.lon);

			packet.payload.putINT32(obj.alt);

			packet.payload.putINT32(obj.relative_alt);
            
            for i = 1:4
                packet.payload.putSINGLE(obj.q(i));
            end
                            
			packet.payload.putUINT8(obj.camera_id);
            
            for i = 1:210
                packet.payload.putUINT8(obj.file_path(i));
            end
                            
		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_utc = payload.getUINT64();

			obj.time_boot_ms = payload.getUINT32();

			obj.lat = payload.getINT32();

			obj.lon = payload.getINT32();

			obj.alt = payload.getINT32();

			obj.relative_alt = payload.getINT32();
            
            for i = 1:4
                obj.q(i) = payload.getSINGLE();
            end
                            
			obj.camera_id = payload.getUINT8();
            
            for i = 1:210
                obj.file_path(i) = payload.getUINT8();
            end
                            
		end
            
        function set.time_utc(obj,value)
            if value == uint64(value)
                obj.time_utc = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_image_captured.set.time_utc()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                    
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_image_captured.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.lat(obj,value)
            if value == int32(value)
                obj.lat = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_image_captured.set.lat()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.lon(obj,value)
            if value == int32(value)
                obj.lon = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_image_captured.set.lon()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.alt(obj,value)
            if value == int32(value)
                obj.alt = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_image_captured.set.alt()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.relative_alt(obj,value)
            if value == int32(value)
                obj.relative_alt = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_image_captured.set.relative_alt()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                
        function set.q(obj,value)
            obj.q = single(value);
        end
                                    
        function set.camera_id(obj,value)
            if value == uint8(value)
                obj.camera_id = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_image_captured.set.camera_id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.file_path(obj,value)
            if value == uint8(value)
                obj.file_path = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_image_captured.set.file_path()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end