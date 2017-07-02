classdef msg_terrain_report < mavlink_message
    %MAVLINK Message Class
    %Name: terrain_report	ID: 136
    %Description: Response from a TERRAIN_CHECK request
            
    properties(Constant)
        ID = 136
        LEN = 22
    end
    
    properties        
		lat	%Latitude (degrees *10^7) (int32[1])
		lon	%Longitude (degrees *10^7) (int32[1])
		terrain_height	%Terrain height in meters AMSL (single[1])
		current_height	%Current vehicle height above lat/lon terrain height (meters) (single[1])
		spacing	%grid spacing (zero if terrain at this location unavailable) (uint16[1])
		pending	%Number of 4x4 terrain blocks waiting to be received or read from disk (uint16[1])
		loaded	%Number of 4x4 terrain blocks in memory (uint16[1])
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

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
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