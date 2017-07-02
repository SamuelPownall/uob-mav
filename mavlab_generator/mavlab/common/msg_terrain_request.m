classdef msg_terrain_request < mavlink_message
    %MAVLINK Message Class
    %Name: terrain_request	ID: 133
    %Description: Request for terrain data and terrain status
            
    properties(Constant)
        ID = 133
        LEN = 18
    end
    
    properties        
		mask	%Bitmask of requested 4x4 grids (row major 8x7 array of grids, 56 bits) (uint64[1])
		lat	%Latitude of SW corner of first grid (degrees *10^7) (int32[1])
		lon	%Longitude of SW corner of first grid (in degrees *10^7) (int32[1])
		grid_spacing	%Grid spacing in meters (uint16[1])
	end

    
    methods
        
        %Constructor: msg_terrain_request
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_terrain_request(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_terrain_request.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_terrain_request.ID;
                
			packet.payload.putUINT64(obj.mask);

			packet.payload.putINT32(obj.lat);

			packet.payload.putINT32(obj.lon);

			packet.payload.putUINT16(obj.grid_spacing);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.mask = payload.getUINT64();

			obj.lat = payload.getINT32();

			obj.lon = payload.getINT32();

			obj.grid_spacing = payload.getUINT16();

		end
            
        function set.mask(obj,value)
            if value == uint64(value)
                obj.mask = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | terrain_request.set.mask()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                    
        function set.lat(obj,value)
            if value == int32(value)
                obj.lat = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | terrain_request.set.lat()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.lon(obj,value)
            if value == int32(value)
                obj.lon = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | terrain_request.set.lon()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.grid_spacing(obj,value)
            if value == uint16(value)
                obj.grid_spacing = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | terrain_request.set.grid_spacing()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                        
	end
end