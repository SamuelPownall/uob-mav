classdef msg_sim_state < mavlink_message
    %MAVLINK Message Class
    %Name: sim_state	ID: 108
    %Description: Status of simulation environment, if used
            
    properties(Constant)
        ID = 108
        LEN = 84
    end
    
    properties        
		q1	%True attitude quaternion component 1, w (1 in null-rotation) (single[1])
		q2	%True attitude quaternion component 2, x (0 in null-rotation) (single[1])
		q3	%True attitude quaternion component 3, y (0 in null-rotation) (single[1])
		q4	%True attitude quaternion component 4, z (0 in null-rotation) (single[1])
		roll	%Attitude roll expressed as Euler angles, not recommended except for human-readable outputs (single[1])
		pitch	%Attitude pitch expressed as Euler angles, not recommended except for human-readable outputs (single[1])
		yaw	%Attitude yaw expressed as Euler angles, not recommended except for human-readable outputs (single[1])
		xacc	%X acceleration m/s/s (single[1])
		yacc	%Y acceleration m/s/s (single[1])
		zacc	%Z acceleration m/s/s (single[1])
		xgyro	%Angular speed around X axis rad/s (single[1])
		ygyro	%Angular speed around Y axis rad/s (single[1])
		zgyro	%Angular speed around Z axis rad/s (single[1])
		lat	%Latitude in degrees (single[1])
		lon	%Longitude in degrees (single[1])
		alt	%Altitude in meters (single[1])
		std_dev_horz	%Horizontal position standard deviation (single[1])
		std_dev_vert	%Vertical position standard deviation (single[1])
		vn	%True velocity in m/s in NORTH direction in earth-fixed NED frame (single[1])
		ve	%True velocity in m/s in EAST direction in earth-fixed NED frame (single[1])
		vd	%True velocity in m/s in DOWN direction in earth-fixed NED frame (single[1])
	end

    
    methods
        
        %Constructor: msg_sim_state
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_sim_state(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_sim_state.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_sim_state.ID;
                
			packet.payload.putSINGLE(obj.q1);

			packet.payload.putSINGLE(obj.q2);

			packet.payload.putSINGLE(obj.q3);

			packet.payload.putSINGLE(obj.q4);

			packet.payload.putSINGLE(obj.roll);

			packet.payload.putSINGLE(obj.pitch);

			packet.payload.putSINGLE(obj.yaw);

			packet.payload.putSINGLE(obj.xacc);

			packet.payload.putSINGLE(obj.yacc);

			packet.payload.putSINGLE(obj.zacc);

			packet.payload.putSINGLE(obj.xgyro);

			packet.payload.putSINGLE(obj.ygyro);

			packet.payload.putSINGLE(obj.zgyro);

			packet.payload.putSINGLE(obj.lat);

			packet.payload.putSINGLE(obj.lon);

			packet.payload.putSINGLE(obj.alt);

			packet.payload.putSINGLE(obj.std_dev_horz);

			packet.payload.putSINGLE(obj.std_dev_vert);

			packet.payload.putSINGLE(obj.vn);

			packet.payload.putSINGLE(obj.ve);

			packet.payload.putSINGLE(obj.vd);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.q1 = payload.getSINGLE();

			obj.q2 = payload.getSINGLE();

			obj.q3 = payload.getSINGLE();

			obj.q4 = payload.getSINGLE();

			obj.roll = payload.getSINGLE();

			obj.pitch = payload.getSINGLE();

			obj.yaw = payload.getSINGLE();

			obj.xacc = payload.getSINGLE();

			obj.yacc = payload.getSINGLE();

			obj.zacc = payload.getSINGLE();

			obj.xgyro = payload.getSINGLE();

			obj.ygyro = payload.getSINGLE();

			obj.zgyro = payload.getSINGLE();

			obj.lat = payload.getSINGLE();

			obj.lon = payload.getSINGLE();

			obj.alt = payload.getSINGLE();

			obj.std_dev_horz = payload.getSINGLE();

			obj.std_dev_vert = payload.getSINGLE();

			obj.vn = payload.getSINGLE();

			obj.ve = payload.getSINGLE();

			obj.vd = payload.getSINGLE();

		end
        
        function set.q1(obj,value)
            obj.q1 = single(value);
        end
                                
        function set.q2(obj,value)
            obj.q2 = single(value);
        end
                                
        function set.q3(obj,value)
            obj.q3 = single(value);
        end
                                
        function set.q4(obj,value)
            obj.q4 = single(value);
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
                                
        function set.xacc(obj,value)
            obj.xacc = single(value);
        end
                                
        function set.yacc(obj,value)
            obj.yacc = single(value);
        end
                                
        function set.zacc(obj,value)
            obj.zacc = single(value);
        end
                                
        function set.xgyro(obj,value)
            obj.xgyro = single(value);
        end
                                
        function set.ygyro(obj,value)
            obj.ygyro = single(value);
        end
                                
        function set.zgyro(obj,value)
            obj.zgyro = single(value);
        end
                                
        function set.lat(obj,value)
            obj.lat = single(value);
        end
                                
        function set.lon(obj,value)
            obj.lon = single(value);
        end
                                
        function set.alt(obj,value)
            obj.alt = single(value);
        end
                                
        function set.std_dev_horz(obj,value)
            obj.std_dev_horz = single(value);
        end
                                
        function set.std_dev_vert(obj,value)
            obj.std_dev_vert = single(value);
        end
                                
        function set.vn(obj,value)
            obj.vn = single(value);
        end
                                
        function set.ve(obj,value)
            obj.ve = single(value);
        end
                                
        function set.vd(obj,value)
            obj.vd = single(value);
        end
                        
	end
end