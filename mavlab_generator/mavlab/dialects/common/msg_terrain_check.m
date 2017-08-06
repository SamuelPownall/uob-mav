classdef msg_terrain_check < MAVLinkMessage
	%MSG_TERRAIN_CHECK: MAVLink Message ID = 135
    %Description:
    %    Request that the vehicle report terrain height at the given location. Used by GCS to check if vehicle has all terrain data needed for a mission.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    lat(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    lat(int32): Latitude (degrees *10^7)
    %    lon(int32): Longitude (degrees *10^7)
	
	properties(Constant)
		ID = 135
		LEN = 8
	end
	
	properties
        lat	%Latitude (degrees *10^7)	|	(int32)
        lon	%Longitude (degrees *10^7)	|	(int32)
    end

    methods(Static)

        function send(out,lat,lon,varargin)

            if nargin == 2 + 1
                msg = msg_terrain_check(lat,lon,varargin);
            elseif nargin == 2
                msg = msg_terrain_check(lat);
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

        function obj = msg_terrain_check(lat,lon,varargin)
        %MSG_TERRAIN_CHECK: Create a new terrain_check message object
        
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
            elseif nargin >= 2 && isempty(varargin{1})
                obj.lat = lat;
                obj.lon = lon;
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

                packet = MAVLinkPacket(msg_terrain_check.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_terrain_check.ID;
                
                packet.payload.putINT32(obj.lat);
                packet.payload.putINT32(obj.lon);

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
        
    end

end