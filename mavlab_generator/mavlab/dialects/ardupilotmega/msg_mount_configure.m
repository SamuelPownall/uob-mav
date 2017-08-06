classdef msg_mount_configure < MAVLinkMessage
	%MSG_MOUNT_CONFIGURE: MAVLink Message ID = 156
    %Description:
    %    Message to configure a camera mount, directional antenna, etc.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    target_system(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
    %    mount_mode(uint8): mount operating mode (see MAV_MOUNT_MODE enum)
    %    stab_roll(uint8): (1 = yes, 0 = no)
    %    stab_pitch(uint8): (1 = yes, 0 = no)
    %    stab_yaw(uint8): (1 = yes, 0 = no)
	
	properties(Constant)
		ID = 156
		LEN = 6
	end
	
	properties
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
        mount_mode	%mount operating mode (see MAV_MOUNT_MODE enum)	|	(uint8)
        stab_roll	%(1 = yes, 0 = no)	|	(uint8)
        stab_pitch	%(1 = yes, 0 = no)	|	(uint8)
        stab_yaw	%(1 = yes, 0 = no)	|	(uint8)
    end

    methods(Static)

        function send(out,target_system,target_component,mount_mode,stab_roll,stab_pitch,stab_yaw,varargin)

            if nargin == 6 + 1
                msg = msg_mount_configure(target_system,target_component,mount_mode,stab_roll,stab_pitch,stab_yaw,varargin);
            elseif nargin == 2
                msg = msg_mount_configure(target_system);
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

        function obj = msg_mount_configure(target_system,target_component,mount_mode,stab_roll,stab_pitch,stab_yaw,varargin)
        %MSG_MOUNT_CONFIGURE: Create a new mount_configure message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(target_system,'MAVLinkPacket')
                    packet = target_system;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('target_system','MAVLinkPacket');
                end
            elseif nargin >= 6 && isempty(varargin{1})
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.mount_mode = mount_mode;
                obj.stab_roll = stab_roll;
                obj.stab_pitch = stab_pitch;
                obj.stab_yaw = stab_yaw;
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

                packet = MAVLinkPacket(msg_mount_configure.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_mount_configure.ID;
                
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                packet.payload.putUINT8(obj.mount_mode);
                packet.payload.putUINT8(obj.stab_roll);
                packet.payload.putUINT8(obj.stab_pitch);
                packet.payload.putUINT8(obj.stab_yaw);

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
            
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            obj.mount_mode = payload.getUINT8();
            obj.stab_roll = payload.getUINT8();
            obj.stab_pitch = payload.getUINT8();
            obj.stab_yaw = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';
            elseif size(obj.mount_mode,2) ~= 1
                result = 'mount_mode';
            elseif size(obj.stab_roll,2) ~= 1
                result = 'stab_roll';
            elseif size(obj.stab_pitch,2) ~= 1
                result = 'stab_pitch';
            elseif size(obj.stab_yaw,2) ~= 1
                result = 'stab_yaw';

            else
                result = 0;
            end
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
        
        function set.mount_mode(obj,value)
            if value == uint8(value)
                obj.mount_mode = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.stab_roll(obj,value)
            if value == uint8(value)
                obj.stab_roll = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.stab_pitch(obj,value)
            if value == uint8(value)
                obj.stab_pitch = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.stab_yaw(obj,value)
            if value == uint8(value)
                obj.stab_yaw = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end