classdef msg_wind < mavlink_message
	%MSG_WIND: MAVLINK Message ID = 168
    %Description:
    %    Wind estimation
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    direction(mavlink_packet): Alternative way to construct a message using a mavlink_packet
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

    methods

        function obj = msg_wind(direction,speed,speed_z,varargin)
        %Create a new wind message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(direction,'mavlink_packet')
                    packet = direction;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('direction','mavlink_packet');
                end
            
            elseif nargin == 3
                obj.direction = direction;
                obj.speed = speed;
                obj.speed_z = speed_z;
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

                packet = mavlink_packet(msg_wind.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_wind.ID;
                
                packet.payload.putSINGLE(obj.direction);
                packet.payload.putSINGLE(obj.speed);
                packet.payload.putSINGLE(obj.speed_z);

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