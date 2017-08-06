classdef msg_wind < MAVLinkMessage
	%MSG_WIND: MAVLink Message ID = 168
    %Description:
    %    Wind estimation
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    direction(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    direction(single): wind direction that wind is coming from (degrees)
    %    speed(single): wind speed in ground plane (m/s)
    %    speed_z(single): vertical wind speed (m/s)
	
	properties(Constant)
		ID = 168
		LEN = 12
	end
	
	properties
        direction	%wind direction that wind is coming from (degrees)	|	(single)
        speed	%wind speed in ground plane (m/s)	|	(single)
        speed_z	%vertical wind speed (m/s)	|	(single)
    end

    methods(Static)

        function send(out,direction,speed,speed_z,varargin)

            if nargin == 3 + 1
                msg = msg_wind(direction,speed,speed_z,varargin);
            elseif nargin == 2
                msg = msg_wind(direction);
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

        function obj = msg_wind(direction,speed,speed_z,varargin)
        %MSG_WIND: Create a new wind message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(direction,'MAVLinkPacket')
                    packet = direction;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('direction','MAVLinkPacket');
                end
            elseif nargin >= 3 && isempty(varargin{1})
                obj.direction = direction;
                obj.speed = speed;
                obj.speed_z = speed_z;
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

                packet = MAVLinkPacket(msg_wind.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_wind.ID;
                
                packet.payload.putSINGLE(obj.direction);
                packet.payload.putSINGLE(obj.speed);
                packet.payload.putSINGLE(obj.speed_z);

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
            
            obj.direction = payload.getSINGLE();
            obj.speed = payload.getSINGLE();
            obj.speed_z = payload.getSINGLE();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.direction,2) ~= 1
                result = 'direction';
            elseif size(obj.speed,2) ~= 1
                result = 'speed';
            elseif size(obj.speed_z,2) ~= 1
                result = 'speed_z';

            else
                result = 0;
            end
        end

        function set.direction(obj,value)
            obj.direction = single(value);
        end
        
        function set.speed(obj,value)
            obj.speed = single(value);
        end
        
        function set.speed_z(obj,value)
            obj.speed_z = single(value);
        end
        
    end

end