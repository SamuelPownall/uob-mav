classdef msg_gimbal_erase_firmware_and_config < mavlink_message
	%MSG_GIMBAL_ERASE_FIRMWARE_AND_CONFIG(packet,knock,target_system,target_component): MAVLINK Message ID = 208
    %Description:
    %    
            Commands the gimbal to erase its firmware image and flash configuration, leaving only the bootloader.  The gimbal will then reboot into the bootloader,
            ready for the load of a new application firmware image.  Erasing the flash configuration will cause the gimbal to re-perform axis calibration when a
            new firmware image is loaded, and will cause all tuning parameters to return to their factory defaults.  WARNING: sending this command will render a
            gimbal inoperable until a new firmware image is loaded onto it.  For this reason, a particular "knock" value must be sent for the command to take effect.
            Use this command at your own risk
        
    %    If constructing from fields, packet argument should be set to []
	%Fields:
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

        %Constructor: msg_gimbal_erase_firmware_and_config
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_gimbal_erase_firmware_and_config(packet,knock,target_system,target_component)
        
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
            
            elseif nargin-1 == 3
                obj.knock = knock;
                obj.target_system = target_system;
                obj.target_component = target_component;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

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

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.knock = payload.getUINT32();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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