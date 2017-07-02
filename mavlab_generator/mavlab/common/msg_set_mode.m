classdef msg_set_mode < mavlink_message
    %MAVLINK Message Class
    %Name: set_mode	ID: 11
    %Description: THIS INTERFACE IS DEPRECATED. USE COMMAND_LONG with MAV_CMD_DO_SET_MODE INSTEAD. Set the system mode, as defined by enum MAV_MODE. There is no target component id as the mode is by definition for the overall aircraft, not only for one component.
            
    properties(Constant)
        ID = 11
        LEN = 6
    end
    
    properties        
		custom_mode	%The new autopilot-specific mode. This field can be ignored by an autopilot. (uint32[1])
		target_system	%The system setting the mode (uint8[1])
		base_mode	%The new base mode (uint8[1])
	end

    
    methods
        
        %Constructor: msg_set_mode
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_set_mode(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_set_mode.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_set_mode.ID;
                
			packet.payload.putUINT32(obj.custom_mode);

			packet.payload.putUINT8(obj.target_system);

			packet.payload.putUINT8(obj.base_mode);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.custom_mode = payload.getUINT32();

			obj.target_system = payload.getUINT8();

			obj.base_mode = payload.getUINT8();

		end
            
        function set.custom_mode(obj,value)
            if value == uint32(value)
                obj.custom_mode = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | set_mode.set.custom_mode()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | set_mode.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.base_mode(obj,value)
            if value == uint8(value)
                obj.base_mode = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | set_mode.set.base_mode()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end