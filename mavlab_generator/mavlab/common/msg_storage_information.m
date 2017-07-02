classdef msg_storage_information < mavlink_message
    %MAVLINK Message Class
    %Name: storage_information	ID: 261
    %Description: WIP: Information about a storage medium
            
    properties(Constant)
        ID = 261
        LEN = 26
    end
    
    properties        
		time_boot_ms	%Timestamp (milliseconds since system boot) (uint32[1])
		total_capacity	%Total capacity in MiB (single[1])
		used_capacity	%Used capacity in MiB (single[1])
		available_capacity	%Available capacity in MiB (single[1])
		read_speed	%Read speed in MiB/s (single[1])
		write_speed	%Write speed in MiB/s (single[1])
		storage_id	%Storage ID if there are multiple (uint8[1])
		status	%Status of storage (0 not available, 1 unformatted, 2 formatted) (uint8[1])
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

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
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
            
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | storage_information.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
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
                fprintf(2,'MAVLAB-ERROR | storage_information.set.storage_id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.status(obj,value)
            if value == uint8(value)
                obj.status = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | storage_information.set.status()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end