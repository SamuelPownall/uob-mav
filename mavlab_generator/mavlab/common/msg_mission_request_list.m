classdef msg_mission_request_list < mavlink_message
    %MAVLINK Message Class
    %Name: mission_request_list	ID: 43
    %Description: Request the overall list of mission items from the system/component.
            
    properties(Constant)
        ID = 43
        LEN = 2
    end
    
    properties        
		target_system	%System ID (uint8[1])
		target_component	%Component ID (uint8[1])
	end

    
    methods
        
        %Constructor: msg_mission_request_list
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_mission_request_list(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_mission_request_list.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_mission_request_list.ID;
                
			packet.payload.putUINT8(obj.target_system);

			packet.payload.putUINT8(obj.target_component);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

		end
            
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_request_list.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_request_list.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end