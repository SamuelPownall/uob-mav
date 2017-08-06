classdef msg_terrain_request < MAVLinkMessage
	%MSG_TERRAIN_REQUEST: MAVLink Message ID = 133
    %Description:
    %    Request for terrain data and terrain status
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    mask(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,mask,lat,lon,grid_spacing,varargin)

            if nargin == 4 + 1
                msg = msg_terrain_request(mask,lat,lon,grid_spacing,varargin);
            elseif nargin == 2
                msg = msg_terrain_request(mask);
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

        function obj = msg_terrain_request(mask,lat,lon,grid_spacing,varargin)
        %MSG_TERRAIN_REQUEST: Create a new terrain_request message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(mask,'MAVLinkPacket')
                    packet = mask;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('mask','MAVLinkPacket');
                end
            elseif nargin >= 4 && isempty(varargin{1})
                obj.mask = mask;
                obj.lat = lat;
                obj.lon = lon;
                obj.grid_spacing = grid_spacing;
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

                packet = MAVLinkPacket(msg_terrain_request.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_terrain_request.ID;
                
                packet.payload.putUINT64(obj.mask);
                packet.payload.putINT32(obj.lat);
                packet.payload.putINT32(obj.lon);
                packet.payload.putUINT16(obj.grid_spacing);

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
            
            obj.mask = payload.getUINT64();
            obj.lat = payload.getINT32();
            obj.lon = payload.getINT32();
            obj.grid_spacing = payload.getUINT16();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

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
                MAVLink.throwTypeError('value','uint64');
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
        
    end

end