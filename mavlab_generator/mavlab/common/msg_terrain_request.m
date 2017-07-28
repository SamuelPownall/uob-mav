classdef msg_terrain_request < mavlink_message
	%MSG_TERRAIN_REQUEST(packet,mask,lat,lon,grid_spacing): MAVLINK Message ID = 133
    %Description:
    %    Request for terrain data and terrain status
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    mask(uint64): Bitmask of requested 4x4 grids (row major 8x7 array of grids, 56 bits)
    %    lat(int32): Latitude of SW corner of first grid (degrees *10^7)
    %    lon(int32): Longitude of SW corner of first grid (in degrees *10^7)
    %    grid_spacing(uint16): Grid spacing in meters
	
	properties(Constant)
		ID = 133
		LEN = 18
	end
	
	properties
        mask	%Bitmask of requested 4x4 grids (row major 8x7 array of grids, 56 bits)	|	(uint64)
        lat	%Latitude of SW corner of first grid (degrees *10^7)	|	(int32)
        lon	%Longitude of SW corner of first grid (in degrees *10^7)	|	(int32)
        grid_spacing	%Grid spacing in meters	|	(uint16)
    end

    methods

        %Constructor: msg_terrain_request
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_terrain_request(packet,mask,lat,lon,grid_spacing)
        
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
            
            elseif nargin-1 == 4
                obj.mask = mask;
                obj.lat = lat;
                obj.lon = lon;
                obj.grid_spacing = grid_spacing;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_terrain_request.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_terrain_request.ID;
                
                packet.payload.putUINT64(obj.mask);
                packet.payload.putINT32(obj.lat);
                packet.payload.putINT32(obj.lon);
                packet.payload.putUINT16(obj.grid_spacing);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.mask = payload.getUINT64();
            obj.lat = payload.getINT32();
            obj.lon = payload.getINT32();
            obj.grid_spacing = payload.getUINT16();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.mask,2) ~= 1
                result = 'mask';
            elseif size(obj.lat,2) ~= 1
                result = 'lat';
            elseif size(obj.lon,2) ~= 1
                result = 'lon';
            elseif size(obj.grid_spacing,2) ~= 1
                result = 'grid_spacing';

            else
                result = 0;
            end
        end

        function set.mask(obj,value)
            if value == uint64(value)
                obj.mask = uint64(value);
            else
                mavlink.throwTypeError('value','uint64');
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
        
    end

end