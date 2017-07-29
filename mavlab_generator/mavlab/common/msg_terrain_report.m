classdef msg_terrain_report < mavlink_message
	%MSG_TERRAIN_REPORT: MAVLINK Message ID = 136
    %Description:
    %    Response from a TERRAIN_CHECK request
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
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

    methods

        function obj = msg_terrain_report(packet,lat,lon,terrain_height,current_height,spacing,pending,loaded)
        %Create a new terrain_report message
        
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
            
            elseif nargin-1 == 7
                obj.lat = lat;
                obj.lon = lon;
                obj.terrain_height = terrain_height;
                obj.current_height = current_height;
                obj.spacing = spacing;
                obj.pending = pending;
                obj.loaded = loaded;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        function packet = pack(obj)
        %PACK: Packs this MAVLINK message into a mavlink_packet
        %Description:
        %    Packs the fields of a message into a mavlink_packet which can be encoded
        %    for transmission.

            errorField = obj.verify();
            if errorField == 0

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
                mavlink.throwPackingError(errorField);
            end

        end

        function unpack(obj, payload)
        %UNPACK: Unpacks a mavlink_payload into this MAVLINK message
        %Description:
        %    Extracts the data from a mavlink_payload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(mavlink_payload): The payload to be unpacked into this MAVLINK message

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
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.pending(obj,value)
            if value == uint16(value)
                obj.pending = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.loaded(obj,value)
            if value == uint16(value)
                obj.loaded = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
    end

end