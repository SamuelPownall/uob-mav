classdef msg_mission_request_partial_list < mavlink_message
    %MAVLINK Message Class
    %Name: mission_request_partial_list	ID: 37
    %Description: Request a partial list of mission items from the system/component. http://qgroundcontrol.org/mavlink/waypoint_protocol. If start and end index are the same, just send one waypoint.
            
    properties(Constant)
        ID = 37
        LEN = 6
    end
    
    properties        
		start_index	%Start index, 0 by default (int16)
		end_index	%End index, -1 by default (-1: send list to end). Else a valid index of the list (int16)
		target_system	%System ID (uint8)
		target_component	%Component ID (uint8)
	end
    
    methods
        
        %Constructor: msg_mission_request_partial_list
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_mission_request_partial_list(packet)
        
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
        
                packet = mavlink_packet(msg_mission_request_partial_list.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_mission_request_partial_list.ID;
                
				packet.payload.putINT16(obj.start_index);

				packet.payload.putINT16(obj.end_index);

				packet.payload.putUINT8(obj.target_system);

				packet.payload.putUINT8(obj.target_component);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_mission_request_partial_list.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.start_index = payload.getINT16();

			obj.end_index = payload.getINT16();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.start_index,2) ~= 1
                result = 'start_index';                                        
            elseif size(obj.end_index,2) ~= 1
                result = 'end_index';                                        
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';                                        
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';                            
            else
                result = 0;
            end
            
        end
                                
        function set.start_index(obj,value)
            if value == int16(value)
                obj.start_index = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_request_partial_list.set.start_index()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.end_index(obj,value)
            if value == int16(value)
                obj.end_index = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_request_partial_list.set.end_index()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_request_partial_list.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_request_partial_list.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end