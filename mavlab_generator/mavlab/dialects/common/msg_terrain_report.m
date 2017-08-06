classdef msg_terrain_report < MAVLinkMessage
	%MSG_TERRAIN_REPORT: MAVLink Message ID = 136
    %Description:
    %    Response from a TERRAIN_CHECK request
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    lat(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    lat(int32): Latitude (degrees *10^7)
    %    lon(int32): Longitude (degrees *10^7)
    %    terrain_height(single): Terrain height in meters AMSL
    %    current_height(single): Current vehicle height above lat/lon terrain height (meters)
    %    spacing(uint16): grid spacing (zero if terrain at this location unavailable)
    %    pending(uint16): Number of 4x4 terrain blocks waiting to be received or read from disk
    %    loaded(uint16): Number of 4x4 terrain blocks in memory
	
	properties(Constant)
		ID = 136
		LEN = 22
	end
	
	properties
        lat	%Latitude (degrees *10^7)	|	(int32)
        lon	%Longitude (degrees *10^7)	|	(int32)
        terrain_height	%Terrain height in meters AMSL	|	(single)
        current_height	%Current vehicle height above lat/lon terrain height (meters)	|	(single)
        spacing	%grid spacing (zero if terrain at this location unavailable)	|	(uint16)
        pending	%Number of 4x4 terrain blocks waiting to be received or read from disk	|	(uint16)
        loaded	%Number of 4x4 terrain blocks in memory	|	(uint16)
    end

    methods(Static)

        function send(out,lat,lon,terrain_height,current_height,spacing,pending,loaded,varargin)

            if nargin == 7 + 1
                msg = msg_terrain_report(lat,lon,terrain_height,current_height,spacing,pending,loaded,varargin);
            elseif nargin == 2
                msg = msg_terrain_report(lat);
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

        function obj = msg_terrain_report(lat,lon,terrain_height,current_height,spacing,pending,loaded,varargin)
        %MSG_TERRAIN_REPORT: Create a new terrain_report message object
        
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
            elseif nargin >= 7 && isempty(varargin{1})
                obj.lat = lat;
                obj.lon = lon;
                obj.terrain_height = terrain_height;
                obj.current_height = current_height;
                obj.spacing = spacing;
                obj.pending = pending;
                obj.loaded = loaded;
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

                packet = MAVLinkPacket(msg_terrain_report.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
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
            obj.terrain_height = payload.getSINGLE();
            obj.current_height = payload.getSINGLE();
            obj.spacing = payload.getUINT16();
            obj.pending = payload.getUINT16();
            obj.loaded = payload.getUINT16();

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
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.pending(obj,value)
            if value == uint16(value)
                obj.pending = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.loaded(obj,value)
            if value == uint16(value)
                obj.loaded = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
    end

end