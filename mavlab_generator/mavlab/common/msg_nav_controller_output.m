classdef msg_nav_controller_output < mavlink_message
    %MAVLINK Message Class
    %Name: nav_controller_output	ID: 62
    %Description: The state of the fixed wing navigation and position controller.
            
    properties(Constant)
        ID = 62
        LEN = 26
    end
    
    properties        
		nav_roll	%Current desired roll in degrees (single[1])
		nav_pitch	%Current desired pitch in degrees (single[1])
		alt_error	%Current altitude error in meters (single[1])
		aspd_error	%Current airspeed error in meters/second (single[1])
		xtrack_error	%Current crosstrack error on x-y plane in meters (single[1])
		nav_bearing	%Current desired heading in degrees (int16[1])
		target_bearing	%Bearing to current MISSION/target in degrees (int16[1])
		wp_dist	%Distance to active MISSION in meters (uint16[1])
	end

    
    methods
        
        %Constructor: msg_nav_controller_output
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_nav_controller_output(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_nav_controller_output.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_nav_controller_output.ID;
                
			packet.payload.putSINGLE(obj.nav_roll);

			packet.payload.putSINGLE(obj.nav_pitch);

			packet.payload.putSINGLE(obj.alt_error);

			packet.payload.putSINGLE(obj.aspd_error);

			packet.payload.putSINGLE(obj.xtrack_error);

			packet.payload.putINT16(obj.nav_bearing);

			packet.payload.putINT16(obj.target_bearing);

			packet.payload.putUINT16(obj.wp_dist);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.nav_roll = payload.getSINGLE();

			obj.nav_pitch = payload.getSINGLE();

			obj.alt_error = payload.getSINGLE();

			obj.aspd_error = payload.getSINGLE();

			obj.xtrack_error = payload.getSINGLE();

			obj.nav_bearing = payload.getINT16();

			obj.target_bearing = payload.getINT16();

			obj.wp_dist = payload.getUINT16();

		end
        
        function set.nav_roll(obj,value)
            obj.nav_roll = single(value);
        end
                                
        function set.nav_pitch(obj,value)
            obj.nav_pitch = single(value);
        end
                                
        function set.alt_error(obj,value)
            obj.alt_error = single(value);
        end
                                
        function set.aspd_error(obj,value)
            obj.aspd_error = single(value);
        end
                                
        function set.xtrack_error(obj,value)
            obj.xtrack_error = single(value);
        end
                                    
        function set.nav_bearing(obj,value)
            if value == int16(value)
                obj.nav_bearing = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | nav_controller_output.set.nav_bearing()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.target_bearing(obj,value)
            if value == int16(value)
                obj.target_bearing = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | nav_controller_output.set.target_bearing()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.wp_dist(obj,value)
            if value == uint16(value)
                obj.wp_dist = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | nav_controller_output.set.wp_dist()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                        
	end
end