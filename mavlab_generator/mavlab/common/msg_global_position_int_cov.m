classdef msg_global_position_int_cov < mavlink_message
	%MSG_GLOBAL_POSITION_INT_COV(packet,time_usec,lat,lon,alt,relative_alt,vx,vy,vz,covariance,estimator_type): MAVLINK Message ID = 63
    %Description:
    %    The filtered global position (e.g. fused GPS and accelerometers). The position is in GPS-frame (right-handed, Z-up). It  is designed as scaled integer message since the resolution of float is not sufficient. NOTE: This message is intended for onboard networks / companion computers and higher-bandwidth links and optimized for accuracy and completeness. Please use the GLOBAL_POSITION_INT message for a minimal subset.
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    time_usec(uint64): Timestamp (microseconds since system boot or since UNIX epoch)
    %    lat(int32): Latitude, expressed as degrees * 1E7
    %    lon(int32): Longitude, expressed as degrees * 1E7
    %    alt(int32): Altitude in meters, expressed as * 1000 (millimeters), above MSL
    %    relative_alt(int32): Altitude above ground in meters, expressed as * 1000 (millimeters)
    %    vx(single): Ground X Speed (Latitude), expressed as m/s
    %    vy(single): Ground Y Speed (Longitude), expressed as m/s
    %    vz(single): Ground Z Speed (Altitude), expressed as m/s
    %    covariance(single[36]): Covariance matrix (first six entries are the first ROW, next six entries are the second row, etc.)
    %    estimator_type(uint8): Class id of the estimator this estimate originated from.
	
	properties(Constant)
		ID = 63
		LEN = 127
	end
	
	properties
        time_usec	%Timestamp (microseconds since system boot or since UNIX epoch)	|	(uint64)
        lat	%Latitude, expressed as degrees * 1E7	|	(int32)
        lon	%Longitude, expressed as degrees * 1E7	|	(int32)
        alt	%Altitude in meters, expressed as * 1000 (millimeters), above MSL	|	(int32)
        relative_alt	%Altitude above ground in meters, expressed as * 1000 (millimeters)	|	(int32)
        vx	%Ground X Speed (Latitude), expressed as m/s	|	(single)
        vy	%Ground Y Speed (Longitude), expressed as m/s	|	(single)
        vz	%Ground Z Speed (Altitude), expressed as m/s	|	(single)
        covariance	%Covariance matrix (first six entries are the first ROW, next six entries are the second row, etc.)	|	(single[36])
        estimator_type	%Class id of the estimator this estimate originated from.	|	(uint8)
    end

    methods

        %Constructor: msg_global_position_int_cov
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_global_position_int_cov(packet,time_usec,lat,lon,alt,relative_alt,vx,vy,vz,covariance,estimator_type)
        
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
            
            elseif nargin-1 == 10
                obj.time_usec = time_usec;
                obj.lat = lat;
                obj.lon = lon;
                obj.alt = alt;
                obj.relative_alt = relative_alt;
                obj.vx = vx;
                obj.vy = vy;
                obj.vz = vz;
                obj.covariance = covariance;
                obj.estimator_type = estimator_type;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_global_position_int_cov.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_global_position_int_cov.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                packet.payload.putINT32(obj.lat);
                packet.payload.putINT32(obj.lon);
                packet.payload.putINT32(obj.alt);
                packet.payload.putINT32(obj.relative_alt);
                packet.payload.putSINGLE(obj.vx);
                packet.payload.putSINGLE(obj.vy);
                packet.payload.putSINGLE(obj.vz);
                for i=1:1:36
                    packet.payload.putSINGLE(obj.covariance(i));
                end
                packet.payload.putUINT8(obj.estimator_type);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.time_usec = payload.getUINT64();
            obj.lat = payload.getINT32();
            obj.lon = payload.getINT32();
            obj.alt = payload.getINT32();
            obj.relative_alt = payload.getINT32();
            obj.vx = payload.getSINGLE();
            obj.vy = payload.getSINGLE();
            obj.vz = payload.getSINGLE();
            for i=1:1:36
                obj.covariance(i) = payload.getSINGLE();
            end
            obj.estimator_type = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.lat,2) ~= 1
                result = 'lat';
            elseif size(obj.lon,2) ~= 1
                result = 'lon';
            elseif size(obj.alt,2) ~= 1
                result = 'alt';
            elseif size(obj.relative_alt,2) ~= 1
                result = 'relative_alt';
            elseif size(obj.vx,2) ~= 1
                result = 'vx';
            elseif size(obj.vy,2) ~= 1
                result = 'vy';
            elseif size(obj.vz,2) ~= 1
                result = 'vz';
            elseif size(obj.covariance,2) ~= 36
                result = 'covariance';
            elseif size(obj.estimator_type,2) ~= 1
                result = 'estimator_type';

            else
                result = 0;
            end
        end

        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
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
            if value == int32(value)
                obj.alt = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
        
        function set.relative_alt(obj,value)
            if value == int32(value)
                obj.relative_alt = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
        
        function set.vx(obj,value)
            obj.vx = single(value);
        end
        
        function set.vy(obj,value)
            obj.vy = single(value);
        end
        
        function set.vz(obj,value)
            obj.vz = single(value);
        end
        
        function set.covariance(obj,value)
            obj.covariance = single(value);
        end
        
        function set.estimator_type(obj,value)
            if value == uint8(value)
                obj.estimator_type = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end