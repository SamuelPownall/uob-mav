classdef msg_collision < mavlink_message
    %MAVLINK Message Class
    %Name: collision	ID: 247
    %Description: Information about a potential collision
            
    properties(Constant)
        ID = 247
        LEN = 19
    end
    
    properties        
		id	%Unique identifier, domain based on src field (uint32[1])
		time_to_minimum_delta	%Estimated time until collision occurs (seconds) (single[1])
		altitude_minimum_delta	%Closest vertical distance in meters between vehicle and object (single[1])
		horizontal_minimum_delta	%Closest horizontal distance in meteres between vehicle and object (single[1])
		src	%Collision data source (uint8[1])
		action	%Action that is being taken to avoid this collision (uint8[1])
		threat_level	%How concerned the aircraft is about this collision (uint8[1])
	end

    
    methods
        
        %Constructor: msg_collision
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_collision(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_collision.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_collision.ID;
                
			packet.payload.putUINT32(obj.id);

			packet.payload.putSINGLE(obj.time_to_minimum_delta);

			packet.payload.putSINGLE(obj.altitude_minimum_delta);

			packet.payload.putSINGLE(obj.horizontal_minimum_delta);

			packet.payload.putUINT8(obj.src);

			packet.payload.putUINT8(obj.action);

			packet.payload.putUINT8(obj.threat_level);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.id = payload.getUINT32();

			obj.time_to_minimum_delta = payload.getSINGLE();

			obj.altitude_minimum_delta = payload.getSINGLE();

			obj.horizontal_minimum_delta = payload.getSINGLE();

			obj.src = payload.getUINT8();

			obj.action = payload.getUINT8();

			obj.threat_level = payload.getUINT8();

		end
            
        function set.id(obj,value)
            if value == uint32(value)
                obj.id = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | collision.set.id()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                
        function set.time_to_minimum_delta(obj,value)
            obj.time_to_minimum_delta = single(value);
        end
                                
        function set.altitude_minimum_delta(obj,value)
            obj.altitude_minimum_delta = single(value);
        end
                                
        function set.horizontal_minimum_delta(obj,value)
            obj.horizontal_minimum_delta = single(value);
        end
                                    
        function set.src(obj,value)
            if value == uint8(value)
                obj.src = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | collision.set.src()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.action(obj,value)
            if value == uint8(value)
                obj.action = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | collision.set.action()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.threat_level(obj,value)
            if value == uint8(value)
                obj.threat_level = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | collision.set.threat_level()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end