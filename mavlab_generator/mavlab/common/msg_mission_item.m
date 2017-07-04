classdef msg_mission_item < mavlink_message
    %MAVLINK Message Class
    %Name: mission_item	ID: 39
    %Description: Message encoding a mission item. This message is emitted to announce
                the presence of a mission item and to set a mission item on the system. The mission item can be either in x, y, z meters (type: LOCAL) or x:lat, y:lon, z:altitude. Local frame is Z-down, right handed (NED), global frame is Z-up, right handed (ENU). See also http://qgroundcontrol.org/mavlink/waypoint_protocol.
            
    properties(Constant)
        ID = 39
        LEN = 37
    end
    
    properties        
		param1	%PARAM1, see MAV_CMD enum (single)
		param2	%PARAM2, see MAV_CMD enum (single)
		param3	%PARAM3, see MAV_CMD enum (single)
		param4	%PARAM4, see MAV_CMD enum (single)
		x	%PARAM5 / local: x position, global: latitude (single)
		y	%PARAM6 / y position: global: longitude (single)
		z	%PARAM7 / z position: global: altitude (relative or absolute, depending on frame. (single)
		seq	%Sequence (uint16)
		command	%The scheduled action for the MISSION. see MAV_CMD in common.xml MAVLink specs (uint16)
		target_system	%System ID (uint8)
		target_component	%Component ID (uint8)
		frame	%The coordinate system of the MISSION. see MAV_FRAME in mavlink_types.h (uint8)
		current	%false:0, true:1 (uint8)
		autocontinue	%autocontinue to next wp (uint8)
	end
    
    methods
        
        %Constructor: msg_mission_item
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_mission_item(packet,param1,param2,param3,param4,x,y,z,seq,command,target_system,target_component,frame,current,autocontinue)
        
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
                
            elseif nargin == 15
                
				obj.param1 = param1;
				obj.param2 = param2;
				obj.param3 = param3;
				obj.param4 = param4;
				obj.x = x;
				obj.y = y;
				obj.z = z;
				obj.seq = seq;
				obj.command = command;
				obj.target_system = target_system;
				obj.target_component = target_component;
				obj.frame = frame;
				obj.current = current;
				obj.autocontinue = autocontinue;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_mission_item.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_mission_item.ID;
                
				packet.payload.putSINGLE(obj.param1);

				packet.payload.putSINGLE(obj.param2);

				packet.payload.putSINGLE(obj.param3);

				packet.payload.putSINGLE(obj.param4);

				packet.payload.putSINGLE(obj.x);

				packet.payload.putSINGLE(obj.y);

				packet.payload.putSINGLE(obj.z);

				packet.payload.putUINT16(obj.seq);

				packet.payload.putUINT16(obj.command);

				packet.payload.putUINT8(obj.target_system);

				packet.payload.putUINT8(obj.target_component);

				packet.payload.putUINT8(obj.frame);

				packet.payload.putUINT8(obj.current);

				packet.payload.putUINT8(obj.autocontinue);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.param1 = payload.getSINGLE();

			obj.param2 = payload.getSINGLE();

			obj.param3 = payload.getSINGLE();

			obj.param4 = payload.getSINGLE();

			obj.x = payload.getSINGLE();

			obj.y = payload.getSINGLE();

			obj.z = payload.getSINGLE();

			obj.seq = payload.getUINT16();

			obj.command = payload.getUINT16();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

			obj.frame = payload.getUINT8();

			obj.current = payload.getUINT8();

			obj.autocontinue = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.param1,2) ~= 1
                result = 'param1';                                        
            elseif size(obj.param2,2) ~= 1
                result = 'param2';                                        
            elseif size(obj.param3,2) ~= 1
                result = 'param3';                                        
            elseif size(obj.param4,2) ~= 1
                result = 'param4';                                        
            elseif size(obj.x,2) ~= 1
                result = 'x';                                        
            elseif size(obj.y,2) ~= 1
                result = 'y';                                        
            elseif size(obj.z,2) ~= 1
                result = 'z';                                        
            elseif size(obj.seq,2) ~= 1
                result = 'seq';                                        
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
                                
        function set.x(obj,value)
            obj.x = single(value);
        end
                                
        function set.y(obj,value)
            obj.y = single(value);
        end
                                
        function set.z(obj,value)
            obj.z = single(value);
        end
                                    
        function set.seq(obj,value)
            if value == uint16(value)
                obj.seq = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.command(obj,value)
            if value == uint16(value)
                obj.command = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
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
                                    
        function set.frame(obj,value)
            if value == uint8(value)
                obj.frame = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.current(obj,value)
            if value == uint8(value)
                obj.current = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.autocontinue(obj,value)
            if value == uint8(value)
                obj.autocontinue = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end