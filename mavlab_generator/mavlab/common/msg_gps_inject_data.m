classdef msg_gps_inject_data < mavlink_message
    %MAVLINK Message Class
    %Name: gps_inject_data	ID: 123
    %Description: data for injecting into the onboard GPS (used for DGPS)
            
    properties(Constant)
        ID = 123
        LEN = 113
    end
    
    properties        
		target_system	%System ID (uint8[1])
		target_component	%Component ID (uint8[1])
		len	%data length (uint8[1])
		data	%raw data (110 is enough for 12 satellites of RTCMv2) (uint8[110])
	end

    
    methods
        
        %Constructor: msg_gps_inject_data
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_gps_inject_data(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_gps_inject_data.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_gps_inject_data.ID;
                
			packet.payload.putUINT8(obj.target_system);

			packet.payload.putUINT8(obj.target_component);

			packet.payload.putUINT8(obj.len);
            
            for i = 1:110
                packet.payload.putUINT8(obj.data(i));
            end
                            
		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

			obj.len = payload.getUINT8();
            
            for i = 1:110
                obj.data(i) = payload.getUINT8();
            end
                            
		end
            
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps_inject_data.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps_inject_data.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.len(obj,value)
            if value == uint8(value)
                obj.len = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps_inject_data.set.len()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.data(obj,value)
            if value == uint8(value)
                obj.data = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps_inject_data.set.data()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end