classdef msg_gimbal_erase_firmware_and_config < MAVLinkMessage
	%MSG_GIMBAL_ERASE_FIRMWARE_AND_CONFIG: MAVLink Message ID = 208
    %Description:
    %    Commands the gimbal to erase its firmware image and flash configuration, leaving only the bootloader.  The gimbal will then reboot into the bootloader,
            ready for the load of a new application firmware image.  Erasing the flash configuration will cause the gimbal to re-perform axis calibration when a
            new firmware image is loaded, and will cause all tuning parameters to return to their factory defaults.  WARNING: sending this command will render a
            gimbal inoperable until a new firmware image is loaded onto it.  For this reason, a particular "knock" value must be sent for the command to take effect.
            Use this command at your own risk
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    knock(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    knock(uint32): Knock value to confirm this is a valid request
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
	
	properties(Constant)
		ID = 208
		LEN = 6
	end
	
	properties
        knock	%Knock value to confirm this is a valid request	|	(uint32)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
    end

    methods(Static)

        function send(out,knock,target_system,target_component,varargin)

            if nargin == 3 + 1
                msg = msg_gimbal_erase_firmware_and_config(knock,target_system,target_component,varargin);
            elseif nargin == 2
                msg = msg_gimbal_erase_firmware_and_config(knock);
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

        function obj = msg_gimbal_erase_firmware_and_config(knock,target_system,target_component,varargin)
        %MSG_GIMBAL_ERASE_FIRMWARE_AND_CONFIG: Create a new gimbal_erase_firmware_and_config message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(knock,'MAVLinkPacket')
                    packet = knock;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('knock','MAVLinkPacket');
                end
            elseif nargin >= 3 && isempty(varargin{1})
                obj.knock = knock;
                obj.target_system = target_system;
                obj.target_component = target_component;
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

                packet = MAVLinkPacket(msg_gimbal_erase_firmware_and_config.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_gimbal_erase_firmware_and_config.ID;
                
                packet.payload.putUINT32(obj.knock);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);

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
            
            obj.knock = payload.getUINT32();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.knock,2) ~= 1
                result = 'knock';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';

            else
                result = 0;
            end
        end

        function set.knock(obj,value)
            if value == uint32(value)
                obj.knock = uint32(value);
            else
                MAVLink.throwTypeError('value','uint32');
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
        
    end

end