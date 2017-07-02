classdef msg_vfr_hud < mavlink_message
    %MAVLINK Message Class
    %Name: vfr_hud	ID: 74
    %Description: Metrics typically displayed on a HUD for fixed wing aircraft
            
    properties(Constant)
        ID = 74
        LEN = 20
    end
    
    properties        
		airspeed	%Current airspeed in m/s (single[1])
		groundspeed	%Current ground speed in m/s (single[1])
		alt	%Current altitude (MSL), in meters (single[1])
		climb	%Current climb rate in meters/second (single[1])
		heading	%Current heading in degrees, in compass units (0..360, 0=north) (int16[1])
		throttle	%Current throttle setting in integer percent, 0 to 100 (uint16[1])
	end

    
    methods
        
        %Constructor: msg_vfr_hud
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_vfr_hud(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_vfr_hud.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_vfr_hud.ID;
                
			packet.payload.putSINGLE(obj.airspeed);

			packet.payload.putSINGLE(obj.groundspeed);

			packet.payload.putSINGLE(obj.alt);

			packet.payload.putSINGLE(obj.climb);

			packet.payload.putINT16(obj.heading);

			packet.payload.putUINT16(obj.throttle);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.airspeed = payload.getSINGLE();

			obj.groundspeed = payload.getSINGLE();

			obj.alt = payload.getSINGLE();

			obj.climb = payload.getSINGLE();

			obj.heading = payload.getINT16();

			obj.throttle = payload.getUINT16();

		end
        
        function set.airspeed(obj,value)
            obj.airspeed = single(value);
        end
                                
        function set.groundspeed(obj,value)
            obj.groundspeed = single(value);
        end
                                
        function set.alt(obj,value)
            obj.alt = single(value);
        end
                                
        function set.climb(obj,value)
            obj.climb = single(value);
        end
                                    
        function set.heading(obj,value)
            if value == int16(value)
                obj.heading = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | vfr_hud.set.heading()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.throttle(obj,value)
            if value == uint16(value)
                obj.throttle = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | vfr_hud.set.throttle()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                        
	end
end