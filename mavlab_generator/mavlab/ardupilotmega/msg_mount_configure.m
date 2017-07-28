classdef msg_mount_configure < mavlink_message
	%MSG_MOUNT_CONFIGURE(packet,target_system,target_component,mount_mode,stab_roll,stab_pitch,stab_yaw): MAVLINK Message ID = 156
    %Description:
    %    Message to configure a camera mount, directional antenna, etc.
    %    If constructing from fields, packet argument should be set to []
	%Fields:
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

    methods

        %Constructor: msg_mount_configure
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_mount_configure(packet,target_system,target_component,mount_mode,stab_roll,stab_pitch,stab_yaw)
        
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
            
            elseif nargin-1 == 6
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.mount_mode = mount_mode;
                obj.stab_roll = stab_roll;
                obj.stab_pitch = stab_pitch;
                obj.stab_yaw = stab_yaw;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_mount_configure.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_mount_configure.ID;
                
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                packet.payload.putUINT8(obj.mount_mode);
                packet.payload.putUINT8(obj.stab_roll);
                packet.payload.putUINT8(obj.stab_pitch);
                packet.payload.putUINT8(obj.stab_yaw);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            obj.mount_mode = payload.getUINT8();
            obj.stab_roll = payload.getUINT8();
            obj.stab_pitch = payload.getUINT8();
            obj.stab_yaw = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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
        
        function set.mount_mode(obj,value)
            if value == uint8(value)
                obj.mount_mode = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.stab_roll(obj,value)
            if value == uint8(value)
                obj.stab_roll = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.stab_pitch(obj,value)
            if value == uint8(value)
                obj.stab_pitch = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.stab_yaw(obj,value)
            if value == uint8(value)
                obj.stab_yaw = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end