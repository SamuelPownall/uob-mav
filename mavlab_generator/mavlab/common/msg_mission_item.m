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
		param1	%PARAM1, see MAV_CMD enum (single[1])
		param2	%PARAM2, see MAV_CMD enum (single[1])
		param3	%PARAM3, see MAV_CMD enum (single[1])
		param4	%PARAM4, see MAV_CMD enum (single[1])
		x	%PARAM5 / local: x position, global: latitude (single[1])
		y	%PARAM6 / y position: global: longitude (single[1])
		z	%PARAM7 / z position: global: altitude (relative or absolute, depending on frame. (single[1])
		seq	%Sequence (uint16[1])
		command	%The scheduled action for the MISSION. see MAV_CMD in common.xml MAVLink specs (uint16[1])
		target_system	%System ID (uint8[1])
		target_component	%Component ID (uint8[1])
		frame	%The coordinate system of the MISSION. see MAV_FRAME in mavlink_types.h (uint8[1])
		current	%false:0, true:1 (uint8[1])
		autocontinue	%autocontinue to next wp (uint8[1])
	end

    
    methods
        
        %Constructor: msg_mission_item
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_mission_item(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
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

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
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
                fprintf(2,'MAVLAB-ERROR | mission_item.set.seq()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.command(obj,value)
            if value == uint16(value)
                obj.command = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_item.set.command()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_item.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_item.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.frame(obj,value)
            if value == uint8(value)
                obj.frame = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_item.set.frame()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.current(obj,value)
            if value == uint8(value)
                obj.current = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_item.set.current()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.autocontinue(obj,value)
            if value == uint8(value)
                obj.autocontinue = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_item.set.autocontinue()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end