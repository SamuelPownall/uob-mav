classdef msg_altitude < mavlink_message
    %MAVLINK Message Class
    %Name: altitude	ID: 141
    %Description: The current system altitude.
            
    properties(Constant)
        ID = 141
        LEN = 32
    end
    
    properties        
		time_usec	%Timestamp (micros since boot or Unix epoch) (uint64)
		altitude_monotonic	%This altitude measure is initialized on system boot and monotonic (it is never reset, but represents the local altitude change). The only guarantee on this field is that it will never be reset and is consistent within a flight. The recommended value for this field is the uncorrected barometric altitude at boot time. This altitude will also drift and vary between flights. (single)
		altitude_amsl	%This altitude measure is strictly above mean sea level and might be non-monotonic (it might reset on events like GPS lock or when a new QNH value is set). It should be the altitude to which global altitude waypoints are compared to. Note that it is *not* the GPS altitude, however, most GPS modules already output AMSL by default and not the WGS84 altitude. (single)
		altitude_local	%This is the local altitude in the local coordinate frame. It is not the altitude above home, but in reference to the coordinate origin (0, 0, 0). It is up-positive. (single)
		altitude_relative	%This is the altitude above the home position. It resets on each change of the current home position. (single)
		altitude_terrain	%This is the altitude above terrain. It might be fed by a terrain database or an altimeter. Values smaller than -1000 should be interpreted as unknown. (single)
		bottom_clearance	%This is not the altitude, but the clear space below the system according to the fused clearance estimate. It generally should max out at the maximum range of e.g. the laser altimeter. It is generally a moving target. A negative value indicates no measurement available. (single)
	end
    
    methods
        
        %Constructor: msg_altitude
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_altitude(packet,time_usec,altitude_monotonic,altitude_amsl,altitude_local,altitude_relative,altitude_terrain,bottom_clearance)
        
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
                
            elseif nargin == 8
                
				obj.time_usec = time_usec;
				obj.altitude_monotonic = altitude_monotonic;
				obj.altitude_amsl = altitude_amsl;
				obj.altitude_local = altitude_local;
				obj.altitude_relative = altitude_relative;
				obj.altitude_terrain = altitude_terrain;
				obj.bottom_clearance = bottom_clearance;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_altitude.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_altitude.ID;
                
				packet.payload.putUINT64(obj.time_usec);

				packet.payload.putSINGLE(obj.altitude_monotonic);

				packet.payload.putSINGLE(obj.altitude_amsl);

				packet.payload.putSINGLE(obj.altitude_local);

				packet.payload.putSINGLE(obj.altitude_relative);

				packet.payload.putSINGLE(obj.altitude_terrain);

				packet.payload.putSINGLE(obj.bottom_clearance);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();

			obj.altitude_monotonic = payload.getSINGLE();

			obj.altitude_amsl = payload.getSINGLE();

			obj.altitude_local = payload.getSINGLE();

			obj.altitude_relative = payload.getSINGLE();

			obj.altitude_terrain = payload.getSINGLE();

			obj.bottom_clearance = payload.getSINGLE();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_usec,2) ~= 1
                result = 'time_usec';                                        
            elseif size(obj.altitude_monotonic,2) ~= 1
                result = 'altitude_monotonic';                                        
            elseif size(obj.altitude_amsl,2) ~= 1
                result = 'altitude_amsl';                                        
            elseif size(obj.altitude_local,2) ~= 1
                result = 'altitude_local';                                        
            elseif size(obj.altitude_relative,2) ~= 1
                result = 'altitude_relative';                                        
            elseif size(obj.altitude_terrain,2) ~= 1
                result = 'altitude_terrain';                                        
            elseif size(obj.bottom_clearance,2) ~= 1
                result = 'bottom_clearance';                            
            else
                result = 0;
            end
            
        end
                                
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                mavlink.throwTypeError('value','uint64');
            end
        end
                                
        function set.altitude_monotonic(obj,value)
            obj.altitude_monotonic = single(value);
        end
                                
        function set.altitude_amsl(obj,value)
            obj.altitude_amsl = single(value);
        end
                                
        function set.altitude_local(obj,value)
            obj.altitude_local = single(value);
        end
                                
        function set.altitude_relative(obj,value)
            obj.altitude_relative = single(value);
        end
                                
        function set.altitude_terrain(obj,value)
            obj.altitude_terrain = single(value);
        end
                                
        function set.bottom_clearance(obj,value)
            obj.bottom_clearance = single(value);
        end
                        
	end
end