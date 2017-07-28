classdef msg_ahrs2 < mavlink_message
	%MSG_AHRS2(packet,roll,pitch,yaw,altitude,lat,lng): MAVLINK Message ID = 178
    %Description:
    %    Status of secondary AHRS filter if available
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    roll(single): Roll angle (rad)
    %    pitch(single): Pitch angle (rad)
    %    yaw(single): Yaw angle (rad)
    %    altitude(single): Altitude (MSL)
    %    lat(int32): Latitude in degrees * 1E7
    %    lng(int32): Longitude in degrees * 1E7
	
	properties(Constant)
		ID = 178
		LEN = 24
	end
	
	properties
        roll	%Roll angle (rad)	|	(single)
        pitch	%Pitch angle (rad)	|	(single)
        yaw	%Yaw angle (rad)	|	(single)
        altitude	%Altitude (MSL)	|	(single)
        lat	%Latitude in degrees * 1E7	|	(int32)
        lng	%Longitude in degrees * 1E7	|	(int32)
    end

    methods

        %Constructor: msg_ahrs2
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_ahrs2(packet,roll,pitch,yaw,altitude,lat,lng)
        
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
                obj.roll = roll;
                obj.pitch = pitch;
                obj.yaw = yaw;
                obj.altitude = altitude;
                obj.lat = lat;
                obj.lng = lng;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_ahrs2.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_ahrs2.ID;
                
                packet.payload.putSINGLE(obj.roll);
                packet.payload.putSINGLE(obj.pitch);
                packet.payload.putSINGLE(obj.yaw);
                packet.payload.putSINGLE(obj.altitude);
                packet.payload.putINT32(obj.lat);
                packet.payload.putINT32(obj.lng);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.roll = payload.getSINGLE();
            obj.pitch = payload.getSINGLE();
            obj.yaw = payload.getSINGLE();
            obj.altitude = payload.getSINGLE();
            obj.lat = payload.getINT32();
            obj.lng = payload.getINT32();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.roll,2) ~= 1
                result = 'roll';
            elseif size(obj.pitch,2) ~= 1
                result = 'pitch';
            elseif size(obj.yaw,2) ~= 1
                result = 'yaw';
            elseif size(obj.altitude,2) ~= 1
                result = 'altitude';
            elseif size(obj.lat,2) ~= 1
                result = 'lat';
            elseif size(obj.lng,2) ~= 1
                result = 'lng';

            else
                result = 0;
            end
        end

        function set.roll(obj,value)
            obj.roll = single(value);
        end
        
        function set.pitch(obj,value)
            obj.pitch = single(value);
        end
        
        function set.yaw(obj,value)
            obj.yaw = single(value);
        end
        
        function set.altitude(obj,value)
            obj.altitude = single(value);
        end
        
        function set.lat(obj,value)
            if value == int32(value)
                obj.lat = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
        
        function set.lng(obj,value)
            if value == int32(value)
                obj.lng = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
        
    end

end