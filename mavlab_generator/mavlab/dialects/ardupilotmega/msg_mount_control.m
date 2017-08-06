classdef msg_mount_control < MAVLinkMessage
	%MSG_MOUNT_CONTROL: MAVLink Message ID = 157
    %Description:
    %    Message to control a camera mount, directional antenna, etc.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    input_a(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    input_a(int32): pitch(deg*100) or lat, depending on mount mode
    %    input_b(int32): roll(deg*100) or lon depending on mount mode
    %    input_c(int32): yaw(deg*100) or alt (in cm) depending on mount mode
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
    %    save_position(uint8): if "1" it will save current trimmed position on EEPROM (just valid for NEUTRAL and LANDING)
	
	properties(Constant)
		ID = 157
		LEN = 15
	end
	
	properties
        input_a	%pitch(deg*100) or lat, depending on mount mode	|	(int32)
        input_b	%roll(deg*100) or lon depending on mount mode	|	(int32)
        input_c	%yaw(deg*100) or alt (in cm) depending on mount mode	|	(int32)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
        save_position	%if "1" it will save current trimmed position on EEPROM (just valid for NEUTRAL and LANDING)	|	(uint8)
    end

    methods(Static)

        function send(out,input_a,input_b,input_c,target_system,target_component,save_position,varargin)

            if nargin == 6 + 1
                msg = msg_mount_control(input_a,input_b,input_c,target_system,target_component,save_position,varargin);
            elseif nargin == 2
                msg = msg_mount_control(input_a);
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

        function obj = msg_mount_control(input_a,input_b,input_c,target_system,target_component,save_position,varargin)
        %MSG_MOUNT_CONTROL: Create a new mount_control message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(input_a,'MAVLinkPacket')
                    packet = input_a;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('input_a','MAVLinkPacket');
                end
            elseif nargin >= 6 && isempty(varargin{1})
                obj.input_a = input_a;
                obj.input_b = input_b;
                obj.input_c = input_c;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.save_position = save_position;
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

                packet = MAVLinkPacket(msg_mount_control.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_mount_control.ID;
                
                packet.payload.putINT32(obj.input_a);
                packet.payload.putINT32(obj.input_b);
                packet.payload.putINT32(obj.input_c);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);
                packet.payload.putUINT8(obj.save_position);

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
            
            obj.input_a = payload.getINT32();
            obj.input_b = payload.getINT32();
            obj.input_c = payload.getINT32();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();
            obj.save_position = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.input_a,2) ~= 1
                result = 'input_a';
            elseif size(obj.input_b,2) ~= 1
                result = 'input_b';
            elseif size(obj.input_c,2) ~= 1
                result = 'input_c';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';
            elseif size(obj.save_position,2) ~= 1
                result = 'save_position';

            else
                result = 0;
            end
        end

        function set.input_a(obj,value)
            if value == int32(value)
                obj.input_a = int32(value);
            else
                MAVLink.throwTypeError('value','int32');
            end
        end
        
        function set.input_b(obj,value)
            if value == int32(value)
                obj.input_b = int32(value);
            else
                MAVLink.throwTypeError('value','int32');
            end
        end
        
        function set.input_c(obj,value)
            if value == int32(value)
                obj.input_c = int32(value);
            else
                MAVLink.throwTypeError('value','int32');
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
        
        function set.save_position(obj,value)
            if value == uint8(value)
                obj.save_position = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end