classdef msg_set_gps_global_origin < mavlink_message
	%MSG_SET_GPS_GLOBAL_ORIGIN: MAVLINK Message ID = 48
    %Description:
    %    As local waypoints exist, the global MISSION reference allows to transform between the local coordinate frame and the global (GPS) coordinate frame. This can be necessary when e.g. in- and outdoor settings are connected and the MAV should move from in- to outdoor.
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    latitude(mavlink_packet): Alternative way to construct a message using a mavlink_packet
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

        function obj = msg_set_gps_global_origin(latitude,longitude,altitude,target_system,varargin)
        %MSG_SET_GPS_GLOBAL_ORIGIN: Create a new set_gps_global_origin message object
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1 
                if isa(latitude,'mavlink_packet')
                    packet = latitude;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('latitude','mavlink_packet');
                end
            elseif nargin == 4
                obj.latitude = latitude;
                obj.longitude = longitude;
                obj.altitude = altitude;
                obj.target_system = target_system;
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

        function unpack(obj, payload)
        %UNPACK: Unpacks a mavlink_payload into this MAVLINK message
        %Description:
        %    Extracts the data from a mavlink_payload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(mavlink_payload): The payload to be unpacked into this MAVLINK message

            payload.resetIndex();
            
            obj.latitude = payload.getINT32();
            obj.longitude = payload.getINT32();
            obj.altitude = payload.getINT32();
            obj.target_system = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

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