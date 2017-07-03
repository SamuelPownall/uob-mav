classdef msg_terrain_report < mavlink_message
    %MAVLINK Message Class
    %Name: terrain_report	ID: 136
    %Description: Response from a TERRAIN_CHECK request
            
    properties(Constant)
        ID = 136
        LEN = 22
    end
    
    properties        
		lat	%Latitude (degrees *10^7) (int32)
		lon	%Longitude (degrees *10^7) (int32)
		terrain_height	%Terrain height in meters AMSL (single)
		current_height	%Current vehicle height above lat/lon terrain height (meters) (single)
		spacing	%grid spacing (zero if terrain at this location unavailable) (uint16)
		pending	%Number of 4x4 terrain blocks waiting to be received or read from disk (uint16)
		loaded	%Number of 4x4 terrain blocks in memory (uint16)
	end
    
    methods
        
        %Constructor: msg_terrain_report
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_terrain_report(packet)
        
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
        
                packet = mavlink_packet(msg_terrain_report.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_terrain_report.ID;
                
				packet.payload.putINT32(obj.lat);

				packet.payload.putINT32(obj.lon);

				packet.payload.putSINGLE(obj.terrain_height);

				packet.payload.putSINGLE(obj.current_height);

				packet.payload.putUINT16(obj.spacing);

				packet.payload.putUINT16(obj.pending);

				packet.payload.putUINT16(obj.loaded);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_terrain_report.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.lat = payload.getINT32();

			obj.lon = payload.getINT32();

			obj.terrain_height = payload.getSINGLE();

			obj.current_height = payload.getSINGLE();

			obj.spacing = payload.getUINT16();

			obj.pending = payload.getUINT16();

			obj.loaded = payload.getUINT16();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.lat,2) ~= 1
                result = 'lat';                                        
            elseif size(obj.lon,2) ~= 1
                result = 'lon';                                        
            elseif size(obj.terrain_height,2) ~= 1
                result = 'terrain_height';                                        
            elseif size(obj.current_height,2) ~= 1
                result = 'current_height';                                        
            elseif size(obj.spacing,2) ~= 1
                result = 'spacing';                                        
            elseif size(obj.pending,2) ~= 1
                result = 'pending';                                        
            elseif size(obj.loaded,2) ~= 1
                result = 'loaded';                            
            else
                result = 0;
            end
            
        end
                                
        function set.lat(obj,value)
            if value == int32(value)
                obj.lat = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | terrain_report.set.lat()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.lon(obj,value)
            if value == int32(value)
                obj.lon = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | terrain_report.set.lon()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                
        function set.terrain_height(obj,value)
            obj.terrain_height = single(value);
        end
                                
        function set.current_height(obj,value)
            obj.current_height = single(value);
        end
                                    
        function set.spacing(obj,value)
            if value == uint16(value)
                obj.spacing = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | terrain_report.set.spacing()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.pending(obj,value)
            if value == uint16(value)
                obj.pending = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | terrain_report.set.pending()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.loaded(obj,value)
            if value == uint16(value)
                obj.loaded = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | terrain_report.set.loaded()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                        
	end
end