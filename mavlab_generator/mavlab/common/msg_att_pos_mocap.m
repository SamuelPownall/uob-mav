classdef msg_att_pos_mocap < mavlink_message
    %MAVLINK Message Class
    %Name: att_pos_mocap	ID: 138
    %Description: Motion capture attitude and position
            
    properties(Constant)
        ID = 138
        LEN = 36
    end
    
    properties        
		time_usec	%Timestamp (micros since boot or Unix epoch) (uint64[1])
		q	%Attitude quaternion (w, x, y, z order, zero-rotation is 1, 0, 0, 0) (single[4])
		x	%X position in meters (NED) (single[1])
		y	%Y position in meters (NED) (single[1])
		z	%Z position in meters (NED) (single[1])
	end

    
    methods
        
        %Constructor: msg_att_pos_mocap
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_att_pos_mocap(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_att_pos_mocap.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_att_pos_mocap.ID;
                
			packet.payload.putUINT64(obj.time_usec);
            
            for i = 1:4
                packet.payload.putSINGLE(obj.q(i));
            end
                            
			packet.payload.putSINGLE(obj.x);

			packet.payload.putSINGLE(obj.y);

			packet.payload.putSINGLE(obj.z);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();
            
            for i = 1:4
                obj.q(i) = payload.getSINGLE();
            end
                            
			obj.x = payload.getSINGLE();

			obj.y = payload.getSINGLE();

			obj.z = payload.getSINGLE();

		end
            
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | att_pos_mocap.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                
        function set.q(obj,value)
            obj.q = single(value);
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
                        
	end
end