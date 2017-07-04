classdef msg_storage_information < mavlink_message
    %MAVLINK Message Class
    %Name: storage_information	ID: 261
    %Description: WIP: Information about a storage medium
            
    properties(Constant)
        ID = 261
        LEN = 26
    end
    
    properties        
		time_boot_ms	%Timestamp (milliseconds since system boot) (uint32)
		total_capacity	%Total capacity in MiB (single)
		used_capacity	%Used capacity in MiB (single)
		available_capacity	%Available capacity in MiB (single)
		read_speed	%Read speed in MiB/s (single)
		write_speed	%Write speed in MiB/s (single)
		storage_id	%Storage ID if there are multiple (uint8)
		status	%Status of storage (0 not available, 1 unformatted, 2 formatted) (uint8)
	end
    
    methods
        
        %Constructor: msg_storage_information
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_storage_information(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_storage_information.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_storage_information.ID;
                
				packet.payload.putUINT32(obj.time_boot_ms);

				packet.payload.putSINGLE(obj.total_capacity);

				packet.payload.putSINGLE(obj.used_capacity);

				packet.payload.putSINGLE(obj.available_capacity);

				packet.payload.putSINGLE(obj.read_speed);

				packet.payload.putSINGLE(obj.write_speed);

				packet.payload.putUINT8(obj.storage_id);

				packet.payload.putUINT8(obj.status);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_boot_ms = payload.getUINT32();

			obj.total_capacity = payload.getSINGLE();

			obj.used_capacity = payload.getSINGLE();

			obj.available_capacity = payload.getSINGLE();

			obj.read_speed = payload.getSINGLE();

			obj.write_speed = payload.getSINGLE();

			obj.storage_id = payload.getUINT8();

			obj.status = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';                                        
            elseif size(obj.total_capacity,2) ~= 1
                result = 'total_capacity';                                        
            elseif size(obj.used_capacity,2) ~= 1
                result = 'used_capacity';                                        
            elseif size(obj.available_capacity,2) ~= 1
                result = 'available_capacity';                                        
            elseif size(obj.read_speed,2) ~= 1
                result = 'read_speed';                                        
            elseif size(obj.write_speed,2) ~= 1
                result = 'write_speed';                                        
            elseif size(obj.storage_id,2) ~= 1
                result = 'storage_id';                                        
            elseif size(obj.status,2) ~= 1
                result = 'status';                            
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
                                
        function set.total_capacity(obj,value)
            obj.total_capacity = single(value);
        end
                                
        function set.used_capacity(obj,value)
            obj.used_capacity = single(value);
        end
                                
        function set.available_capacity(obj,value)
            obj.available_capacity = single(value);
        end
                                
        function set.read_speed(obj,value)
            obj.read_speed = single(value);
        end
                                
        function set.write_speed(obj,value)
            obj.write_speed = single(value);
        end
                                    
        function set.storage_id(obj,value)
            if value == uint8(value)
                obj.storage_id = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.status(obj,value)
            if value == uint8(value)
                obj.status = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end