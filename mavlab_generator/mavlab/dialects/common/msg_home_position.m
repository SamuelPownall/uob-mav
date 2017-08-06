classdef msg_home_position < MAVLinkMessage
	%MSG_HOME_POSITION: MAVLink Message ID = 242
    %Description:
    %    This message can be requested by sending the MAV_CMD_GET_HOME_POSITION command. The position the system will return to and land on. The position is set automatically by the system during the takeoff in case it was not explicitely set by the operator before or after. The position the system will return to and land on. The global and local positions encode the position in the respective coordinate frames, while the q parameter encodes the orientation of the surface. Under normal conditions it describes the heading and terrain slope, which can be used by the aircraft to adjust the approach. The approach 3D vector describes the point to which the system should fly in normal flight mode and then perform a landing sequence along the vector.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    latitude(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    latitude(int32): Latitude (WGS84), in degrees * 1E7
    %    longitude(int32): Longitude (WGS84, in degrees * 1E7
    %    altitude(int32): Altitude (AMSL), in meters * 1000 (positive for up)
    %    x(single): Local X position of this position in the local coordinate frame
    %    y(single): Local Y position of this position in the local coordinate frame
    %    z(single): Local Z position of this position in the local coordinate frame
    %    q(single[4]): World to surface normal and heading transformation of the takeoff position. Used to indicate the heading and slope of the ground
    %    approach_x(single): Local X position of the end of the approach vector. Multicopters should set this position based on their takeoff path. Grass-landing fixed wing aircraft should set it the same way as multicopters. Runway-landing fixed wing aircraft should set it to the opposite direction of the takeoff, assuming the takeoff happened from the threshold / touchdown zone.
    %    approach_y(single): Local Y position of the end of the approach vector. Multicopters should set this position based on their takeoff path. Grass-landing fixed wing aircraft should set it the same way as multicopters. Runway-landing fixed wing aircraft should set it to the opposite direction of the takeoff, assuming the takeoff happened from the threshold / touchdown zone.
    %    approach_z(single): Local Z position of the end of the approach vector. Multicopters should set this position based on their takeoff path. Grass-landing fixed wing aircraft should set it the same way as multicopters. Runway-landing fixed wing aircraft should set it to the opposite direction of the takeoff, assuming the takeoff happened from the threshold / touchdown zone.
	
	properties(Constant)
		ID = 242
		LEN = 52
	end
	
	properties
        latitude	%Latitude (WGS84), in degrees * 1E7	|	(int32)
        longitude	%Longitude (WGS84, in degrees * 1E7	|	(int32)
        altitude	%Altitude (AMSL), in meters * 1000 (positive for up)	|	(int32)
        x	%Local X position of this position in the local coordinate frame	|	(single)
        y	%Local Y position of this position in the local coordinate frame	|	(single)
        z	%Local Z position of this position in the local coordinate frame	|	(single)
        q	%World to surface normal and heading transformation of the takeoff position. Used to indicate the heading and slope of the ground	|	(single[4])
        approach_x	%Local X position of the end of the approach vector. Multicopters should set this position based on their takeoff path. Grass-landing fixed wing aircraft should set it the same way as multicopters. Runway-landing fixed wing aircraft should set it to the opposite direction of the takeoff, assuming the takeoff happened from the threshold / touchdown zone.	|	(single)
        approach_y	%Local Y position of the end of the approach vector. Multicopters should set this position based on their takeoff path. Grass-landing fixed wing aircraft should set it the same way as multicopters. Runway-landing fixed wing aircraft should set it to the opposite direction of the takeoff, assuming the takeoff happened from the threshold / touchdown zone.	|	(single)
        approach_z	%Local Z position of the end of the approach vector. Multicopters should set this position based on their takeoff path. Grass-landing fixed wing aircraft should set it the same way as multicopters. Runway-landing fixed wing aircraft should set it to the opposite direction of the takeoff, assuming the takeoff happened from the threshold / touchdown zone.	|	(single)
    end

    methods(Static)

        function send(out,latitude,longitude,altitude,x,y,z,q,approach_x,approach_y,approach_z,varargin)

            if nargin == 10 + 1
                msg = msg_home_position(latitude,longitude,altitude,x,y,z,q,approach_x,approach_y,approach_z,varargin);
            elseif nargin == 2
                msg = msg_home_position(latitude);
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

        function obj = msg_home_position(latitude,longitude,altitude,x,y,z,q,approach_x,approach_y,approach_z,varargin)
        %MSG_HOME_POSITION: Create a new home_position message object
        
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
            elseif nargin >= 10 && isempty(varargin{1})
                obj.latitude = latitude;
                obj.longitude = longitude;
                obj.altitude = altitude;
                obj.x = x;
                obj.y = y;
                obj.z = z;
                obj.q = q;
                obj.approach_x = approach_x;
                obj.approach_y = approach_y;
                obj.approach_z = approach_z;
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

                packet = MAVLinkPacket(msg_home_position.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_home_position.ID;
                
                packet.payload.putINT32(obj.latitude);
                packet.payload.putINT32(obj.longitude);
                packet.payload.putINT32(obj.altitude);
                packet.payload.putSINGLE(obj.x);
                packet.payload.putSINGLE(obj.y);
                packet.payload.putSINGLE(obj.z);
                for i=1:1:4
                    packet.payload.putSINGLE(obj.q(i));
                end
                packet.payload.putSINGLE(obj.approach_x);
                packet.payload.putSINGLE(obj.approach_y);
                packet.payload.putSINGLE(obj.approach_z);

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
            obj.x = payload.getSINGLE();
            obj.y = payload.getSINGLE();
            obj.z = payload.getSINGLE();
            for i=1:1:4
                obj.q(i) = payload.getSINGLE();
            end
            obj.approach_x = payload.getSINGLE();
            obj.approach_y = payload.getSINGLE();
            obj.approach_z = payload.getSINGLE();

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
            elseif size(obj.x,2) ~= 1
                result = 'x';
            elseif size(obj.y,2) ~= 1
                result = 'y';
            elseif size(obj.z,2) ~= 1
                result = 'z';
            elseif size(obj.q,2) ~= 4
                result = 'q';
            elseif size(obj.approach_x,2) ~= 1
                result = 'approach_x';
            elseif size(obj.approach_y,2) ~= 1
                result = 'approach_y';
            elseif size(obj.approach_z,2) ~= 1
                result = 'approach_z';

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
        
        function set.x(obj,value)
            obj.x = single(value);
        end
        
        function set.y(obj,value)
            obj.y = single(value);
        end
        
        function set.z(obj,value)
            obj.z = single(value);
        end
        
        function set.q(obj,value)
            obj.q = single(value);
        end
        
        function set.approach_x(obj,value)
            obj.approach_x = single(value);
        end
        
        function set.approach_y(obj,value)
            obj.approach_y = single(value);
        end
        
        function set.approach_z(obj,value)
            obj.approach_z = single(value);
        end
        
    end

end