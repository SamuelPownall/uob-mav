classdef msg_command_int < mavlink_message
    %MAVLINK Message Class
    %Name: command_int	ID: 75
    %Description: Message encoding a command with parameters as scaled integers. Scaling depends on the actual command value.
            
    properties(Constant)
        ID = 75
        LEN = 35
    end
    
    properties        
		x	%PARAM5 / local: x position in meters * 1e4, global: latitude in degrees * 10^7 (int32)
		y	%PARAM6 / local: y position in meters * 1e4, global: longitude in degrees * 10^7 (int32)
		param1	%PARAM1, see MAV_CMD enum (single)
		param2	%PARAM2, see MAV_CMD enum (single)
		param3	%PARAM3, see MAV_CMD enum (single)
		param4	%PARAM4, see MAV_CMD enum (single)
		z	%PARAM7 / z position: global: altitude in meters (relative or absolute, depending on frame. (single)
		command	%The scheduled action for the mission item. see MAV_CMD in common.xml MAVLink specs (uint16)
		target_system	%System ID (uint8)
		target_component	%Component ID (uint8)
		frame	%The coordinate system of the COMMAND. see MAV_FRAME in mavlink_types.h (uint8)
		current	%false:0, true:1 (uint8)
		autocontinue	%autocontinue to next wp (uint8)
	end
    
    methods
        
        %Constructor: msg_command_int
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_command_int(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            emptyField = obj.verify();
            if emptyField == 0
        
                packet = mavlink_packet(msg_command_int.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_command_int.ID;
                
				packet.payload.putINT32(obj.x);

				packet.payload.putINT32(obj.y);

				packet.payload.putSINGLE(obj.param1);

				packet.payload.putSINGLE(obj.param2);

				packet.payload.putSINGLE(obj.param3);

				packet.payload.putSINGLE(obj.param4);

				packet.payload.putSINGLE(obj.z);

				packet.payload.putUINT16(obj.command);

				packet.payload.putUINT8(obj.target_system);

				packet.payload.putUINT8(obj.target_component);

				packet.payload.putUINT8(obj.frame);

				packet.payload.putUINT8(obj.current);

				packet.payload.putUINT8(obj.autocontinue);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_command_int.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.x = payload.getINT32();

			obj.y = payload.getINT32();

			obj.param1 = payload.getSINGLE();

			obj.param2 = payload.getSINGLE();

			obj.param3 = payload.getSINGLE();

			obj.param4 = payload.getSINGLE();

			obj.z = payload.getSINGLE();

			obj.command = payload.getUINT16();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

			obj.frame = payload.getUINT8();

			obj.current = payload.getUINT8();

			obj.autocontinue = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.x,2) ~= 1
                result = 'x';                                        
            elseif size(obj.y,2) ~= 1
                result = 'y';                                        
            elseif size(obj.param1,2) ~= 1
                result = 'param1';                                        
            elseif size(obj.param2,2) ~= 1
                result = 'param2';                                        
            elseif size(obj.param3,2) ~= 1
                result = 'param3';                                        
            elseif size(obj.param4,2) ~= 1
                result = 'param4';                                        
            elseif size(obj.z,2) ~= 1
                result = 'z';                                        
            elseif size(obj.command,2) ~= 1
                result = 'command';                                        
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';                                        
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';                                        
            elseif size(obj.frame,2) ~= 1
                result = 'frame';                                        
            elseif size(obj.current,2) ~= 1
                result = 'current';                                        
            elseif size(obj.autocontinue,2) ~= 1
                result = 'autocontinue';                            
            else
                result = 0;
            end
            
        end
                                
        function set.x(obj,value)
            if value == int32(value)
                obj.x = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | command_int.set.x()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.y(obj,value)
            if value == int32(value)
                obj.y = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | command_int.set.y()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                
        function set.param1(obj,value)
            obj.param1 = single(value);
        end
                                
        function set.param2(obj,value)
            obj.param2 = single(value);
        end
                                
        function set.param3(obj,value)
            obj.param3 = single(value);
        end
                                
        function set.param4(obj,value)
            obj.param4 = single(value);
        end
                                
        function set.z(obj,value)
            obj.z = single(value);
        end
                                    
        function set.command(obj,value)
            if value == uint16(value)
                obj.command = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | command_int.set.command()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | command_int.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | command_int.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.frame(obj,value)
            if value == uint8(value)
                obj.frame = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | command_int.set.frame()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.current(obj,value)
            if value == uint8(value)
                obj.current = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | command_int.set.current()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.autocontinue(obj,value)
            if value == uint8(value)
                obj.autocontinue = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | command_int.set.autocontinue()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end