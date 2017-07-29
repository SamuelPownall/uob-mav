classdef msg_manual_control < mavlink_handle
	%MSG_MANUAL_CONTROL(packet,x,y,z,r,buttons,target): MAVLINK Message ID = 69
    %Description:
    %    This message provides an API for manually controlling the vehicle using standard joystick axes nomenclature, along with a joystick-like input device. Unused axes can be disabled an buttons are also transmit as boolean values of their 
    %    If constructing from fields, packet argument should be set to []
	%Fields:
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

        %Constructor: msg_manual_control
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_manual_control(packet,x,y,z,r,buttons,target)
        
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
            
            elseif nargin-1 == 6
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

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

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

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.x = payload.getINT16();
            obj.y = payload.getINT16();
            obj.z = payload.getINT16();
            obj.r = payload.getINT16();
            obj.buttons = payload.getUINT16();
            obj.target = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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