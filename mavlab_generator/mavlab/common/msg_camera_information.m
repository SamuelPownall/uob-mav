classdef msg_camera_information < mavlink_message
    %MAVLINK Message Class
    %Name: camera_information	ID: 259
    %Description: WIP: Information about a camera
            
    properties(Constant)
        ID = 259
        LEN = 86
    end
    
    properties        
		time_boot_ms	%Timestamp (milliseconds since system boot) (uint32)
		focal_length	%Focal length in mm (single)
		sensor_size_h	%Image sensor size horizontal in mm (single)
		sensor_size_v	%Image sensor size vertical in mm (single)
		resolution_h	%Image resolution in pixels horizontal (uint16)
		resolution_v	%Image resolution in pixels vertical (uint16)
		camera_id	%Camera ID if there are multiple (uint8)
		vendor_name	%Name of the camera vendor (uint8[32])
		model_name	%Name of the camera model (uint8[32])
		lense_id	%Reserved for a lense ID (uint8)
	end
    
    methods
        
        %Constructor: msg_camera_information
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_camera_information(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            emptyField = obj.verify();
            if emptyField == 0
        
                packet = mavlink_packet(msg_camera_information.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_camera_information.ID;
                
				packet.payload.putUINT32(obj.time_boot_ms);

				packet.payload.putSINGLE(obj.focal_length);

				packet.payload.putSINGLE(obj.sensor_size_h);

				packet.payload.putSINGLE(obj.sensor_size_v);

				packet.payload.putUINT16(obj.resolution_h);

				packet.payload.putUINT16(obj.resolution_v);

				packet.payload.putUINT8(obj.camera_id);
            
                for i = 1:32
                    packet.payload.putUINT8(obj.vendor_name(i));
                end
                                            
                for i = 1:32
                    packet.payload.putUINT8(obj.model_name(i));
                end
                                
				packet.payload.putUINT8(obj.lense_id);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_camera_information.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_boot_ms = payload.getUINT32();

			obj.focal_length = payload.getSINGLE();

			obj.sensor_size_h = payload.getSINGLE();

			obj.sensor_size_v = payload.getSINGLE();

			obj.resolution_h = payload.getUINT16();

			obj.resolution_v = payload.getUINT16();

			obj.camera_id = payload.getUINT8();
            
            for i = 1:32
                obj.vendor_name(i) = payload.getUINT8();
            end
                                        
            for i = 1:32
                obj.model_name(i) = payload.getUINT8();
            end
                            
			obj.lense_id = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_boot_ms,2) ~= 1
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
                fprintf(2,'MAVLAB-ERROR | camera_information.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
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
                fprintf(2,'MAVLAB-ERROR | camera_information.set.resolution_h()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.resolution_v(obj,value)
            if value == uint16(value)
                obj.resolution_v = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_information.set.resolution_v()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.camera_id(obj,value)
            if value == uint8(value)
                obj.camera_id = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_information.set.camera_id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.vendor_name(obj,value)
            if value == uint8(value)
                obj.vendor_name = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_information.set.vendor_name()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.model_name(obj,value)
            if value == uint8(value)
                obj.model_name = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_information.set.model_name()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.lense_id(obj,value)
            if value == uint8(value)
                obj.lense_id = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | camera_information.set.lense_id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end