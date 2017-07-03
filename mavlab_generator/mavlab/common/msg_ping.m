classdef msg_ping < mavlink_message
    %MAVLINK Message Class
    %Name: ping	ID: 4
    %Description: A ping message either requesting or responding to a ping. This allows to measure the system latencies, including serial port, radio modem and UDP connections.
            
    properties(Constant)
        ID = 4
        LEN = 14
    end
    
    properties        
		time_usec	%Unix timestamp in microseconds or since system boot if smaller than MAVLink epoch (1.1.2009) (uint64)
		seq	%PING sequence (uint32)
		target_system	%0: request ping from all receiving systems, if greater than 0: message is a ping response and number is the system id of the requesting system (uint8)
		target_component	%0: request ping from all receiving components, if greater than 0: message is a ping response and number is the system id of the requesting system (uint8)
	end
    
    methods
        
        %Constructor: msg_ping
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_ping(packet)
        
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
        
                packet = mavlink_packet(msg_ping.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_ping.ID;
                
				packet.payload.putUINT64(obj.time_usec);

				packet.payload.putUINT32(obj.seq);

				packet.payload.putUINT8(obj.target_system);

				packet.payload.putUINT8(obj.target_component);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_ping.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();

			obj.seq = payload.getUINT32();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_usec,2) ~= 1
                result = 'time_usec';                                        
            elseif size(obj.seq,2) ~= 1
                result = 'seq';                                        
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';                                        
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';                            
            else
                result = 0;
            end
            
        end
                                
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | ping.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                    
        function set.seq(obj,value)
            if value == uint32(value)
                obj.seq = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | ping.set.seq()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | ping.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | ping.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end