classdef msg_attitude < mavlink_message
    %MAVLINK Message Class
    %Name: attitude	ID: 30
    %Description: The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right).
            
    properties(Constant)
        ID = 30
        LEN = 28
    end
    
    properties        
		time_boot_ms	%Timestamp (milliseconds since system boot) (uint32[1])
		roll	%Roll angle (rad, -pi..+pi) (single[1])
		pitch	%Pitch angle (rad, -pi..+pi) (single[1])
		yaw	%Yaw angle (rad, -pi..+pi) (single[1])
		rollspeed	%Roll angular speed (rad/s) (single[1])
		pitchspeed	%Pitch angular speed (rad/s) (single[1])
		yawspeed	%Yaw angular speed (rad/s) (single[1])
	end

    
    methods
        
        %Constructor: msg_attitude
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_attitude(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_attitude.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_attitude.ID;
                
			packet.payload.putUINT32(obj.time_boot_ms);

			packet.payload.putSINGLE(obj.roll);

			packet.payload.putSINGLE(obj.pitch);

			packet.payload.putSINGLE(obj.yaw);

			packet.payload.putSINGLE(obj.rollspeed);

			packet.payload.putSINGLE(obj.pitchspeed);

			packet.payload.putSINGLE(obj.yawspeed);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_boot_ms = payload.getUINT32();

			obj.roll = payload.getSINGLE();

			obj.pitch = payload.getSINGLE();

			obj.yaw = payload.getSINGLE();

			obj.rollspeed = payload.getSINGLE();

			obj.pitchspeed = payload.getSINGLE();

			obj.yawspeed = payload.getSINGLE();

		end
            
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | attitude.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
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
                                
        function set.rollspeed(obj,value)
            obj.rollspeed = single(value);
        end
                                
        function set.pitchspeed(obj,value)
            obj.pitchspeed = single(value);
        end
                                
        function set.yawspeed(obj,value)
            obj.yawspeed = single(value);
        end
                        
	end
end