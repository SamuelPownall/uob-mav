classdef msg_mission_request < mavlink_message
    %MAVLINK Message Class
    %Name: mission_request	ID: 40
    %Description: Request the information of the mission item with the sequence number seq. The response of the system to this message should be a MISSION_ITEM message. http://qgroundcontrol.org/mavlink/waypoint_protocol
            
    properties(Constant)
        ID = 40
        LEN = 4
    end
    
    properties        
		seq	%Sequence (uint16)
		target_system	%System ID (uint8)
		target_component	%Component ID (uint8)
	end
    
    methods
        
        %Constructor: msg_mission_request
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_mission_request(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_mission_request.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_mission_request.ID;
                
				packet.payload.putUINT16(obj.seq);

				packet.payload.putUINT8(obj.target_system);

				packet.payload.putUINT8(obj.target_component);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.seq = payload.getUINT16();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.seq,2) ~= 1
                result = 'seq';                                        
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';                                        
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';                            
            else
                result = 0;
            end
            
        end
                                
        function set.seq(obj,value)
            if value == uint16(value)
                obj.seq = uint16(value);
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
                        
	end
end