classdef msg_terrain_data < MAVLinkMessage
	%MSG_TERRAIN_DATA: MAVLink Message ID = 134
    %Description:
    %    Terrain data sent from GCS. The lat/lon and grid_spacing must be the same as a lat/lon from a TERRAIN_REQUEST
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    lat(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,lat,lon,grid_spacing,data,gridbit,varargin)

            if nargin == 5 + 1
                msg = msg_terrain_data(lat,lon,grid_spacing,data,gridbit,varargin);
            elseif nargin == 2
                msg = msg_terrain_data(lat);
            else
                MAVLink.throwCustomError('The number of function arguments is not valid');
                return;
            end

            packet = msg.pack();
            if ~isempty(packet)
                buffer = packet.encode();
                write(out,buffer);
            else
                MAVLink.throwCustomError('The packet could not be verified');
            end
        
        end

    end

    methods

        function obj = msg_terrain_data(lat,lon,grid_spacing,data,gridbit,varargin)
        %MSG_TERRAIN_DATA: Create a new terrain_data message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(lat,'MAVLinkPacket')
                    packet = lat;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('lat','MAVLinkPacket');
                end
            elseif nargin >= 5 && isempty(varargin{1})
                obj.lat = lat;
                obj.lon = lon;
                obj.grid_spacing = grid_spacing;
                obj.data = data;
                obj.gridbit = gridbit;
            elseif nargin ~= 0
                MAVLink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        function packet = pack(obj)
        %PACK: Packs this MAVLink message into a MAVLinkPacket
        %Description:
        %    Packs the fields of a message into a MAVLinkPacket which can be encoded
        %    for transmission.

            errorField = obj.verify();
            if errorField == 0

                packet = MAVLinkPacket(msg_terrain_data.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
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
                MAVLink.throwPackingError(errorField);
            end

        end

        function unpack(obj, payload)
        %UNPACK: Unpacks a MAVLinkPayload into this MAVLink message
        %Description:
        %    Extracts the data from a MAVLinkPayload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(MAVLinkPayload): The payload to be unpacked into this MAVLink message

            payload.resetIndex();
            
            obj.lat = payload.getINT32();
            obj.lon = payload.getINT32();
            obj.grid_spacing = payload.getUINT16();
            for i=1:1:16
                obj.data(i) = payload.getINT16();
            end
            obj.gridbit = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

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
                MAVLink.throwTypeError('value','int32');
            end
        end
        
        function set.lon(obj,value)
            if value == int32(value)
                obj.lon = int32(value);
            else
                MAVLink.throwTypeError('value','int32');
            end
        end
        
        function set.grid_spacing(obj,value)
            if value == uint16(value)
                obj.grid_spacing = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.data(obj,value)
            if value == int16(value)
                obj.data = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.gridbit(obj,value)
            if value == uint8(value)
                obj.gridbit = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end