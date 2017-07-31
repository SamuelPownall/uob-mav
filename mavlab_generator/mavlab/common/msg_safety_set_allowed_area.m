classdef msg_safety_set_allowed_area < mavlink_message
	%MSG_SAFETY_SET_ALLOWED_AREA: MAVLINK Message ID = 54
    %Description:
    %    Set a safety zone (volume), which is defined by two corners of a cube. This message can be used to tell the MAV which setpoints/MISSIONs to accept and which to reject. Safety areas are often enforced by national or competition regulations.
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    p1x(mavlink_packet): Alternative way to construct a message using a mavlink_packet
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

    methods

        function obj = msg_safety_set_allowed_area(p1x,p1y,p1z,p2x,p2y,p2z,target_system,target_component,frame,varargin)
        %MSG_SAFETY_SET_ALLOWED_AREA: Create a new safety_set_allowed_area message object
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1 
                if isa(p1x,'mavlink_packet')
                    packet = p1x;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('p1x','mavlink_packet');
                end
            elseif nargin == 9
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

                packet = mavlink_packet(msg_safety_set_allowed_area.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
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
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.frame(obj,value)
            if value == uint8(value)
                obj.frame = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end