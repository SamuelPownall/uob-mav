classdef msg_wind < mavlink_message
	%MSG_WIND(packet,direction,speed,speed_z): MAVLINK Message ID = 168
    %Description:
    %    Wind estimation
    %    If constructing from fields, packet argument should be set to []
	%Fields:
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

        %Constructor: msg_wind
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_wind(packet,direction,speed,speed_z)
        
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
            
            elseif nargin-1 == 3
                obj.direction = direction;
                obj.speed = speed;
                obj.speed_z = speed_z;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

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

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.direction = payload.getSINGLE();
            obj.speed = payload.getSINGLE();
            obj.speed_z = payload.getSINGLE();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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