classdef msg_rally_point < MAVLinkMessage
	%MSG_RALLY_POINT: MAVLink Message ID = 175
    %Description:
    %    A rally point. Used to set a point when from GCS -> MAV. Also used to return a point from MAV -> GCS
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    lat(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    lat(int32): Latitude of point in degrees * 1E7
    %    lng(int32): Longitude of point in degrees * 1E7
    %    alt(int16): Transit / loiter altitude in meters relative to home
    %    break_alt(int16): Break altitude in meters relative to home
    %    land_dir(uint16): Heading to aim for when landing. In centi-degrees.
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
    %    idx(uint8): point index (first point is 0)
    %    count(uint8): total number of points (for sanity checking)
    %    flags(uint8): See RALLY_FLAGS enum for definition of the bitmask.
	
	properties(Constant)
		ID = 175
		LEN = 19
	end
	
	properties
        lat	%Latitude of point in degrees * 1E7	|	(int32)
        lng	%Longitude of point in degrees * 1E7	|	(int32)
        alt	%Transit / loiter altitude in meters relative to home	|	(int16)
        break_alt	%Break altitude in meters relative to home	|	(int16)
        land_dir	%Heading to aim for when landing. In centi-degrees.	|	(uint16)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
        idx	%point index (first point is 0)	|	(uint8)
        count	%total number of points (for sanity checking)	|	(uint8)
        flags	%See RALLY_FLAGS enum for definition of the bitmask.	|	(uint8)
    end

    methods(Static)

        function send(out,lat,lng,alt,break_alt,land_dir,target_system,target_component,idx,count,flags,varargin)

            if nargin == 10 + 1
                msg = msg_rally_point(lat,lng,alt,break_alt,land_dir,target_system,target_component,idx,count,flags,varargin);
            elseif nargin == 2
                msg = msg_rally_point(lat);
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

        function obj = msg_rally_point(lat,lng,alt,break_alt,land_dir,target_system,target_component,idx,count,flags,varargin)
        %MSG_RALLY_POINT: Create a new rally_point message object
        
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
            elseif nargin >= 10 && isempty(varargin{1})
                obj.lat = lat;
                obj.lng = lng;
                obj.alt = alt;
                obj.break_alt = break_alt;
                obj.land_dir = land_dir;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.idx = idx;
                obj.count = count;
                obj.flags = flags;
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

                packet = MAVLinkPacket(msg_rally_point.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_rally_point.ID;
                
                packet.payload.putINT32(obj.lat);
                packet.payload.putINT32(obj.lng);
                packet.payload.putINT16(obj.alt);
                packet.payload.putINT16(obj.break_alt);
                packet.payload.putUINT16(obj.land_dir);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                packet.payload.putUINT8(obj.idx);
                packet.payload.putUINT8(obj.count);
                packet.payload.putUINT8(obj.flags);

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
            obj.lng = payload.getINT32();
            obj.alt = payload.getINT16();
            obj.break_alt = payload.getINT16();
            obj.land_dir = payload.getUINT16();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            obj.idx = payload.getUINT8();
            obj.count = payload.getUINT8();
            obj.flags = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.lat,2) ~= 1
                result = 'lat';
            elseif size(obj.lng,2) ~= 1
                result = 'lng';
            elseif size(obj.alt,2) ~= 1
                result = 'alt';
            elseif size(obj.break_alt,2) ~= 1
                result = 'break_alt';
            elseif size(obj.land_dir,2) ~= 1
                result = 'land_dir';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';
            elseif size(obj.idx,2) ~= 1
                result = 'idx';
            elseif size(obj.count,2) ~= 1
                result = 'count';
            elseif size(obj.flags,2) ~= 1
                result = 'flags';

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
        
        function set.lng(obj,value)
            if value == int32(value)
                obj.lng = int32(value);
            else
                MAVLink.throwTypeError('value','int32');
            end
        end
        
        function set.alt(obj,value)
            if value == int16(value)
                obj.alt = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.break_alt(obj,value)
            if value == int16(value)
                obj.break_alt = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.land_dir(obj,value)
            if value == uint16(value)
                obj.land_dir = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.idx(obj,value)
            if value == uint8(value)
                obj.idx = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.count(obj,value)
            if value == uint8(value)
                obj.count = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.flags(obj,value)
            if value == uint8(value)
                obj.flags = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end