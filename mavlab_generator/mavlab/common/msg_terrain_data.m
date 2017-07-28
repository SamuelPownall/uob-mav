classdef msg_terrain_data < mavlink_message
	%MSG_TERRAIN_DATA(packet,lat,lon,grid_spacing,data,gridbit): MAVLINK Message ID = 134
    %Description:
    %    Terrain data sent from GCS. The lat/lon and grid_spacing must be the same as a lat/lon from a TERRAIN_REQUEST
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    lat(int32): Latitude of SW corner of first grid (degrees *10^7)
    %    lon(int32): Longitude of SW corner of first grid (in degrees *10^7)
    %    grid_spacing(uint16): Grid spacing in meters
    %    data(int16[16]): Terrain data in meters AMSL
    %    gridbit(uint8): bit within the terrain request mask
	
	properties(Constant)
		ID = 134
		LEN = 43
	end
	
	properties
        lat	%Latitude of SW corner of first grid (degrees *10^7)	|	(int32)
        lon	%Longitude of SW corner of first grid (in degrees *10^7)	|	(int32)
        grid_spacing	%Grid spacing in meters	|	(uint16)
        data	%Terrain data in meters AMSL	|	(int16[16])
        gridbit	%bit within the terrain request mask	|	(uint8)
    end

    methods

        %Constructor: msg_terrain_data
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_terrain_data(packet,lat,lon,grid_spacing,data,gridbit)
        
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
            
            elseif nargin-1 == 5
                obj.lat = lat;
                obj.lon = lon;
                obj.grid_spacing = grid_spacing;
                obj.data = data;
                obj.gridbit = gridbit;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_terrain_data.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_terrain_data.ID;
                
                packet.payload.putINT32(obj.lat);
                packet.payload.putINT32(obj.lon);
                packet.payload.putUINT16(obj.grid_spacing);
                for i=1:1:16
                    packet.payload.putINT16(obj.data(i));
                end
                packet.payload.putUINT8(obj.gridbit);

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
            obj.grid_spacing = payload.getUINT16();
            for i=1:1:16
                obj.data(i) = payload.getINT16();
            end
            obj.gridbit = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.lat,2) ~= 1
                result = 'lat';
            elseif size(obj.lon,2) ~= 1
                result = 'lon';
            elseif size(obj.grid_spacing,2) ~= 1
                result = 'grid_spacing';
            elseif size(obj.data,2) ~= 16
                result = 'data';
            elseif size(obj.gridbit,2) ~= 1
                result = 'gridbit';

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
        
        function set.grid_spacing(obj,value)
            if value == uint16(value)
                obj.grid_spacing = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.data(obj,value)
            if value == int16(value)
                obj.data = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.gridbit(obj,value)
            if value == uint8(value)
                obj.gridbit = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end