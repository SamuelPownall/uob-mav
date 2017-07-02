classdef msg_mission_count < mavlink_message
    %MAVLINK Message Class
    %Name: mission_count	ID: 44
    %Description: This message is emitted as response to MISSION_REQUEST_LIST by the MAV and to initiate a write transaction. The GCS can then request the individual mission item based on the knowledge of the total number of MISSIONs.
            
    properties(Constant)
        ID = 44
        LEN = 4
    end
    
    properties        
		count	%Number of mission items in the sequence (uint16[1])
		target_system	%System ID (uint8[1])
		target_component	%Component ID (uint8[1])
	end

    
    methods
        
        %Constructor: msg_mission_count
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_mission_count(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_mission_count.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_mission_count.ID;
                
			packet.payload.putUINT16(obj.count);

			packet.payload.putUINT8(obj.target_system);

			packet.payload.putUINT8(obj.target_component);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.count = payload.getUINT16();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

		end
            
        function set.count(obj,value)
            if value == uint16(value)
                obj.count = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_count.set.count()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_count.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | mission_count.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end