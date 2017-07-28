classdef msg_rangefinder < mavlink_message
	%MSG_RANGEFINDER(packet,distance,voltage): MAVLINK Message ID = 173
    %Description:
    %    Rangefinder reporting
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    distance(single): distance in meters
    %    voltage(single): raw voltage if available, zero otherwise
	
	properties(Constant)
		ID = 173
		LEN = 8
	end
	
	properties
        distance	%distance in meters	|	(single)
        voltage	%raw voltage if available, zero otherwise	|	(single)
    end

    methods

        %Constructor: msg_rangefinder
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_rangefinder(packet,distance,voltage)
        
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
            
            elseif nargin-1 == 2
                obj.distance = distance;
                obj.voltage = voltage;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_rangefinder.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_rangefinder.ID;
                
                packet.payload.putSINGLE(obj.distance);
                packet.payload.putSINGLE(obj.voltage);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.distance = payload.getSINGLE();
            obj.voltage = payload.getSINGLE();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.distance,2) ~= 1
                result = 'distance';
            elseif size(obj.voltage,2) ~= 1
                result = 'voltage';

            else
                result = 0;
            end
        end

        function set.distance(obj,value)
            obj.distance = single(value);
        end
        
        function set.voltage(obj,value)
            obj.voltage = single(value);
        end
        
    end

end