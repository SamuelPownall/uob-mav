classdef msg_digicam_control < mavlink_message
	%MSG_DIGICAM_CONTROL(packet,extra_value,target_system,target_component,session,zoom_pos,zoom_step,focus_lock,shot,command_id,extra_param): MAVLINK Message ID = 155
    %Description:
    %    Control on-board Camera Control System to take shots.
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    extra_value(single): Correspondent value to given extra_param
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
    %    session(uint8): 0: stop, 1: start or keep it up //Session control e.g. show/hide lens
    %    zoom_pos(uint8): 1 to N //Zoom's absolute position (0 means ignore)
    %    zoom_step(int8): -100 to 100 //Zooming step value to offset zoom from the current position
    %    focus_lock(uint8): 0: unlock focus or keep unlocked, 1: lock focus or keep locked, 3: re-lock focus
    %    shot(uint8): 0: ignore, 1: shot or start filming
    %    command_id(uint8): Command Identity (incremental loop: 0 to 255)//A command sent multiple times will be executed or pooled just once
    %    extra_param(uint8): Extra parameters enumeration (0 means ignore)
	
	properties(Constant)
		ID = 155
		LEN = 13
	end
	
	properties
        extra_value	%Correspondent value to given extra_param	|	(single)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
        session	%0: stop, 1: start or keep it up //Session control e.g. show/hide lens	|	(uint8)
        zoom_pos	%1 to N //Zoom's absolute position (0 means ignore)	|	(uint8)
        zoom_step	%-100 to 100 //Zooming step value to offset zoom from the current position	|	(int8)
        focus_lock	%0: unlock focus or keep unlocked, 1: lock focus or keep locked, 3: re-lock focus	|	(uint8)
        shot	%0: ignore, 1: shot or start filming	|	(uint8)
        command_id	%Command Identity (incremental loop: 0 to 255)//A command sent multiple times will be executed or pooled just once	|	(uint8)
        extra_param	%Extra parameters enumeration (0 means ignore)	|	(uint8)
    end

    methods

        %Constructor: msg_digicam_control
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_digicam_control(packet,extra_value,target_system,target_component,session,zoom_pos,zoom_step,focus_lock,shot,command_id,extra_param)
        
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
            
            elseif nargin-1 == 10
                obj.extra_value = extra_value;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.session = session;
                obj.zoom_pos = zoom_pos;
                obj.zoom_step = zoom_step;
                obj.focus_lock = focus_lock;
                obj.shot = shot;
                obj.command_id = command_id;
                obj.extra_param = extra_param;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_digicam_control.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_digicam_control.ID;
                
                packet.payload.putSINGLE(obj.extra_value);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                packet.payload.putUINT8(obj.session);
                packet.payload.putUINT8(obj.zoom_pos);
                packet.payload.putINT8(obj.zoom_step);
                packet.payload.putUINT8(obj.focus_lock);
                packet.payload.putUINT8(obj.shot);
                packet.payload.putUINT8(obj.command_id);
                packet.payload.putUINT8(obj.extra_param);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.extra_value = payload.getSINGLE();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            obj.session = payload.getUINT8();
            obj.zoom_pos = payload.getUINT8();
            obj.zoom_step = payload.getINT8();
            obj.focus_lock = payload.getUINT8();
            obj.shot = payload.getUINT8();
            obj.command_id = payload.getUINT8();
            obj.extra_param = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.extra_value,2) ~= 1
                result = 'extra_value';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';
            elseif size(obj.session,2) ~= 1
                result = 'session';
            elseif size(obj.zoom_pos,2) ~= 1
                result = 'zoom_pos';
            elseif size(obj.zoom_step,2) ~= 1
                result = 'zoom_step';
            elseif size(obj.focus_lock,2) ~= 1
                result = 'focus_lock';
            elseif size(obj.shot,2) ~= 1
                result = 'shot';
            elseif size(obj.command_id,2) ~= 1
                result = 'command_id';
            elseif size(obj.extra_param,2) ~= 1
                result = 'extra_param';

            else
                result = 0;
            end
        end

        function set.extra_value(obj,value)
            obj.extra_value = single(value);
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
        
        function set.session(obj,value)
            if value == uint8(value)
                obj.session = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.zoom_pos(obj,value)
            if value == uint8(value)
                obj.zoom_pos = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.zoom_step(obj,value)
            if value == int8(value)
                obj.zoom_step = int8(value);
            else
                mavlink.throwTypeError('value','int8');
            end
        end
        
        function set.focus_lock(obj,value)
            if value == uint8(value)
                obj.focus_lock = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.shot(obj,value)
            if value == uint8(value)
                obj.shot = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.command_id(obj,value)
            if value == uint8(value)
                obj.command_id = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.extra_param(obj,value)
            if value == uint8(value)
                obj.extra_param = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end