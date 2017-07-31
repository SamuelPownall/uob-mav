classdef msg_gimbal_erase_firmware_and_config < mavlink_message
	%MSG_GIMBAL_ERASE_FIRMWARE_AND_CONFIG: MAVLINK Message ID = 208
    %Description:
    %    Commands the gimbal to erase its firmware image and flash configuration, leaving only the bootloader.  The gimbal will then reboot into the bootloader,
            ready for the load of a new application firmware image.  Erasing the flash configuration will cause the gimbal to re-perform axis calibration when a
            new firmware image is loaded, and will cause all tuning parameters to return to their factory defaults.  WARNING: sending this command will render a
            gimbal inoperable until a new firmware image is loaded onto it.  For this reason, a particular "knock" value must be sent for the command to take effect.
            Use this command at your own risk
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    knock(mavlink_packet): Alternative way to construct a message using a mavlink_packet
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

    methods

        function obj = msg_gimbal_erase_firmware_and_config(knock,target_system,target_component,varargin)
        %Create a new gimbal_erase_firmware_and_config message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(knock,'mavlink_packet')
                    packet = knock;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('knock','mavlink_packet');
                end
            
            elseif nargin == 3
                obj.knock = knock;
                obj.target_system = target_system;
                obj.target_component = target_component;
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

                packet = mavlink_packet(msg_gimbal_erase_firmware_and_config.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_gimbal_erase_firmware_and_config.ID;
                
                packet.payload.putUINT32(obj.knock);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);

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
                mavlink.throwTypeError('value','uint32');
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
        
    end

end