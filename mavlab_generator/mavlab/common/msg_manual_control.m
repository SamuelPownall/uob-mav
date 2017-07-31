classdef msg_manual_control < mavlink_message
	%MSG_MANUAL_CONTROL: MAVLINK Message ID = 69
    %Description:
    %    This message provides an API for manually controlling the vehicle using standard joystick axes nomenclature, along with a joystick-like input device. Unused axes can be disabled an buttons are also transmit as boolean values of their
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    x(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    x(int16): X-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to forward(1000)-backward(-1000) movement on a joystick and the pitch of a vehicle.
    %    y(int16): Y-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to left(-1000)-right(1000) movement on a joystick and the roll of a vehicle.
    %    z(int16): Z-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to a separate slider movement with maximum being 1000 and minimum being -1000 on a joystick and the thrust of a vehicle. Positive values are positive thrust, negative values are negative thrust.
    %    r(int16): R-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to a twisting of the joystick, with counter-clockwise being 1000 and clockwise being -1000, and the yaw of a vehicle.
    %    buttons(uint16): A bitfield corresponding to the joystick buttons' current state, 1 for pressed, 0 for released. The lowest bit corresponds to Button 1.
    %    target(uint8): The system to be controlled.
	
	properties(Constant)
		ID = 69
		LEN = 11
	end
	
	properties
        x	%X-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to forward(1000)-backward(-1000) movement on a joystick and the pitch of a vehicle.	|	(int16)
        y	%Y-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to left(-1000)-right(1000) movement on a joystick and the roll of a vehicle.	|	(int16)
        z	%Z-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to a separate slider movement with maximum being 1000 and minimum being -1000 on a joystick and the thrust of a vehicle. Positive values are positive thrust, negative values are negative thrust.	|	(int16)
        r	%R-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to a twisting of the joystick, with counter-clockwise being 1000 and clockwise being -1000, and the yaw of a vehicle.	|	(int16)
        buttons	%A bitfield corresponding to the joystick buttons' current state, 1 for pressed, 0 for released. The lowest bit corresponds to Button 1.	|	(uint16)
        target	%The system to be controlled.	|	(uint8)
    end

    methods

        function obj = msg_manual_control(x,y,z,r,buttons,target,varargin)
        %MSG_MANUAL_CONTROL: Create a new manual_control message object
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1 
                if isa(x,'mavlink_packet')
                    packet = x;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('x','mavlink_packet');
                end
            elseif nargin == 6
                obj.x = x;
                obj.y = y;
                obj.z = z;
                obj.r = r;
                obj.buttons = buttons;
                obj.target = target;
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

                packet = mavlink_packet(msg_manual_control.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_manual_control.ID;
                
                packet.payload.putINT16(obj.x);
                packet.payload.putINT16(obj.y);
                packet.payload.putINT16(obj.z);
                packet.payload.putINT16(obj.r);
                packet.payload.putUINT16(obj.buttons);
                packet.payload.putUINT8(obj.target);

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
            
            obj.x = payload.getINT16();
            obj.y = payload.getINT16();
            obj.z = payload.getINT16();
            obj.r = payload.getINT16();
            obj.buttons = payload.getUINT16();
            obj.target = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.x,2) ~= 1
                result = 'x';
            elseif size(obj.y,2) ~= 1
                result = 'y';
            elseif size(obj.z,2) ~= 1
                result = 'z';
            elseif size(obj.r,2) ~= 1
                result = 'r';
            elseif size(obj.buttons,2) ~= 1
                result = 'buttons';
            elseif size(obj.target,2) ~= 1
                result = 'target';

            else
                result = 0;
            end
        end

        function set.x(obj,value)
            if value == int16(value)
                obj.x = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.y(obj,value)
            if value == int16(value)
                obj.y = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.z(obj,value)
            if value == int16(value)
                obj.z = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.r(obj,value)
            if value == int16(value)
                obj.r = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.buttons(obj,value)
            if value == uint16(value)
                obj.buttons = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.target(obj,value)
            if value == uint8(value)
                obj.target = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end