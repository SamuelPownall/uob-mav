classdef msg_global_vision_position_estimate < mavlink_message
    %MAVLINK Message Class
    %Name: global_vision_position_estimate	ID: 101
    %Description: None
            
    properties(Constant)
        ID = 101
        LEN = 32
    end
    
    properties        
		usec	%Timestamp (microseconds, synced to UNIX time or since system boot) (uint64[1])
		x	%Global X position (single[1])
		y	%Global Y position (single[1])
		z	%Global Z position (single[1])
		roll	%Roll angle in rad (single[1])
		pitch	%Pitch angle in rad (single[1])
		yaw	%Yaw angle in rad (single[1])
	end

    
    methods
        
        %Constructor: msg_global_vision_position_estimate
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_global_vision_position_estimate(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_global_vision_position_estimate.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_global_vision_position_estimate.ID;
                
			packet.payload.putUINT64(obj.usec);

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
        
			obj.usec = payload.getUINT64();

			obj.x = payload.getSINGLE();

			obj.y = payload.getSINGLE();

			obj.z = payload.getSINGLE();

			obj.roll = payload.getSINGLE();

			obj.pitch = payload.getSINGLE();

			obj.yaw = payload.getSINGLE();

		end
            
        function set.usec(obj,value)
            if value == uint64(value)
                obj.usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | global_vision_position_estimate.set.usec()\n\t Input "value" is not of type "uint64"\n');
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