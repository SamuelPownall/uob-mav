classdef msg_mission_write_partial_list < mavlink_message
    %MAVLINK Message Class
    %Name: mission_write_partial_list	ID: 38
    %Description: This message is sent to the MAV to write a partial list. If start index == end index, only one item will be transmitted / updated. If the start index is NOT 0 and above the current list size, this request should be REJECTED!
            
    properties(Constant)
        ID = 38
        LEN = 6
    end
    
    properties        
		start_index	%Start index, 0 by default and smaller / equal to the largest index of the current onboard list. (int16[1])
		end_index	%End index, equal or greater than start index. (int16[1])
		target_system	%System ID (uint8[1])
		target_component	%Component ID (uint8[1])
	end

    
    methods
        
        %Constructor: msg_mission_write_partial_list
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_mission_write_partial_list(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_mission_write_partial_list.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_mission_write_partial_list.ID;
                
			packet.payload.putINT16(obj.start_index);

			packet.payload.putINT16(obj.end_index);

			packet.payload.putUINT8(obj.target_system);

			packet.payload.putUINT8(obj.target_component);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.start_index = payload.getINT16();

			obj.end_index = payload.getINT16();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

		end
            
        function set.start_index(obj,value)
            if value == int16(value)
                obj.start_index = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_write_partial_list.set.start_index()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.end_index(obj,value)
            if value == int16(value)
                obj.end_index = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_write_partial_list.set.end_index()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_write_partial_list.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_write_partial_list.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end