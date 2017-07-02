classdef msg_debug_vect < mavlink_message
    %MAVLINK Message Class
    %Name: debug_vect	ID: 250
    %Description: None
            
    properties(Constant)
        ID = 250
        LEN = 30
    end
    
    properties        
		time_usec	%Timestamp (uint64[1])
		x	%x (single[1])
		y	%y (single[1])
		z	%z (single[1])
		name	%Name (uint8[10])
	end

    
    methods
        
        %Constructor: msg_debug_vect
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_debug_vect(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_debug_vect.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_debug_vect.ID;
                
			packet.payload.putUINT64(obj.time_usec);

			packet.payload.putSINGLE(obj.x);

			packet.payload.putSINGLE(obj.y);

			packet.payload.putSINGLE(obj.z);
            
            for i = 1:10
                packet.payload.putUINT8(obj.name(i));
            end
                            
		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();

			obj.x = payload.getSINGLE();

			obj.y = payload.getSINGLE();

			obj.z = payload.getSINGLE();
            
            for i = 1:10
                obj.name(i) = payload.getUINT8();
            end
                            
		end
            
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | debug_vect.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
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
                                    
        function set.name(obj,value)
            if value == uint8(value)
                obj.name = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | debug_vect.set.name()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end