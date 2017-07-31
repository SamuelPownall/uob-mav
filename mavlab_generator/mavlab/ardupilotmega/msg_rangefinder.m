classdef msg_rangefinder < mavlink_message
	%MSG_RANGEFINDER: MAVLINK Message ID = 173
    %Description:
    %    Rangefinder reporting
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    distance(mavlink_packet): Alternative way to construct a message using a mavlink_packet
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

        function obj = msg_rangefinder(distance,voltage,varargin)
        %Create a new rangefinder message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(distance,'mavlink_packet')
                    packet = distance;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('distance','mavlink_packet');
                end
            
            elseif nargin == 2
                obj.distance = distance;
                obj.voltage = voltage;
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

        function unpack(obj, payload)
        %UNPACK: Unpacks a mavlink_payload into this MAVLINK message
        %Description:
        %    Extracts the data from a mavlink_payload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(mavlink_payload): The payload to be unpacked into this MAVLINK message

            payload.resetIndex();
            
            obj.distance = payload.getSINGLE();
            obj.voltage = payload.getSINGLE();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

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