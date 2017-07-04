classdef msg_terrain_check < mavlink_message
    %MAVLINK Message Class
    %Name: terrain_check	ID: 135
    %Description: Request that the vehicle report terrain height at the given location. Used by GCS to check if vehicle has all terrain data needed for a mission.
            
    properties(Constant)
        ID = 135
        LEN = 8
    end
    
    properties        
		lat	%Latitude (degrees *10^7) (int32)
		lon	%Longitude (degrees *10^7) (int32)
	end
    
    methods
        
        %Constructor: msg_terrain_check
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_terrain_check(packet,lat,lon)
        
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
                
            elseif nargin == 3
                
				obj.lat = lat;
				obj.lon = lon;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_terrain_check.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_terrain_check.ID;
                
				packet.payload.putINT32(obj.lat);

				packet.payload.putINT32(obj.lon);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.lat = payload.getINT32();

			obj.lon = payload.getINT32();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.lat,2) ~= 1
                result = 'lat';                                        
            elseif size(obj.lon,2) ~= 1
                result = 'lon';                            
            else
                result = 0;
            end
            
        end
                                
        function set.lat(obj,value)
            if value == int32(value)
                obj.lat = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                                    
        function set.lon(obj,value)
            if value == int32(value)
                obj.lon = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                        
	end
end