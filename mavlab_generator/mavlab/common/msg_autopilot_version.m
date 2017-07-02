classdef msg_autopilot_version < mavlink_message
    %MAVLINK Message Class
    %Name: autopilot_version	ID: 148
    %Description: Version and capability of autopilot software
            
    properties(Constant)
        ID = 148
        LEN = 60
    end
    
    properties        
		capabilities	%bitmask of capabilities (see MAV_PROTOCOL_CAPABILITY enum) (uint64[1])
		uid	%UID if provided by hardware (uint64[1])
		flight_sw_version	%Firmware version number (uint32[1])
		middleware_sw_version	%Middleware version number (uint32[1])
		os_sw_version	%Operating system version number (uint32[1])
		board_version	%HW / board version (last 8 bytes should be silicon ID, if any) (uint32[1])
		vendor_id	%ID of the board vendor (uint16[1])
		product_id	%ID of the product (uint16[1])
		flight_custom_version	%Custom version field, commonly the first 8 bytes of the git hash. This is not an unique identifier, but should allow to identify the commit using the main version number even for very large code bases. (uint8[8])
		middleware_custom_version	%Custom version field, commonly the first 8 bytes of the git hash. This is not an unique identifier, but should allow to identify the commit using the main version number even for very large code bases. (uint8[8])
		os_custom_version	%Custom version field, commonly the first 8 bytes of the git hash. This is not an unique identifier, but should allow to identify the commit using the main version number even for very large code bases. (uint8[8])
	end

    
    methods
        
        %Constructor: msg_autopilot_version
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_autopilot_version(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_autopilot_version.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_autopilot_version.ID;
                
			packet.payload.putUINT64(obj.capabilities);

			packet.payload.putUINT64(obj.uid);

			packet.payload.putUINT32(obj.flight_sw_version);

			packet.payload.putUINT32(obj.middleware_sw_version);

			packet.payload.putUINT32(obj.os_sw_version);

			packet.payload.putUINT32(obj.board_version);

			packet.payload.putUINT16(obj.vendor_id);

			packet.payload.putUINT16(obj.product_id);
            
            for i = 1:8
                packet.payload.putUINT8(obj.flight_custom_version(i));
            end
                                        
            for i = 1:8
                packet.payload.putUINT8(obj.middleware_custom_version(i));
            end
                                        
            for i = 1:8
                packet.payload.putUINT8(obj.os_custom_version(i));
            end
                            
		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.capabilities = payload.getUINT64();

			obj.uid = payload.getUINT64();

			obj.flight_sw_version = payload.getUINT32();

			obj.middleware_sw_version = payload.getUINT32();

			obj.os_sw_version = payload.getUINT32();

			obj.board_version = payload.getUINT32();

			obj.vendor_id = payload.getUINT16();

			obj.product_id = payload.getUINT16();
            
            for i = 1:8
                obj.flight_custom_version(i) = payload.getUINT8();
            end
                                        
            for i = 1:8
                obj.middleware_custom_version(i) = payload.getUINT8();
            end
                                        
            for i = 1:8
                obj.os_custom_version(i) = payload.getUINT8();
            end
                            
		end
            
        function set.capabilities(obj,value)
            if value == uint64(value)
                obj.capabilities = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | autopilot_version.set.capabilities()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                    
        function set.uid(obj,value)
            if value == uint64(value)
                obj.uid = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | autopilot_version.set.uid()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                    
        function set.flight_sw_version(obj,value)
            if value == uint32(value)
                obj.flight_sw_version = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | autopilot_version.set.flight_sw_version()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.middleware_sw_version(obj,value)
            if value == uint32(value)
                obj.middleware_sw_version = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | autopilot_version.set.middleware_sw_version()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.os_sw_version(obj,value)
            if value == uint32(value)
                obj.os_sw_version = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | autopilot_version.set.os_sw_version()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.board_version(obj,value)
            if value == uint32(value)
                obj.board_version = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | autopilot_version.set.board_version()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.vendor_id(obj,value)
            if value == uint16(value)
                obj.vendor_id = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | autopilot_version.set.vendor_id()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.product_id(obj,value)
            if value == uint16(value)
                obj.product_id = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | autopilot_version.set.product_id()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.flight_custom_version(obj,value)
            if value == uint8(value)
                obj.flight_custom_version = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | autopilot_version.set.flight_custom_version()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.middleware_custom_version(obj,value)
            if value == uint8(value)
                obj.middleware_custom_version = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | autopilot_version.set.middleware_custom_version()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.os_custom_version(obj,value)
            if value == uint8(value)
                obj.os_custom_version = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | autopilot_version.set.os_custom_version()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end