classdef msg_fence_point < MAVLinkMessage
	%MSG_FENCE_POINT: MAVLink Message ID = 160
    %Description:
    %    A fence point. Used to set a point when from
	      GCS -> MAV. Also used to return a point from MAV -> GCS
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    lat(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    lat(single): Latitude of point
    %    lng(single): Longitude of point
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
    %    idx(uint8): point index (first point is 1, 0 is for return point)
    %    count(uint8): total number of points (for sanity checking)
	
	properties(Constant)
		ID = 160
		LEN = 12
	end
	
	properties
        lat	%Latitude of point	|	(single)
        lng	%Longitude of point	|	(single)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
        idx	%point index (first point is 1, 0 is for return point)	|	(uint8)
        count	%total number of points (for sanity checking)	|	(uint8)
    end

    methods(Static)

        function send(out,lat,lng,target_system,target_component,idx,count,varargin)

            if nargin == 6 + 1
                msg = msg_fence_point(lat,lng,target_system,target_component,idx,count,varargin);
            elseif nargin == 2
                msg = msg_fence_point(lat);
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

        function obj = msg_fence_point(lat,lng,target_system,target_component,idx,count,varargin)
        %MSG_FENCE_POINT: Create a new fence_point message object
        
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
            elseif nargin >= 6 && isempty(varargin{1})
                obj.lat = lat;
                obj.lng = lng;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.idx = idx;
                obj.count = count;
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

                packet = MAVLinkPacket(msg_fence_point.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_fence_point.ID;
                
                packet.payload.putSINGLE(obj.lat);
                packet.payload.putSINGLE(obj.lng);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                packet.payload.putUINT8(obj.idx);
                packet.payload.putUINT8(obj.count);

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
            
            obj.lat = payload.getSINGLE();
            obj.lng = payload.getSINGLE();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            obj.idx = payload.getUINT8();
            obj.count = payload.getUINT8();

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
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';
            elseif size(obj.idx,2) ~= 1
                result = 'idx';
            elseif size(obj.count,2) ~= 1
                result = 'count';

            else
                result = 0;
            end
        end

        function set.lat(obj,value)
            obj.lat = single(value);
        end
        
        function set.lng(obj,value)
            obj.lng = single(value);
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
        
    end

end