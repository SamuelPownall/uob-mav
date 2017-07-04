classdef msg_heartbeat < mavlink_message
    %MAVLINK Message Class
    %Name: heartbeat	ID: 0
    %Description: The heartbeat message shows that a system is present and responding. The type of the MAV and Autopilot hardware allow the receiving system to treat further messages from this system appropriate (e.g. by laying out the user interface based on the autopilot).
            
    properties(Constant)
        ID = 0
        LEN = 9
    end
    
    properties        
		custom_mode	%A bitfield for use for autopilot-specific flags. (uint32)
		type	%Type of the MAV (quadrotor, helicopter, etc., up to 15 types, defined in MAV_TYPE ENUM) (uint8)
		autopilot	%Autopilot type / class. defined in MAV_AUTOPILOT ENUM (uint8)
		base_mode	%System mode bitfield, see MAV_MODE_FLAG ENUM in mavlink/include/mavlink_types.h (uint8)
		system_status	%System status flag, see MAV_STATE ENUM (uint8)
		mavlink_version	%MAVLink version, not writable by user, gets added by protocol because of magic data type: uint8_t_mavlink_version (uint8)
	end
    
    methods
        
        %Constructor: msg_heartbeat
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_heartbeat(packet)
        
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
        
                packet = mavlink_packet(msg_heartbeat.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_heartbeat.ID;
                
				packet.payload.putUINT32(obj.custom_mode);

				packet.payload.putUINT8(obj.type);

				packet.payload.putUINT8(obj.autopilot);

				packet.payload.putUINT8(obj.base_mode);

				packet.payload.putUINT8(obj.system_status);

				packet.payload.putUINT8(obj.mavlink_version);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.custom_mode = payload.getUINT32();

			obj.type = payload.getUINT8();

			obj.autopilot = payload.getUINT8();

			obj.base_mode = payload.getUINT8();

			obj.system_status = payload.getUINT8();

			obj.mavlink_version = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.custom_mode,2) ~= 1
                result = 'custom_mode';                                        
            elseif size(obj.type,2) ~= 1
                result = 'type';                                        
            elseif size(obj.autopilot,2) ~= 1
                result = 'autopilot';                                        
            elseif size(obj.base_mode,2) ~= 1
                result = 'base_mode';                                        
            elseif size(obj.system_status,2) ~= 1
                result = 'system_status';                                        
            elseif size(obj.mavlink_version,2) ~= 1
                result = 'mavlink_version';                            
            else
                result = 0;
            end
            
        end
                                
        function set.custom_mode(obj,value)
            if value == uint32(value)
                obj.custom_mode = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
                                    
        function set.type(obj,value)
            if value == uint8(value)
                obj.type = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.autopilot(obj,value)
            if value == uint8(value)
                obj.autopilot = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.base_mode(obj,value)
            if value == uint8(value)
                obj.base_mode = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.system_status(obj,value)
            if value == uint8(value)
                obj.system_status = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.mavlink_version(obj,value)
            if value == uint8(value)
                obj.mavlink_version = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end