classdef msg_local_position_ned_system_global_offset < mavlink_message
    %MAVLINK Message Class
    %Name: local_position_ned_system_global_offset	ID: 89
    %Description: The offset in X, Y, Z and yaw between the LOCAL_POSITION_NED messages of MAV X and the global coordinate frame in NED coordinates. Coordinate frame is right-handed, Z-axis down (aeronautical frame, NED / north-east-down convention)
            
    properties(Constant)
        ID = 89
        LEN = 28
    end
    
    properties        
		time_boot_ms	%Timestamp (milliseconds since system boot) (uint32[1])
		x	%X Position (single[1])
		y	%Y Position (single[1])
		z	%Z Position (single[1])
		roll	%Roll (single[1])
		pitch	%Pitch (single[1])
		yaw	%Yaw (single[1])
	end

    
    methods
        
        %Constructor: msg_local_position_ned_system_global_offset
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_local_position_ned_system_global_offset(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_local_position_ned_system_global_offset.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_local_position_ned_system_global_offset.ID;
                
			packet.payload.putUINT32(obj.time_boot_ms);

			packet.payload.putSINGLE(obj.x);

			packet.payload.putSINGLE(obj.y);

			packet.payload.putSINGLE(obj.z);

			packet.payload.putSINGLE(obj.roll);

			packet.payload.putSINGLE(obj.pitch);

			packet.payload.putSINGLE(obj.yaw);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_boot_ms = payload.getUINT32();

			obj.x = payload.getSINGLE();

			obj.y = payload.getSINGLE();

			obj.z = payload.getSINGLE();

			obj.roll = payload.getSINGLE();

			obj.pitch = payload.getSINGLE();

			obj.yaw = payload.getSINGLE();

		end
            
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | local_position_ned_system_global_offset.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                
        function set.x(obj,value)
            obj.x = single(value);
        end
                                
        function set.y(obj,value)
            obj.y = single(value);
        end
                                
        function set.z(obj,value)
            obj.z = single(value);
        end
                                
        function set.roll(obj,value)
            obj.roll = single(value);
        end
                                
        function set.pitch(obj,value)
            obj.pitch = single(value);
        end
                                
        function set.yaw(obj,value)
            obj.yaw = single(value);
        end
                        
	end
end