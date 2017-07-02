classdef msg_play_tune < mavlink_message
    %MAVLINK Message Class
    %Name: play_tune	ID: 258
    %Description: Control vehicle tone generation (buzzer)
            
    properties(Constant)
        ID = 258
        LEN = 32
    end
    
    properties        
		target_system	%System ID (uint8[1])
		target_component	%Component ID (uint8[1])
		tune	%tune in board specific format (uint8[30])
	end

    
    methods
        
        %Constructor: msg_play_tune
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_play_tune(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_play_tune.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_play_tune.ID;
                
			packet.payload.putUINT8(obj.target_system);

			packet.payload.putUINT8(obj.target_component);
            
            for i = 1:30
                packet.payload.putUINT8(obj.tune(i));
            end
                            
		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();
            
            for i = 1:30
                obj.tune(i) = payload.getUINT8();
            end
                            
		end
            
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | play_tune.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | play_tune.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.tune(obj,value)
            if value == uint8(value)
                obj.tune = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | play_tune.set.tune()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end