classdef msg_gps_global_origin < MAVLinkMessage
	%MSG_GPS_GLOBAL_ORIGIN: MAVLink Message ID = 49
    %Description:
    %    Once the MAV sets a new GPS-Local correspondence, this message announces the origin (0,0,0) position
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    latitude(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    latitude(int32): Latitude (WGS84), in degrees * 1E7
    %    longitude(int32): Longitude (WGS84), in degrees * 1E7
    %    altitude(int32): Altitude (AMSL), in meters * 1000 (positive for up)
	
	properties(Constant)
		ID = 49
		LEN = 12
	end
	
	properties
        latitude	%Latitude (WGS84), in degrees * 1E7	|	(int32)
        longitude	%Longitude (WGS84), in degrees * 1E7	|	(int32)
        altitude	%Altitude (AMSL), in meters * 1000 (positive for up)	|	(int32)
    end

    methods(Static)

        function send(out,latitude,longitude,altitude,varargin)

            if nargin == 3 + 1
                msg = msg_gps_global_origin(latitude,longitude,altitude,varargin);
            elseif nargin == 2
                msg = msg_gps_global_origin(latitude);
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

        function obj = msg_gps_global_origin(latitude,longitude,altitude,varargin)
        %MSG_GPS_GLOBAL_ORIGIN: Create a new gps_global_origin message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(latitude,'MAVLinkPacket')
                    packet = latitude;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('latitude','MAVLinkPacket');
                end
            elseif nargin >= 3 && isempty(varargin{1})
                obj.latitude = latitude;
                obj.longitude = longitude;
                obj.altitude = altitude;
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

                packet = MAVLinkPacket(msg_gps_global_origin.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_gps_global_origin.ID;
                
                packet.payload.putINT32(obj.latitude);
                packet.payload.putINT32(obj.longitude);
                packet.payload.putINT32(obj.altitude);

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
            
            obj.latitude = payload.getINT32();
            obj.longitude = payload.getINT32();
            obj.altitude = payload.getINT32();

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

            else
                result = 0;
            end
        end

        function set.latitude(obj,value)
            if value == int32(value)
                obj.latitude = int32(value);
            else
                MAVLink.throwTypeError('value','int32');
            end
        end
        
        function set.longitude(obj,value)
            if value == int32(value)
                obj.longitude = int32(value);
            else
                MAVLink.throwTypeError('value','int32');
            end
        end
        
        function set.altitude(obj,value)
            if value == int32(value)
                obj.altitude = int32(value);
            else
                MAVLink.throwTypeError('value','int32');
            end
        end
        
    end

end