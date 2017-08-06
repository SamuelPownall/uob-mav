classdef msg_ahrs2 < MAVLinkMessage
	%MSG_AHRS2: MAVLink Message ID = 178
    %Description:
    %    Status of secondary AHRS filter if available
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    roll(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,roll,pitch,yaw,altitude,lat,lng,varargin)

            if nargin == 6 + 1
                msg = msg_ahrs2(roll,pitch,yaw,altitude,lat,lng,varargin);
            elseif nargin == 2
                msg = msg_ahrs2(roll);
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

        function obj = msg_ahrs2(roll,pitch,yaw,altitude,lat,lng,varargin)
        %MSG_AHRS2: Create a new ahrs2 message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(roll,'MAVLinkPacket')
                    packet = roll;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('roll','MAVLinkPacket');
                end
            elseif nargin >= 6 && isempty(varargin{1})
                obj.roll = roll;
                obj.pitch = pitch;
                obj.yaw = yaw;
                obj.altitude = altitude;
                obj.lat = lat;
                obj.lng = lng;
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

                packet = MAVLinkPacket(msg_ahrs2.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_ahrs2.ID;
                
                packet.payload.putSINGLE(obj.roll);
                packet.payload.putSINGLE(obj.pitch);
                packet.payload.putSINGLE(obj.yaw);
                packet.payload.putSINGLE(obj.altitude);
                packet.payload.putINT32(obj.lat);
                packet.payload.putINT32(obj.lng);

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
            
            obj.roll = payload.getSINGLE();
            obj.pitch = payload.getSINGLE();
            obj.yaw = payload.getSINGLE();
            obj.altitude = payload.getSINGLE();
            obj.lat = payload.getINT32();
            obj.lng = payload.getINT32();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

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
        
    end

end