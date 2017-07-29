classdef msg_set_mode < mavlink_message
	%MSG_SET_MODE: MAVLINK Message ID = 11
    %Description:
    %    THIS INTERFACE IS DEPRECATED. USE COMMAND_LONG with MAV_CMD_DO_SET_MODE INSTEAD. Set the system mode, as defined by enum MAV_MODE. There is no target component id as the mode is by definition for the overall aircraft, not only for one component.
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
    %    custom_mode(uint32): The new autopilot-specific mode. This field can be ignored by an autopilot.
    %    target_system(uint8): The system setting the mode
    %    base_mode(uint8): The new base mode
	
	properties(Constant)
		ID = 11
		LEN = 6
	end
	
	properties
        custom_mode	%The new autopilot-specific mode. This field can be ignored by an autopilot.	|	(uint32)
        target_system	%The system setting the mode	|	(uint8)
        base_mode	%The new base mode	|	(uint8)
    end

    methods

        function obj = msg_set_mode(packet,custom_mode,target_system,base_mode)
        %Create a new set_mode message
        
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
                obj.custom_mode = custom_mode;
                obj.target_system = target_system;
                obj.base_mode = base_mode;
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

                packet = mavlink_packet(msg_set_mode.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_set_mode.ID;
                
                packet.payload.putUINT32(obj.custom_mode);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.base_mode);

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
            
            obj.custom_mode = payload.getUINT32();
            obj.target_system = payload.getUINT8();
            obj.base_mode = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.custom_mode,2) ~= 1
                result = 'custom_mode';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.base_mode,2) ~= 1
                result = 'base_mode';

            else
                result = 0;
            end
        end

        function set.custom_mode(obj,value)
            if value == uint32(value)
                obj.custom_mode = uint32(value);
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
        
        function set.base_mode(obj,value)
            if value == uint8(value)
                obj.base_mode = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end