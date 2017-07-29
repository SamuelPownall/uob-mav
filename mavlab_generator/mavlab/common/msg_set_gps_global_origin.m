classdef msg_set_gps_global_origin < mavlink_handle
	%MSG_SET_GPS_GLOBAL_ORIGIN(packet,latitude,longitude,altitude,target_system): MAVLINK Message ID = 48
    %Description:
    %    As local waypoints exist, the global MISSION reference allows to transform between the local coordinate frame and the global (GPS) coordinate frame. This can be necessary when e.g. in- and outdoor settings are connected and the MAV should move from in- to outdoor.
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    latitude(int32): Latitude (WGS84), in degrees * 1E7
    %    longitude(int32): Longitude (WGS84, in degrees * 1E7
    %    altitude(int32): Altitude (AMSL), in meters * 1000 (positive for up)
    %    target_system(uint8): System ID
	
	properties(Constant)
		ID = 48
		LEN = 13
	end
	
	properties
        latitude	%Latitude (WGS84), in degrees * 1E7	|	(int32)
        longitude	%Longitude (WGS84, in degrees * 1E7	|	(int32)
        altitude	%Altitude (AMSL), in meters * 1000 (positive for up)	|	(int32)
        target_system	%System ID	|	(uint8)
    end

    methods

        %Constructor: msg_set_gps_global_origin
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_set_gps_global_origin(packet,latitude,longitude,altitude,target_system)
        
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
            
            elseif nargin-1 == 4
                obj.latitude = latitude;
                obj.longitude = longitude;
                obj.altitude = altitude;
                obj.target_system = target_system;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_set_gps_global_origin.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_set_gps_global_origin.ID;
                
                packet.payload.putINT32(obj.latitude);
                packet.payload.putINT32(obj.longitude);
                packet.payload.putINT32(obj.altitude);
                packet.payload.putUINT8(obj.target_system);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.latitude = payload.getINT32();
            obj.longitude = payload.getINT32();
            obj.altitude = payload.getINT32();
            obj.target_system = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.latitude,2) ~= 1
                result = 'latitude';
            elseif size(obj.longitude,2) ~= 1
                result = 'longitude';
            elseif size(obj.altitude,2) ~= 1
                result = 'altitude';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';

            else
                result = 0;
            end
        end

        function set.latitude(obj,value)
            if value == int32(value)
                obj.latitude = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
        
        function set.longitude(obj,value)
            if value == int32(value)
                obj.longitude = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
        
        function set.altitude(obj,value)
            if value == int32(value)
                obj.altitude = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
        
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end