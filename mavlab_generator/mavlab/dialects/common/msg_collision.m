classdef msg_collision < MAVLinkMessage
	%MSG_COLLISION: MAVLink Message ID = 247
    %Description:
    %    Information about a potential collision
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    id(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    id(uint32): Unique identifier, domain based on src field
    %    time_to_minimum_delta(single): Estimated time until collision occurs (seconds)
    %    altitude_minimum_delta(single): Closest vertical distance in meters between vehicle and object
    %    horizontal_minimum_delta(single): Closest horizontal distance in meteres between vehicle and object
    %    src(uint8): Collision data source
    %    action(uint8): Action that is being taken to avoid this collision
    %    threat_level(uint8): How concerned the aircraft is about this collision
	
	properties(Constant)
		ID = 247
		LEN = 19
	end
	
	properties
        id	%Unique identifier, domain based on src field	|	(uint32)
        time_to_minimum_delta	%Estimated time until collision occurs (seconds)	|	(single)
        altitude_minimum_delta	%Closest vertical distance in meters between vehicle and object	|	(single)
        horizontal_minimum_delta	%Closest horizontal distance in meteres between vehicle and object	|	(single)
        src	%Collision data source	|	(uint8)
        action	%Action that is being taken to avoid this collision	|	(uint8)
        threat_level	%How concerned the aircraft is about this collision	|	(uint8)
    end

    methods(Static)

        function send(out,id,time_to_minimum_delta,altitude_minimum_delta,horizontal_minimum_delta,src,action,threat_level,varargin)

            if nargin == 7 + 1
                msg = msg_collision(id,time_to_minimum_delta,altitude_minimum_delta,horizontal_minimum_delta,src,action,threat_level,varargin);
            elseif nargin == 2
                msg = msg_collision(id);
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

        function obj = msg_collision(id,time_to_minimum_delta,altitude_minimum_delta,horizontal_minimum_delta,src,action,threat_level,varargin)
        %MSG_COLLISION: Create a new collision message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(id,'MAVLinkPacket')
                    packet = id;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('id','MAVLinkPacket');
                end
            elseif nargin >= 7 && isempty(varargin{1})
                obj.id = id;
                obj.time_to_minimum_delta = time_to_minimum_delta;
                obj.altitude_minimum_delta = altitude_minimum_delta;
                obj.horizontal_minimum_delta = horizontal_minimum_delta;
                obj.src = src;
                obj.action = action;
                obj.threat_level = threat_level;
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

                packet = MAVLinkPacket(msg_collision.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_collision.ID;
                
                packet.payload.putUINT32(obj.id);
                packet.payload.putSINGLE(obj.time_to_minimum_delta);
                packet.payload.putSINGLE(obj.altitude_minimum_delta);
                packet.payload.putSINGLE(obj.horizontal_minimum_delta);
                packet.payload.putUINT8(obj.src);
                packet.payload.putUINT8(obj.action);
                packet.payload.putUINT8(obj.threat_level);

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
            
            obj.id = payload.getUINT32();
            obj.time_to_minimum_delta = payload.getSINGLE();
            obj.altitude_minimum_delta = payload.getSINGLE();
            obj.horizontal_minimum_delta = payload.getSINGLE();
            obj.src = payload.getUINT8();
            obj.action = payload.getUINT8();
            obj.threat_level = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.id,2) ~= 1
                result = 'id';
            elseif size(obj.time_to_minimum_delta,2) ~= 1
                result = 'time_to_minimum_delta';
            elseif size(obj.altitude_minimum_delta,2) ~= 1
                result = 'altitude_minimum_delta';
            elseif size(obj.horizontal_minimum_delta,2) ~= 1
                result = 'horizontal_minimum_delta';
            elseif size(obj.src,2) ~= 1
                result = 'src';
            elseif size(obj.action,2) ~= 1
                result = 'action';
            elseif size(obj.threat_level,2) ~= 1
                result = 'threat_level';

            else
                result = 0;
            end
        end

        function set.id(obj,value)
            if value == uint32(value)
                obj.id = uint32(value);
            else
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.time_to_minimum_delta(obj,value)
            obj.time_to_minimum_delta = single(value);
        end
        
        function set.altitude_minimum_delta(obj,value)
            obj.altitude_minimum_delta = single(value);
        end
        
        function set.horizontal_minimum_delta(obj,value)
            obj.horizontal_minimum_delta = single(value);
        end
        
        function set.src(obj,value)
            if value == uint8(value)
                obj.src = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.action(obj,value)
            if value == uint8(value)
                obj.action = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.threat_level(obj,value)
            if value == uint8(value)
                obj.threat_level = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end