classdef msg_heartbeat < MAVLinkMessage
	%MSG_HEARTBEAT: MAVLink Message ID = 0
    %Description:
    %    The heartbeat message shows that a system is present and responding. The type of the MAV and Autopilot hardware allow the receiving system to treat further messages from this system appropriate (e.g. by laying out the user interface based on the autopilot).
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    custom_mode(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    custom_mode(uint32): A bitfield for use for autopilot-specific flags.
    %    type(uint8): Type of the MAV (quadrotor, helicopter, etc., up to 15 types, defined in MAV_TYPE ENUM)
    %    autopilot(uint8): Autopilot type / class. defined in MAV_AUTOPILOT ENUM
    %    base_mode(uint8): System mode bitfield, see MAV_MODE_FLAG ENUM in mavlink/include/mavlink_types.h
    %    system_status(uint8): System status flag, see MAV_STATE ENUM
    %    mavlink_version(uint8): MAVLink version, not writable by user, gets added by protocol because of magic data type: uint8_t_mavlink_version
	
	properties(Constant)
		ID = 0
		LEN = 9
	end
	
	properties
        custom_mode	%A bitfield for use for autopilot-specific flags.	|	(uint32)
        type	%Type of the MAV (quadrotor, helicopter, etc., up to 15 types, defined in MAV_TYPE ENUM)	|	(uint8)
        autopilot	%Autopilot type / class. defined in MAV_AUTOPILOT ENUM	|	(uint8)
        base_mode	%System mode bitfield, see MAV_MODE_FLAG ENUM in mavlink/include/mavlink_types.h	|	(uint8)
        system_status	%System status flag, see MAV_STATE ENUM	|	(uint8)
        mavlink_version	%MAVLink version, not writable by user, gets added by protocol because of magic data type: uint8_t_mavlink_version	|	(uint8)
    end

    methods(Static)

        function send(out,custom_mode,type,autopilot,base_mode,system_status,mavlink_version,varargin)

            if nargin == 6 + 1
                msg = msg_heartbeat(custom_mode,type,autopilot,base_mode,system_status,mavlink_version,varargin);
            elseif nargin == 2
                msg = msg_heartbeat(custom_mode);
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

        function obj = msg_heartbeat(custom_mode,type,autopilot,base_mode,system_status,mavlink_version,varargin)
        %MSG_HEARTBEAT: Create a new heartbeat message object
        
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
            elseif nargin >= 6 && isempty(varargin{1})
                obj.custom_mode = custom_mode;
                obj.type = type;
                obj.autopilot = autopilot;
                obj.base_mode = base_mode;
                obj.system_status = system_status;
                obj.mavlink_version = mavlink_version;
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

                packet = MAVLinkPacket(msg_heartbeat.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_heartbeat.ID;
                
                packet.payload.putUINT32(obj.custom_mode);
                packet.payload.putUINT8(obj.type);
                packet.payload.putUINT8(obj.autopilot);
                packet.payload.putUINT8(obj.base_mode);
                packet.payload.putUINT8(obj.system_status);
                packet.payload.putUINT8(obj.mavlink_version);

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
            obj.type = payload.getUINT8();
            obj.autopilot = payload.getUINT8();
            obj.base_mode = payload.getUINT8();
            obj.system_status = payload.getUINT8();
            obj.mavlink_version = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.custom_mode,2) ~= 1
                result = 'custom_mode';
            elseif size(obj.type,2) ~= 1
                result = 'type';
            elseif size(obj.autopilot,2) ~= 1
                result = 'autopilot';
            elseif size(obj.base_mode,2) ~= 1
                result = 'base_mode';
            elseif size(obj.system_status,2) ~= 1
                result = 'system_status';
            elseif size(obj.mavlink_version,2) ~= 1
                result = 'mavlink_version';

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
        
        function set.type(obj,value)
            if value == uint8(value)
                obj.type = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.autopilot(obj,value)
            if value == uint8(value)
                obj.autopilot = uint8(value);
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
        
        function set.system_status(obj,value)
            if value == uint8(value)
                obj.system_status = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.mavlink_version(obj,value)
            if value == uint8(value)
                obj.mavlink_version = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end