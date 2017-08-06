classdef msg_set_mode < MAVLinkMessage
	%MSG_SET_MODE: MAVLink Message ID = 11
    %Description:
    %    THIS INTERFACE IS DEPRECATED. USE COMMAND_LONG with MAV_CMD_DO_SET_MODE INSTEAD. Set the system mode, as defined by enum MAV_MODE. There is no target component id as the mode is by definition for the overall aircraft, not only for one component.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    custom_mode(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,custom_mode,target_system,base_mode,varargin)

            if nargin == 3 + 1
                msg = msg_set_mode(custom_mode,target_system,base_mode,varargin);
            elseif nargin == 2
                msg = msg_set_mode(custom_mode);
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

        function obj = msg_set_mode(custom_mode,target_system,base_mode,varargin)
        %MSG_SET_MODE: Create a new set_mode message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(custom_mode,'MAVLinkPacket')
                    packet = custom_mode;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('custom_mode','MAVLinkPacket');
                end
            elseif nargin >= 3 && isempty(varargin{1})
                obj.custom_mode = custom_mode;
                obj.target_system = target_system;
                obj.base_mode = base_mode;
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

                packet = MAVLinkPacket(msg_set_mode.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_set_mode.ID;
                
                packet.payload.putUINT32(obj.custom_mode);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.base_mode);

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
        
        function set.base_mode(obj,value)
            if value == uint8(value)
                obj.base_mode = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end