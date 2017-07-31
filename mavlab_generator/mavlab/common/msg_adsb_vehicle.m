classdef msg_adsb_vehicle < mavlink_message
	%MSG_ADSB_VEHICLE: MAVLINK Message ID = 246
    %Description:
    %    The location and information of an ADSB vehicle
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    ICAO_address(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    ICAO_address(uint32): ICAO address
    %    lat(int32): Latitude, expressed as degrees * 1E7
    %    lon(int32): Longitude, expressed as degrees * 1E7
    %    altitude(int32): Altitude(ASL) in millimeters
    %    heading(uint16): Course over ground in centidegrees
    %    hor_velocity(uint16): The horizontal velocity in centimeters/second
    %    ver_velocity(int16): The vertical velocity in centimeters/second, positive is up
    %    flags(uint16): Flags to indicate various statuses including valid data fields
    %    squawk(uint16): Squawk code
    %    altitude_type(uint8): Type from ADSB_ALTITUDE_TYPE enum
    %    callsign(uint8[9]): The callsign, 8+null
    %    emitter_type(uint8): Type from ADSB_EMITTER_TYPE enum
    %    tslc(uint8): Time since last communication in seconds
	
	properties(Constant)
		ID = 246
		LEN = 38
	end
	
	properties
        ICAO_address	%ICAO address	|	(uint32)
        lat	%Latitude, expressed as degrees * 1E7	|	(int32)
        lon	%Longitude, expressed as degrees * 1E7	|	(int32)
        altitude	%Altitude(ASL) in millimeters	|	(int32)
        heading	%Course over ground in centidegrees	|	(uint16)
        hor_velocity	%The horizontal velocity in centimeters/second	|	(uint16)
        ver_velocity	%The vertical velocity in centimeters/second, positive is up	|	(int16)
        flags	%Flags to indicate various statuses including valid data fields	|	(uint16)
        squawk	%Squawk code	|	(uint16)
        altitude_type	%Type from ADSB_ALTITUDE_TYPE enum	|	(uint8)
        callsign	%The callsign, 8+null	|	(uint8[9])
        emitter_type	%Type from ADSB_EMITTER_TYPE enum	|	(uint8)
        tslc	%Time since last communication in seconds	|	(uint8)
    end

    methods

        function obj = msg_adsb_vehicle(ICAO_address,lat,lon,altitude,heading,hor_velocity,ver_velocity,flags,squawk,altitude_type,callsign,emitter_type,tslc,varargin)
        %MSG_ADSB_VEHICLE: Create a new adsb_vehicle message object
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1 
                if isa(ICAO_address,'mavlink_packet')
                    packet = ICAO_address;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('ICAO_address','mavlink_packet');
                end
            elseif nargin == 13
                obj.ICAO_address = ICAO_address;
                obj.lat = lat;
                obj.lon = lon;
                obj.altitude = altitude;
                obj.heading = heading;
                obj.hor_velocity = hor_velocity;
                obj.ver_velocity = ver_velocity;
                obj.flags = flags;
                obj.squawk = squawk;
                obj.altitude_type = altitude_type;
                obj.callsign = callsign;
                obj.emitter_type = emitter_type;
                obj.tslc = tslc;
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

                packet = mavlink_packet(msg_adsb_vehicle.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_adsb_vehicle.ID;
                
                packet.payload.putUINT32(obj.ICAO_address);
                packet.payload.putINT32(obj.lat);
                packet.payload.putINT32(obj.lon);
                packet.payload.putINT32(obj.altitude);
                packet.payload.putUINT16(obj.heading);
                packet.payload.putUINT16(obj.hor_velocity);
                packet.payload.putINT16(obj.ver_velocity);
                packet.payload.putUINT16(obj.flags);
                packet.payload.putUINT16(obj.squawk);
                packet.payload.putUINT8(obj.altitude_type);
                for i=1:1:9
                    packet.payload.putUINT8(obj.callsign(i));
                end
                packet.payload.putUINT8(obj.emitter_type);
                packet.payload.putUINT8(obj.tslc);

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
            
            obj.ICAO_address = payload.getUINT32();
            obj.lat = payload.getINT32();
            obj.lon = payload.getINT32();
            obj.altitude = payload.getINT32();
            obj.heading = payload.getUINT16();
            obj.hor_velocity = payload.getUINT16();
            obj.ver_velocity = payload.getINT16();
            obj.flags = payload.getUINT16();
            obj.squawk = payload.getUINT16();
            obj.altitude_type = payload.getUINT8();
            for i=1:1:9
                obj.callsign(i) = payload.getUINT8();
            end
            obj.emitter_type = payload.getUINT8();
            obj.tslc = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.ICAO_address,2) ~= 1
                result = 'ICAO_address';
            elseif size(obj.lat,2) ~= 1
                result = 'lat';
            elseif size(obj.lon,2) ~= 1
                result = 'lon';
            elseif size(obj.altitude,2) ~= 1
                result = 'altitude';
            elseif size(obj.heading,2) ~= 1
                result = 'heading';
            elseif size(obj.hor_velocity,2) ~= 1
                result = 'hor_velocity';
            elseif size(obj.ver_velocity,2) ~= 1
                result = 'ver_velocity';
            elseif size(obj.flags,2) ~= 1
                result = 'flags';
            elseif size(obj.squawk,2) ~= 1
                result = 'squawk';
            elseif size(obj.altitude_type,2) ~= 1
                result = 'altitude_type';
            elseif size(obj.callsign,2) ~= 9
                result = 'callsign';
            elseif size(obj.emitter_type,2) ~= 1
                result = 'emitter_type';
            elseif size(obj.tslc,2) ~= 1
                result = 'tslc';

            else
                result = 0;
            end
        end

        function set.ICAO_address(obj,value)
            if value == uint32(value)
                obj.ICAO_address = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
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
        
        function set.altitude(obj,value)
            if value == int32(value)
                obj.altitude = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
        
        function set.heading(obj,value)
            if value == uint16(value)
                obj.heading = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.hor_velocity(obj,value)
            if value == uint16(value)
                obj.hor_velocity = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.ver_velocity(obj,value)
            if value == int16(value)
                obj.ver_velocity = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.flags(obj,value)
            if value == uint16(value)
                obj.flags = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.squawk(obj,value)
            if value == uint16(value)
                obj.squawk = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.altitude_type(obj,value)
            if value == uint8(value)
                obj.altitude_type = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.callsign(obj,value)
            if value == uint8(value)
                obj.callsign = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.emitter_type(obj,value)
            if value == uint8(value)
                obj.emitter_type = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.tslc(obj,value)
            if value == uint8(value)
                obj.tslc = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end