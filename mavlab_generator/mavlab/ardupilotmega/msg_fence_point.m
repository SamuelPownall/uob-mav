classdef msg_fence_point < mavlink_message
	%MSG_FENCE_POINT(packet,lat,lng,target_system,target_component,idx,count): MAVLINK Message ID = 160
    %Description:
    %    A fence point. Used to set a point when from
	      GCS -> MAV. Also used to return a point from MAV -> GCS
    %    If constructing from fields, packet argument should be set to []
	%Fields:
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

    methods

        %Constructor: msg_fence_point
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_fence_point(packet,lat,lng,target_system,target_component,idx,count)
        
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
            
            elseif nargin-1 == 6
                obj.lat = lat;
                obj.lng = lng;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.idx = idx;
                obj.count = count;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_fence_point.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_fence_point.ID;
                
                packet.payload.putSINGLE(obj.lat);
                packet.payload.putSINGLE(obj.lng);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                packet.payload.putUINT8(obj.idx);
                packet.payload.putUINT8(obj.count);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.lat = payload.getSINGLE();
            obj.lng = payload.getSINGLE();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            obj.idx = payload.getUINT8();
            obj.count = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.idx(obj,value)
            if value == uint8(value)
                obj.idx = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.count(obj,value)
            if value == uint8(value)
                obj.count = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end