classdef msg_vision_speed_estimate < mavlink_message
    %MAVLINK Message Class
    %Name: vision_speed_estimate	ID: 103
    %Description: None
            
    properties(Constant)
        ID = 103
        LEN = 20
    end
    
    properties        
		usec	%Timestamp (microseconds, synced to UNIX time or since system boot) (uint64)
		x	%Global X speed (single)
		y	%Global Y speed (single)
		z	%Global Z speed (single)
	end
    
    methods
        
        %Constructor: msg_vision_speed_estimate
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_vision_speed_estimate(packet)
        
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
        
                packet = mavlink_packet(msg_vision_speed_estimate.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_vision_speed_estimate.ID;
                
				packet.payload.putUINT64(obj.usec);

				packet.payload.putSINGLE(obj.x);

				packet.payload.putSINGLE(obj.y);

				packet.payload.putSINGLE(obj.z);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_vision_speed_estimate.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.usec = payload.getUINT64();

			obj.x = payload.getSINGLE();

			obj.y = payload.getSINGLE();

			obj.z = payload.getSINGLE();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.usec,2) ~= 1
                result = 'usec';                                        
            elseif size(obj.x,2) ~= 1
                result = 'x';                                        
            elseif size(obj.y,2) ~= 1
                result = 'y';                                        
            elseif size(obj.z,2) ~= 1
                result = 'z';                            
            else
                result = 0;
            end
            
        end
                                
        function set.usec(obj,value)
            if value == uint64(value)
                obj.usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | vision_speed_estimate.set.usec()\n\t Input "value" is not of type "uint64"\n');
            end
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
                        
	end
end