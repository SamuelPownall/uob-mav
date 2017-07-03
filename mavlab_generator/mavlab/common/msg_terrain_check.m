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
        function obj = msg_terrain_check(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            emptyField = obj.verify();
            if emptyField == 0
        
                packet = mavlink_packet(msg_terrain_check.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_terrain_check.ID;
                
				packet.payload.putINT32(obj.lat);

				packet.payload.putINT32(obj.lon);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_terrain_check.pack()\n\t Message data in "%s" is not valid\n',emptyField);
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
                fprintf(2,'MAVLAB-ERROR | terrain_check.set.lat()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.lon(obj,value)
            if value == int32(value)
                obj.lon = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | terrain_check.set.lon()\n\t Input "value" is not of type "int32"\n');
            end
        end
                        
	end
end