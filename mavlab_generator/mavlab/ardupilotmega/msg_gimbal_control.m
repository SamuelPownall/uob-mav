classdef msg_gimbal_control < mavlink_message
	%MSG_GIMBAL_CONTROL: MAVLINK Message ID = 201
    %Description:
    %    Control message for rate gimbal
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
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

    methods

        function obj = msg_gimbal_control(packet,demanded_rate_x,demanded_rate_y,demanded_rate_z,target_system,target_component)
        %Create a new gimbal_control message
        
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
            
            elseif nargin-1 == 5
                obj.demanded_rate_x = demanded_rate_x;
                obj.demanded_rate_y = demanded_rate_y;
                obj.demanded_rate_z = demanded_rate_z;
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

                packet = mavlink_packet(msg_gimbal_control.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_gimbal_control.ID;
                
                packet.payload.putSINGLE(obj.demanded_rate_x);
                packet.payload.putSINGLE(obj.demanded_rate_y);
                packet.payload.putSINGLE(obj.demanded_rate_z);
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