classdef msg_rangefinder < MAVLinkMessage
	%MSG_RANGEFINDER: MAVLink Message ID = 173
    %Description:
    %    Rangefinder reporting
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    distance(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,distance,voltage,varargin)

            if nargin == 2 + 1
                msg = msg_rangefinder(distance,voltage,varargin);
            elseif nargin == 2
                msg = msg_rangefinder(distance);
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

        function obj = msg_rangefinder(distance,voltage,varargin)
        %MSG_RANGEFINDER: Create a new rangefinder message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(distance,'MAVLinkPacket')
                    packet = distance;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('distance','MAVLinkPacket');
                end
            elseif nargin >= 2 && isempty(varargin{1})
                obj.distance = distance;
                obj.voltage = voltage;
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

                packet = MAVLinkPacket(msg_rangefinder.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_rangefinder.ID;
                
                packet.payload.putSINGLE(obj.distance);
                packet.payload.putSINGLE(obj.voltage);

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