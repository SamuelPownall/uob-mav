classdef msg_vfr_hud < mavlink_message
    %MAVLINK Message Class
    %Name: vfr_hud	ID: 74
    %Description: Metrics typically displayed on a HUD for fixed wing aircraft
            
    properties(Constant)
        ID = 74
        LEN = 20
    end
    
    properties        
		airspeed	%Current airspeed in m/s (single)
		groundspeed	%Current ground speed in m/s (single)
		alt	%Current altitude (MSL), in meters (single)
		climb	%Current climb rate in meters/second (single)
		heading	%Current heading in degrees, in compass units (0..360, 0=north) (int16)
		throttle	%Current throttle setting in integer percent, 0 to 100 (uint16)
	end
    
    methods
        
        %Constructor: msg_vfr_hud
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_vfr_hud(packet,airspeed,groundspeed,alt,climb,heading,throttle)
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(packet,'mavlink_packet')
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('packet','mavlink_packet');
                end
                
            elseif nargin == 7
                
				obj.airspeed = airspeed;
				obj.groundspeed = groundspeed;
				obj.alt = alt;
				obj.climb = climb;
				obj.heading = heading;
				obj.throttle = throttle;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
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
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.airspeed = payload.getSINGLE();

			obj.groundspeed = payload.getSINGLE();

			obj.alt = payload.getSINGLE();

			obj.climb = payload.getSINGLE();

			obj.heading = payload.getINT16();

			obj.throttle = payload.getUINT16();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.airspeed,2) ~= 1
                result = 'airspeed';                                        
            elseif size(obj.groundspeed,2) ~= 1
                result = 'groundspeed';                                        
            elseif size(obj.alt,2) ~= 1
                result = 'alt';                                        
            elseif size(obj.climb,2) ~= 1
                result = 'climb';                                        
            elseif size(obj.heading,2) ~= 1
                result = 'heading';                                        
            elseif size(obj.throttle,2) ~= 1
                result = 'throttle';                            
            else
                result = 0;
            end
            
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
                mavlink.throwTypeError('value','int16');
            end
        end
                                    
        function set.throttle(obj,value)
            if value == uint16(value)
                obj.throttle = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                        
	end
end