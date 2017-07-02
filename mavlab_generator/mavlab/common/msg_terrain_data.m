classdef msg_terrain_data < mavlink_message
    %MAVLINK Message Class
    %Name: terrain_data	ID: 134
    %Description: Terrain data sent from GCS. The lat/lon and grid_spacing must be the same as a lat/lon from a TERRAIN_REQUEST
            
    properties(Constant)
        ID = 134
        LEN = 43
    end
    
    properties        
		lat	%Latitude of SW corner of first grid (degrees *10^7) (int32[1])
		lon	%Longitude of SW corner of first grid (in degrees *10^7) (int32[1])
		grid_spacing	%Grid spacing in meters (uint16[1])
		data	%Terrain data in meters AMSL (int16[16])
		gridbit	%bit within the terrain request mask (uint8[1])
	end

    
    methods
        
        %Constructor: msg_terrain_data
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_terrain_data(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_terrain_data.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_terrain_data.ID;
                
			packet.payload.putINT32(obj.lat);

			packet.payload.putINT32(obj.lon);

			packet.payload.putUINT16(obj.grid_spacing);
            
            for i = 1:16
                packet.payload.putINT16(obj.data(i));
            end
                            
			packet.payload.putUINT8(obj.gridbit);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.lat = payload.getINT32();

			obj.lon = payload.getINT32();

			obj.grid_spacing = payload.getUINT16();
            
            for i = 1:16
                obj.data(i) = payload.getINT16();
            end
                            
			obj.gridbit = payload.getUINT8();

		end
            
        function set.lat(obj,value)
            if value == int32(value)
                obj.lat = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | terrain_data.set.lat()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.lon(obj,value)
            if value == int32(value)
                obj.lon = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | terrain_data.set.lon()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.grid_spacing(obj,value)
            if value == uint16(value)
                obj.grid_spacing = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | terrain_data.set.grid_spacing()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.data(obj,value)
            if value == int16(value)
                obj.data = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | terrain_data.set.data()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.gridbit(obj,value)
            if value == uint8(value)
                obj.gridbit = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | terrain_data.set.gridbit()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end