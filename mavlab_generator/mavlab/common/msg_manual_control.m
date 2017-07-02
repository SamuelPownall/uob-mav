classdef msg_manual_control < mavlink_message
    %MAVLINK Message Class
    %Name: manual_control	ID: 69
    %Description: This message provides an API for manually controlling the vehicle using standard joystick axes nomenclature, along with a joystick-like input device. Unused axes can be disabled an buttons are also transmit as boolean values of their 
            
    properties(Constant)
        ID = 69
        LEN = 11
    end
    
    properties        
		x	%X-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to forward(1000)-backward(-1000) movement on a joystick and the pitch of a vehicle. (int16[1])
		y	%Y-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to left(-1000)-right(1000) movement on a joystick and the roll of a vehicle. (int16[1])
		z	%Z-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to a separate slider movement with maximum being 1000 and minimum being -1000 on a joystick and the thrust of a vehicle. Positive values are positive thrust, negative values are negative thrust. (int16[1])
		r	%R-axis, normalized to the range [-1000,1000]. A value of INT16_MAX indicates that this axis is invalid. Generally corresponds to a twisting of the joystick, with counter-clockwise being 1000 and clockwise being -1000, and the yaw of a vehicle. (int16[1])
		buttons	%A bitfield corresponding to the joystick buttons' current state, 1 for pressed, 0 for released. The lowest bit corresponds to Button 1. (uint16[1])
		target	%The system to be controlled. (uint8[1])
	end

    
    methods
        
        %Constructor: msg_manual_control
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_manual_control(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
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

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.x = payload.getINT16();

			obj.y = payload.getINT16();

			obj.z = payload.getINT16();

			obj.r = payload.getINT16();

			obj.buttons = payload.getUINT16();

			obj.target = payload.getUINT8();

		end
            
        function set.x(obj,value)
            if value == int16(value)
                obj.x = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | manual_control.set.x()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.y(obj,value)
            if value == int16(value)
                obj.y = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | manual_control.set.y()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.z(obj,value)
            if value == int16(value)
                obj.z = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | manual_control.set.z()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.r(obj,value)
            if value == int16(value)
                obj.r = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | manual_control.set.r()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.buttons(obj,value)
            if value == uint16(value)
                obj.buttons = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | manual_control.set.buttons()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.target(obj,value)
            if value == uint8(value)
                obj.target = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | manual_control.set.target()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end