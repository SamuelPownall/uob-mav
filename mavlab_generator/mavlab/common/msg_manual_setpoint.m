classdef msg_manual_setpoint < mavlink_message
    %MAVLINK Message Class
    %Name: manual_setpoint	ID: 81
    %Description: Setpoint in roll, pitch, yaw and thrust from the operator
            
    properties(Constant)
        ID = 81
        LEN = 22
    end
    
    properties        
		time_boot_ms	%Timestamp in milliseconds since system boot (uint32[1])
		roll	%Desired roll rate in radians per second (single[1])
		pitch	%Desired pitch rate in radians per second (single[1])
		yaw	%Desired yaw rate in radians per second (single[1])
		thrust	%Collective thrust, normalized to 0 .. 1 (single[1])
		mode_switch	%Flight mode switch position, 0.. 255 (uint8[1])
		manual_override_switch	%Override mode switch position, 0.. 255 (uint8[1])
	end

    
    methods
        
        %Constructor: msg_manual_setpoint
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_manual_setpoint(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_manual_setpoint.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_manual_setpoint.ID;
                
			packet.payload.putUINT32(obj.time_boot_ms);

			packet.payload.putSINGLE(obj.roll);

			packet.payload.putSINGLE(obj.pitch);

			packet.payload.putSINGLE(obj.yaw);

			packet.payload.putSINGLE(obj.thrust);

			packet.payload.putUINT8(obj.mode_switch);

			packet.payload.putUINT8(obj.manual_override_switch);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_boot_ms = payload.getUINT32();

			obj.roll = payload.getSINGLE();

			obj.pitch = payload.getSINGLE();

			obj.yaw = payload.getSINGLE();

			obj.thrust = payload.getSINGLE();

			obj.mode_switch = payload.getUINT8();

			obj.manual_override_switch = payload.getUINT8();

		end
            
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | manual_setpoint.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
            end
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
                                
        function set.thrust(obj,value)
            obj.thrust = single(value);
        end
                                    
        function set.mode_switch(obj,value)
            if value == uint8(value)
                obj.mode_switch = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | manual_setpoint.set.mode_switch()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.manual_override_switch(obj,value)
            if value == uint8(value)
                obj.manual_override_switch = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | manual_setpoint.set.manual_override_switch()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end