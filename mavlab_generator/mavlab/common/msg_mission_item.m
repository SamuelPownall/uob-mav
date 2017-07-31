classdef msg_mission_item < mavlink_message
	%MSG_MISSION_ITEM: MAVLINK Message ID = 39
    %Description:
    %    Message encoding a mission item. This message is emitted to announce
                the presence of a mission item and to set a mission item on the system. The mission item can be either in x, y, z meters (type: LOCAL) or x:lat, y:lon, z:altitude. Local frame is Z-down, right handed (NED), global frame is Z-up, right handed (ENU). See also http://qgroundcontrol.org/mavlink/waypoint_protocol.
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    param1(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    param1(single): PARAM1, see MAV_CMD enum
    %    param2(single): PARAM2, see MAV_CMD enum
    %    param3(single): PARAM3, see MAV_CMD enum
    %    param4(single): PARAM4, see MAV_CMD enum
    %    x(single): PARAM5 / local: x position, global: latitude
    %    y(single): PARAM6 / y position: global: longitude
    %    z(single): PARAM7 / z position: global: altitude (relative or absolute, depending on frame.
    %    seq(uint16): Sequence
    %    command(uint16): The scheduled action for the MISSION. see MAV_CMD in common.xml MAVLink specs
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
    %    frame(uint8): The coordinate system of the MISSION. see MAV_FRAME in mavlink_types.h
    %    current(uint8): false:0, true:1
    %    autocontinue(uint8): autocontinue to next wp
	
	properties(Constant)
		ID = 39
		LEN = 37
	end
	
	properties
        param1	%PARAM1, see MAV_CMD enum	|	(single)
        param2	%PARAM2, see MAV_CMD enum	|	(single)
        param3	%PARAM3, see MAV_CMD enum	|	(single)
        param4	%PARAM4, see MAV_CMD enum	|	(single)
        x	%PARAM5 / local: x position, global: latitude	|	(single)
        y	%PARAM6 / y position: global: longitude	|	(single)
        z	%PARAM7 / z position: global: altitude (relative or absolute, depending on frame.	|	(single)
        seq	%Sequence	|	(uint16)
        command	%The scheduled action for the MISSION. see MAV_CMD in common.xml MAVLink specs	|	(uint16)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
        frame	%The coordinate system of the MISSION. see MAV_FRAME in mavlink_types.h	|	(uint8)
        current	%false:0, true:1	|	(uint8)
        autocontinue	%autocontinue to next wp	|	(uint8)
    end

    methods

        function obj = msg_mission_item(param1,param2,param3,param4,x,y,z,seq,command,target_system,target_component,frame,current,autocontinue,varargin)
        %Create a new mission_item message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(param1,'mavlink_packet')
                    packet = param1;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('param1','mavlink_packet');
                end
            
            elseif nargin == 14
                obj.param1 = param1;
                obj.param2 = param2;
                obj.param3 = param3;
                obj.param4 = param4;
                obj.x = x;
                obj.y = y;
                obj.z = z;
                obj.seq = seq;
                obj.command = command;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.frame = frame;
                obj.current = current;
                obj.autocontinue = autocontinue;
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

                packet = mavlink_packet(msg_mission_item.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_mission_item.ID;
                
                packet.payload.putSINGLE(obj.param1);
                packet.payload.putSINGLE(obj.param2);
                packet.payload.putSINGLE(obj.param3);
                packet.payload.putSINGLE(obj.param4);
                packet.payload.putSINGLE(obj.x);
                packet.payload.putSINGLE(obj.y);
                packet.payload.putSINGLE(obj.z);
                packet.payload.putUINT16(obj.seq);
                packet.payload.putUINT16(obj.command);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                packet.payload.putUINT8(obj.frame);
                packet.payload.putUINT8(obj.current);
                packet.payload.putUINT8(obj.autocontinue);

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
            
            obj.param1 = payload.getSINGLE();
            obj.param2 = payload.getSINGLE();
            obj.param3 = payload.getSINGLE();
            obj.param4 = payload.getSINGLE();
            obj.x = payload.getSINGLE();
            obj.y = payload.getSINGLE();
            obj.z = payload.getSINGLE();
            obj.seq = payload.getUINT16();
            obj.command = payload.getUINT16();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            obj.frame = payload.getUINT8();
            obj.current = payload.getUINT8();
            obj.autocontinue = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.param1,2) ~= 1
                result = 'param1';
            elseif size(obj.param2,2) ~= 1
                result = 'param2';
            elseif size(obj.param3,2) ~= 1
                result = 'param3';
            elseif size(obj.param4,2) ~= 1
                result = 'param4';
            elseif size(obj.x,2) ~= 1
                result = 'x';
            elseif size(obj.y,2) ~= 1
                result = 'y';
            elseif size(obj.z,2) ~= 1
                result = 'z';
            elseif size(obj.seq,2) ~= 1
                result = 'seq';
            elseif size(obj.command,2) ~= 1
                result = 'command';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';
            elseif size(obj.frame,2) ~= 1
                result = 'frame';
            elseif size(obj.current,2) ~= 1
                result = 'current';
            elseif size(obj.autocontinue,2) ~= 1
                result = 'autocontinue';

            else
                result = 0;
            end
        end

        function set.param1(obj,value)
            obj.param1 = single(value);
        end
        
        function set.param2(obj,value)
            obj.param2 = single(value);
        end
        
        function set.param3(obj,value)
            obj.param3 = single(value);
        end
        
        function set.param4(obj,value)
            obj.param4 = single(value);
        end
        
        function set.x(obj,value)
            obj.x = single(value);
        end
        
        function set.y(obj,value)
            obj.y = single(value);
        end
        
        function set.z(obj,value)
            obj.z = single(value);
        end
        
        function set.seq(obj,value)
            if value == uint16(value)
                obj.seq = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.command(obj,value)
            if value == uint16(value)
                obj.command = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
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
        
        function set.current(obj,value)
            if value == uint8(value)
                obj.current = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.autocontinue(obj,value)
            if value == uint8(value)
                obj.autocontinue = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end