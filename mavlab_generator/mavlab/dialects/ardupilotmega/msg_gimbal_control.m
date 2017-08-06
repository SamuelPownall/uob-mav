classdef msg_gimbal_control < MAVLinkMessage
	%MSG_GIMBAL_CONTROL: MAVLink Message ID = 201
    %Description:
    %    Control message for rate gimbal
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    demanded_rate_x(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    demanded_rate_x(single): Demanded angular rate X (rad/s)
    %    demanded_rate_y(single): Demanded angular rate Y (rad/s)
    %    demanded_rate_z(single): Demanded angular rate Z (rad/s)
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
	
	properties(Constant)
		ID = 201
		LEN = 14
	end
	
	properties
        demanded_rate_x	%Demanded angular rate X (rad/s)	|	(single)
        demanded_rate_y	%Demanded angular rate Y (rad/s)	|	(single)
        demanded_rate_z	%Demanded angular rate Z (rad/s)	|	(single)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
    end

    methods(Static)

        function send(out,demanded_rate_x,demanded_rate_y,demanded_rate_z,target_system,target_component,varargin)

            if nargin == 5 + 1
                msg = msg_gimbal_control(demanded_rate_x,demanded_rate_y,demanded_rate_z,target_system,target_component,varargin);
            elseif nargin == 2
                msg = msg_gimbal_control(demanded_rate_x);
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

        function obj = msg_gimbal_control(demanded_rate_x,demanded_rate_y,demanded_rate_z,target_system,target_component,varargin)
        %MSG_GIMBAL_CONTROL: Create a new gimbal_control message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(demanded_rate_x,'MAVLinkPacket')
                    packet = demanded_rate_x;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('demanded_rate_x','MAVLinkPacket');
                end
            elseif nargin >= 5 && isempty(varargin{1})
                obj.demanded_rate_x = demanded_rate_x;
                obj.demanded_rate_y = demanded_rate_y;
                obj.demanded_rate_z = demanded_rate_z;
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

                packet = MAVLinkPacket(msg_gimbal_control.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_gimbal_control.ID;
                
                packet.payload.putSINGLE(obj.demanded_rate_x);
                packet.payload.putSINGLE(obj.demanded_rate_y);
                packet.payload.putSINGLE(obj.demanded_rate_z);
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
            
            obj.demanded_rate_x = payload.getSINGLE();
            obj.demanded_rate_y = payload.getSINGLE();
            obj.demanded_rate_z = payload.getSINGLE();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.demanded_rate_x,2) ~= 1
                result = 'demanded_rate_x';
            elseif size(obj.demanded_rate_y,2) ~= 1
                result = 'demanded_rate_y';
            elseif size(obj.demanded_rate_z,2) ~= 1
                result = 'demanded_rate_z';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';

            else
                result = 0;
            end
        end

        function set.demanded_rate_x(obj,value)
            obj.demanded_rate_x = single(value);
        end
        
        function set.demanded_rate_y(obj,value)
            obj.demanded_rate_y = single(value);
        end
        
        function set.demanded_rate_z(obj,value)
            obj.demanded_rate_z = single(value);
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