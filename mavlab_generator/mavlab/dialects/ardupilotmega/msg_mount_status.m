classdef msg_mount_status < MAVLinkMessage
	%MSG_MOUNT_STATUS: MAVLink Message ID = 158
    %Description:
    %    Message with some status from APM to GCS about camera or antenna mount
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    pointing_a(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    pointing_a(int32): pitch(deg*100)
    %    pointing_b(int32): roll(deg*100)
    %    pointing_c(int32): yaw(deg*100)
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
	
	properties(Constant)
		ID = 158
		LEN = 14
	end
	
	properties
        pointing_a	%pitch(deg*100)	|	(int32)
        pointing_b	%roll(deg*100)	|	(int32)
        pointing_c	%yaw(deg*100)	|	(int32)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
    end

    methods(Static)

        function send(out,pointing_a,pointing_b,pointing_c,target_system,target_component,varargin)

            if nargin == 5 + 1
                msg = msg_mount_status(pointing_a,pointing_b,pointing_c,target_system,target_component,varargin);
            elseif nargin == 2
                msg = msg_mount_status(pointing_a);
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

        function obj = msg_mount_status(pointing_a,pointing_b,pointing_c,target_system,target_component,varargin)
        %MSG_MOUNT_STATUS: Create a new mount_status message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(pointing_a,'MAVLinkPacket')
                    packet = pointing_a;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('pointing_a','MAVLinkPacket');
                end
            elseif nargin >= 5 && isempty(varargin{1})
                obj.pointing_a = pointing_a;
                obj.pointing_b = pointing_b;
                obj.pointing_c = pointing_c;
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

                packet = MAVLinkPacket(msg_mount_status.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_mount_status.ID;
                
                packet.payload.putINT32(obj.pointing_a);
                packet.payload.putINT32(obj.pointing_b);
                packet.payload.putINT32(obj.pointing_c);
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
            
            obj.pointing_a = payload.getINT32();
            obj.pointing_b = payload.getINT32();
            obj.pointing_c = payload.getINT32();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.pointing_a,2) ~= 1
                result = 'pointing_a';
            elseif size(obj.pointing_b,2) ~= 1
                result = 'pointing_b';
            elseif size(obj.pointing_c,2) ~= 1
                result = 'pointing_c';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';

            else
                result = 0;
            end
        end

        function set.pointing_a(obj,value)
            if value == int32(value)
                obj.pointing_a = int32(value);
            else
                MAVLink.throwTypeError('value','int32');
            end
        end
        
        function set.pointing_b(obj,value)
            if value == int32(value)
                obj.pointing_b = int32(value);
            else
                MAVLink.throwTypeError('value','int32');
            end
        end
        
        function set.pointing_c(obj,value)
            if value == int32(value)
                obj.pointing_c = int32(value);
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
        
    end

end