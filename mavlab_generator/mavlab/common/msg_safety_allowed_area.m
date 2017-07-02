classdef msg_safety_allowed_area < mavlink_message
    %MAVLINK Message Class
    %Name: safety_allowed_area	ID: 55
    %Description: Read out the safety zone the MAV currently assumes.
            
    properties(Constant)
        ID = 55
        LEN = 25
    end
    
    properties        
		p1x	%x position 1 / Latitude 1 (single[1])
		p1y	%y position 1 / Longitude 1 (single[1])
		p1z	%z position 1 / Altitude 1 (single[1])
		p2x	%x position 2 / Latitude 2 (single[1])
		p2y	%y position 2 / Longitude 2 (single[1])
		p2z	%z position 2 / Altitude 2 (single[1])
		frame	%Coordinate frame, as defined by MAV_FRAME enum in mavlink_types.h. Can be either global, GPS, right-handed with Z axis up or local, right handed, Z axis down. (uint8[1])
	end

    
    methods
        
        %Constructor: msg_safety_allowed_area
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_safety_allowed_area(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_safety_allowed_area.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_safety_allowed_area.ID;
                
			packet.payload.putSINGLE(obj.p1x);

			packet.payload.putSINGLE(obj.p1y);

			packet.payload.putSINGLE(obj.p1z);

			packet.payload.putSINGLE(obj.p2x);

			packet.payload.putSINGLE(obj.p2y);

			packet.payload.putSINGLE(obj.p2z);

			packet.payload.putUINT8(obj.frame);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.p1x = payload.getSINGLE();

			obj.p1y = payload.getSINGLE();

			obj.p1z = payload.getSINGLE();

			obj.p2x = payload.getSINGLE();

			obj.p2y = payload.getSINGLE();

			obj.p2z = payload.getSINGLE();

			obj.frame = payload.getUINT8();

		end
        
        function set.p1x(obj,value)
            obj.p1x = single(value);
        end
                                
        function set.p1y(obj,value)
            obj.p1y = single(value);
        end
                                
        function set.p1z(obj,value)
            obj.p1z = single(value);
        end
                                
        function set.p2x(obj,value)
            obj.p2x = single(value);
        end
                                
        function set.p2y(obj,value)
            obj.p2y = single(value);
        end
                                
        function set.p2z(obj,value)
            obj.p2z = single(value);
        end
                                    
        function set.frame(obj,value)
            if value == uint8(value)
                obj.frame = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | safety_allowed_area.set.frame()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end