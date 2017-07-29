classdef msg_follow_target < mavlink_handle
	%MSG_FOLLOW_TARGET(packet,timestamp,custom_state,lat,lon,alt,vel,acc,attitude_q,rates,position_cov,est_capabilities): MAVLINK Message ID = 144
    %Description:
    %    current motion information from a designated system
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    timestamp(uint64): Timestamp in milliseconds since system boot
    %    custom_state(uint64): button states or switches of a tracker device
    %    lat(int32): Latitude (WGS84), in degrees * 1E7
    %    lon(int32): Longitude (WGS84), in degrees * 1E7
    %    alt(single): AMSL, in meters
    %    vel(single[3]): target velocity (0,0,0) for unknown
    %    acc(single[3]): linear target acceleration (0,0,0) for unknown
    %    attitude_q(single[4]): (1 0 0 0 for unknown)
    %    rates(single[3]): (0 0 0 for unknown)
    %    position_cov(single[3]): eph epv
    %    est_capabilities(uint8): bit positions for tracker reporting capabilities (POS = 0, VEL = 1, ACCEL = 2, ATT + RATES = 3)
	
	properties(Constant)
		ID = 144
		LEN = 93
	end
	
	properties
        timestamp	%Timestamp in milliseconds since system boot	|	(uint64)
        custom_state	%button states or switches of a tracker device	|	(uint64)
        lat	%Latitude (WGS84), in degrees * 1E7	|	(int32)
        lon	%Longitude (WGS84), in degrees * 1E7	|	(int32)
        alt	%AMSL, in meters	|	(single)
        vel	%target velocity (0,0,0) for unknown	|	(single[3])
        acc	%linear target acceleration (0,0,0) for unknown	|	(single[3])
        attitude_q	%(1 0 0 0 for unknown)	|	(single[4])
        rates	%(0 0 0 for unknown)	|	(single[3])
        position_cov	%eph epv	|	(single[3])
        est_capabilities	%bit positions for tracker reporting capabilities (POS = 0, VEL = 1, ACCEL = 2, ATT + RATES = 3)	|	(uint8)
    end

    methods

        %Constructor: msg_follow_target
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_follow_target(packet,timestamp,custom_state,lat,lon,alt,vel,acc,attitude_q,rates,position_cov,est_capabilities)
        
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
            
            elseif nargin-1 == 11
                obj.timestamp = timestamp;
                obj.custom_state = custom_state;
                obj.lat = lat;
                obj.lon = lon;
                obj.alt = alt;
                obj.vel = vel;
                obj.acc = acc;
                obj.attitude_q = attitude_q;
                obj.rates = rates;
                obj.position_cov = position_cov;
                obj.est_capabilities = est_capabilities;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_follow_target.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_follow_target.ID;
                
                packet.payload.putUINT64(obj.timestamp);
                packet.payload.putUINT64(obj.custom_state);
                packet.payload.putINT32(obj.lat);
                packet.payload.putINT32(obj.lon);
                packet.payload.putSINGLE(obj.alt);
                for i=1:1:3
                    packet.payload.putSINGLE(obj.vel(i));
                end
                for i=1:1:3
                    packet.payload.putSINGLE(obj.acc(i));
                end
                for i=1:1:4
                    packet.payload.putSINGLE(obj.attitude_q(i));
                end
                for i=1:1:3
                    packet.payload.putSINGLE(obj.rates(i));
                end
                for i=1:1:3
                    packet.payload.putSINGLE(obj.position_cov(i));
                end
                packet.payload.putUINT8(obj.est_capabilities);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.timestamp = payload.getUINT64();
            obj.custom_state = payload.getUINT64();
            obj.lat = payload.getINT32();
            obj.lon = payload.getINT32();
            obj.alt = payload.getSINGLE();
            for i=1:1:3
                obj.vel(i) = payload.getSINGLE();
            end
            for i=1:1:3
                obj.acc(i) = payload.getSINGLE();
            end
            for i=1:1:4
                obj.attitude_q(i) = payload.getSINGLE();
            end
            for i=1:1:3
                obj.rates(i) = payload.getSINGLE();
            end
            for i=1:1:3
                obj.position_cov(i) = payload.getSINGLE();
            end
            obj.est_capabilities = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.timestamp,2) ~= 1
                result = 'timestamp';
            elseif size(obj.custom_state,2) ~= 1
                result = 'custom_state';
            elseif size(obj.lat,2) ~= 1
                result = 'lat';
            elseif size(obj.lon,2) ~= 1
                result = 'lon';
            elseif size(obj.alt,2) ~= 1
                result = 'alt';
            elseif size(obj.vel,2) ~= 3
                result = 'vel';
            elseif size(obj.acc,2) ~= 3
                result = 'acc';
            elseif size(obj.attitude_q,2) ~= 4
                result = 'attitude_q';
            elseif size(obj.rates,2) ~= 3
                result = 'rates';
            elseif size(obj.position_cov,2) ~= 3
                result = 'position_cov';
            elseif size(obj.est_capabilities,2) ~= 1
                result = 'est_capabilities';

            else
                result = 0;
            end
        end

        function set.timestamp(obj,value)
            if value == uint64(value)
                obj.timestamp = uint64(value);
            else
                mavlink.throwTypeError('value','uint64');
            end
        end
        
        function set.custom_state(obj,value)
            if value == uint64(value)
                obj.custom_state = uint64(value);
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
        
        function set.alt(obj,value)
            obj.alt = single(value);
        end
        
        function set.vel(obj,value)
            obj.vel = single(value);
        end
        
        function set.acc(obj,value)
            obj.acc = single(value);
        end
        
        function set.attitude_q(obj,value)
            obj.attitude_q = single(value);
        end
        
        function set.rates(obj,value)
            obj.rates = single(value);
        end
        
        function set.position_cov(obj,value)
            obj.position_cov = single(value);
        end
        
        function set.est_capabilities(obj,value)
            if value == uint8(value)
                obj.est_capabilities = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end