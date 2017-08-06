classdef msg_vfr_hud < MAVLinkMessage
	%MSG_VFR_HUD: MAVLink Message ID = 74
    %Description:
    %    Metrics typically displayed on a HUD for fixed wing aircraft
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    airspeed(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    airspeed(single): Current airspeed in m/s
    %    groundspeed(single): Current ground speed in m/s
    %    alt(single): Current altitude (MSL), in meters
    %    climb(single): Current climb rate in meters/second
    %    heading(int16): Current heading in degrees, in compass units (0..360, 0=north)
    %    throttle(uint16): Current throttle setting in integer percent, 0 to 100
	
	properties(Constant)
		ID = 74
		LEN = 20
	end
	
	properties
        airspeed	%Current airspeed in m/s	|	(single)
        groundspeed	%Current ground speed in m/s	|	(single)
        alt	%Current altitude (MSL), in meters	|	(single)
        climb	%Current climb rate in meters/second	|	(single)
        heading	%Current heading in degrees, in compass units (0..360, 0=north)	|	(int16)
        throttle	%Current throttle setting in integer percent, 0 to 100	|	(uint16)
    end

    methods(Static)

        function send(out,airspeed,groundspeed,alt,climb,heading,throttle,varargin)

            if nargin == 6 + 1
                msg = msg_vfr_hud(airspeed,groundspeed,alt,climb,heading,throttle,varargin);
            elseif nargin == 2
                msg = msg_vfr_hud(airspeed);
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

        function obj = msg_vfr_hud(airspeed,groundspeed,alt,climb,heading,throttle,varargin)
        %MSG_VFR_HUD: Create a new vfr_hud message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(airspeed,'MAVLinkPacket')
                    packet = airspeed;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('airspeed','MAVLinkPacket');
                end
            elseif nargin >= 6 && isempty(varargin{1})
                obj.airspeed = airspeed;
                obj.groundspeed = groundspeed;
                obj.alt = alt;
                obj.climb = climb;
                obj.heading = heading;
                obj.throttle = throttle;
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

                packet = MAVLinkPacket(msg_vfr_hud.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_vfr_hud.ID;
                
                packet.payload.putSINGLE(obj.airspeed);
                packet.payload.putSINGLE(obj.groundspeed);
                packet.payload.putSINGLE(obj.alt);
                packet.payload.putSINGLE(obj.climb);
                packet.payload.putINT16(obj.heading);
                packet.payload.putUINT16(obj.throttle);

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
            
            obj.airspeed = payload.getSINGLE();
            obj.groundspeed = payload.getSINGLE();
            obj.alt = payload.getSINGLE();
            obj.climb = payload.getSINGLE();
            obj.heading = payload.getINT16();
            obj.throttle = payload.getUINT16();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.airspeed,2) ~= 1
                result = 'airspeed';
            elseif size(obj.groundspeed,2) ~= 1
                result = 'groundspeed';
            elseif size(obj.alt,2) ~= 1
                result = 'alt';
            elseif size(obj.climb,2) ~= 1
                result = 'climb';
            elseif size(obj.heading,2) ~= 1
                result = 'heading';
            elseif size(obj.throttle,2) ~= 1
                result = 'throttle';

            else
                result = 0;
            end
        end

        function set.airspeed(obj,value)
            obj.airspeed = single(value);
        end
        
        function set.groundspeed(obj,value)
            obj.groundspeed = single(value);
        end
        
        function set.alt(obj,value)
            obj.alt = single(value);
        end
        
        function set.climb(obj,value)
            obj.climb = single(value);
        end
        
        function set.heading(obj,value)
            if value == int16(value)
                obj.heading = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.throttle(obj,value)
            if value == uint16(value)
                obj.throttle = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
    end

end