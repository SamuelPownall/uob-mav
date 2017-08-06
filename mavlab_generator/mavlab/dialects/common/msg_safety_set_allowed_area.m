classdef msg_safety_set_allowed_area < MAVLinkMessage
	%MSG_SAFETY_SET_ALLOWED_AREA: MAVLink Message ID = 54
    %Description:
    %    Set a safety zone (volume), which is defined by two corners of a cube. This message can be used to tell the MAV which setpoints/MISSIONs to accept and which to reject. Safety areas are often enforced by national or competition regulations.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    p1x(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    p1x(single): x position 1 / Latitude 1
    %    p1y(single): y position 1 / Longitude 1
    %    p1z(single): z position 1 / Altitude 1
    %    p2x(single): x position 2 / Latitude 2
    %    p2y(single): y position 2 / Longitude 2
    %    p2z(single): z position 2 / Altitude 2
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
    %    frame(uint8): Coordinate frame, as defined by MAV_FRAME enum in mavlink_types.h. Can be either global, GPS, right-handed with Z axis up or local, right handed, Z axis down.
	
	properties(Constant)
		ID = 54
		LEN = 27
	end
	
	properties
        p1x	%x position 1 / Latitude 1	|	(single)
        p1y	%y position 1 / Longitude 1	|	(single)
        p1z	%z position 1 / Altitude 1	|	(single)
        p2x	%x position 2 / Latitude 2	|	(single)
        p2y	%y position 2 / Longitude 2	|	(single)
        p2z	%z position 2 / Altitude 2	|	(single)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
        frame	%Coordinate frame, as defined by MAV_FRAME enum in mavlink_types.h. Can be either global, GPS, right-handed with Z axis up or local, right handed, Z axis down.	|	(uint8)
    end

    methods(Static)

        function send(out,p1x,p1y,p1z,p2x,p2y,p2z,target_system,target_component,frame,varargin)

            if nargin == 9 + 1
                msg = msg_safety_set_allowed_area(p1x,p1y,p1z,p2x,p2y,p2z,target_system,target_component,frame,varargin);
            elseif nargin == 2
                msg = msg_safety_set_allowed_area(p1x);
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

        function obj = msg_safety_set_allowed_area(p1x,p1y,p1z,p2x,p2y,p2z,target_system,target_component,frame,varargin)
        %MSG_SAFETY_SET_ALLOWED_AREA: Create a new safety_set_allowed_area message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(p1x,'MAVLinkPacket')
                    packet = p1x;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('p1x','MAVLinkPacket');
                end
            elseif nargin >= 9 && isempty(varargin{1})
                obj.p1x = p1x;
                obj.p1y = p1y;
                obj.p1z = p1z;
                obj.p2x = p2x;
                obj.p2y = p2y;
                obj.p2z = p2z;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.frame = frame;
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

                packet = MAVLinkPacket(msg_safety_set_allowed_area.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_safety_set_allowed_area.ID;
                
                packet.payload.putSINGLE(obj.p1x);
                packet.payload.putSINGLE(obj.p1y);
                packet.payload.putSINGLE(obj.p1z);
                packet.payload.putSINGLE(obj.p2x);
                packet.payload.putSINGLE(obj.p2y);
                packet.payload.putSINGLE(obj.p2z);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                packet.payload.putUINT8(obj.frame);

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
            
            obj.p1x = payload.getSINGLE();
            obj.p1y = payload.getSINGLE();
            obj.p1z = payload.getSINGLE();
            obj.p2x = payload.getSINGLE();
            obj.p2y = payload.getSINGLE();
            obj.p2z = payload.getSINGLE();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            obj.frame = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.p1x,2) ~= 1
                result = 'p1x';
            elseif size(obj.p1y,2) ~= 1
                result = 'p1y';
            elseif size(obj.p1z,2) ~= 1
                result = 'p1z';
            elseif size(obj.p2x,2) ~= 1
                result = 'p2x';
            elseif size(obj.p2y,2) ~= 1
                result = 'p2y';
            elseif size(obj.p2z,2) ~= 1
                result = 'p2z';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';
            elseif size(obj.frame,2) ~= 1
                result = 'frame';

            else
                result = 0;
            end
        end

        function set.p1x(obj,value)
            obj.p1x = single(value);
        end
        
        function set.p1y(obj,value)
            obj.p1y = single(value);
        end
        
        function set.p1z(obj,value)
            obj.p1z = single(value);
        end
        
        function set.p2x(obj,value)
            obj.p2x = single(value);
        end
        
        function set.p2y(obj,value)
            obj.p2y = single(value);
        end
        
        function set.p2z(obj,value)
            obj.p2z = single(value);
        end
        
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.frame(obj,value)
            if value == uint8(value)
                obj.frame = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end