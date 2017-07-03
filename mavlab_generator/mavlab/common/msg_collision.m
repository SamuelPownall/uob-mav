classdef msg_collision < mavlink_message
    %MAVLINK Message Class
    %Name: collision	ID: 247
    %Description: Information about a potential collision
            
    properties(Constant)
        ID = 247
        LEN = 19
    end
    
    properties        
		id	%Unique identifier, domain based on src field (uint32)
		time_to_minimum_delta	%Estimated time until collision occurs (seconds) (single)
		altitude_minimum_delta	%Closest vertical distance in meters between vehicle and object (single)
		horizontal_minimum_delta	%Closest horizontal distance in meteres between vehicle and object (single)
		src	%Collision data source (uint8)
		action	%Action that is being taken to avoid this collision (uint8)
		threat_level	%How concerned the aircraft is about this collision (uint8)
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
        
            emptyField = obj.verify();
            if emptyField == 0
        
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
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_collision.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
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
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.id,2) ~= 1
                result = 'id';                                        
            elseif size(obj.time_to_minimum_delta,2) ~= 1
                result = 'time_to_minimum_delta';                                        
            elseif size(obj.altitude_minimum_delta,2) ~= 1
                result = 'altitude_minimum_delta';                                        
            elseif size(obj.horizontal_minimum_delta,2) ~= 1
                result = 'horizontal_minimum_delta';                                        
            elseif size(obj.src,2) ~= 1
                result = 'src';                                        
            elseif size(obj.action,2) ~= 1
                result = 'action';                                        
            elseif size(obj.threat_level,2) ~= 1
                result = 'threat_level';                            
            else
                result = 0;
            end
            
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