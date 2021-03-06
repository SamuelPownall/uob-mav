classdef msg_digicam_control < MAVLinkMessage
	%MSG_DIGICAM_CONTROL: MAVLink Message ID = 155
    %Description:
    %    Control on-board Camera Control System to take shots.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    extra_value(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,extra_value,target_system,target_component,session,zoom_pos,zoom_step,focus_lock,shot,command_id,extra_param,varargin)

            if nargin == 10 + 1
                msg = msg_digicam_control(extra_value,target_system,target_component,session,zoom_pos,zoom_step,focus_lock,shot,command_id,extra_param,varargin);
            elseif nargin == 2
                msg = msg_digicam_control(extra_value);
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

        function obj = msg_digicam_control(extra_value,target_system,target_component,session,zoom_pos,zoom_step,focus_lock,shot,command_id,extra_param,varargin)
        %MSG_DIGICAM_CONTROL: Create a new digicam_control message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(extra_value,'MAVLinkPacket')
                    packet = extra_value;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('extra_value','MAVLinkPacket');
                end
            elseif nargin >= 10 && isempty(varargin{1})
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

                packet = MAVLinkPacket(msg_digicam_control.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
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
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

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
        
        function set.session(obj,value)
            if value == uint8(value)
                obj.session = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.zoom_pos(obj,value)
            if value == uint8(value)
                obj.zoom_pos = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.zoom_step(obj,value)
            if value == int8(value)
                obj.zoom_step = int8(value);
            else
                MAVLink.throwTypeError('value','int8');
            end
        end
        
        function set.focus_lock(obj,value)
            if value == uint8(value)
                obj.focus_lock = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.shot(obj,value)
            if value == uint8(value)
                obj.shot = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.command_id(obj,value)
            if value == uint8(value)
                obj.command_id = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.extra_param(obj,value)
            if value == uint8(value)
                obj.extra_param = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end