classdef msg_command_long < mavlink_message
    %MAVLINK Message Class
    %Name: command_long	ID: 76
    %Description: Send a command with up to seven parameters to the MAV
            
    properties(Constant)
        ID = 76
        LEN = 33
    end
    
    properties        
		param1	%Parameter 1, as defined by MAV_CMD enum. (single[1])
		param2	%Parameter 2, as defined by MAV_CMD enum. (single[1])
		param3	%Parameter 3, as defined by MAV_CMD enum. (single[1])
		param4	%Parameter 4, as defined by MAV_CMD enum. (single[1])
		param5	%Parameter 5, as defined by MAV_CMD enum. (single[1])
		param6	%Parameter 6, as defined by MAV_CMD enum. (single[1])
		param7	%Parameter 7, as defined by MAV_CMD enum. (single[1])
		command	%Command ID, as defined by MAV_CMD enum. (uint16[1])
		target_system	%System which should execute the command (uint8[1])
		target_component	%Component which should execute the command, 0 for all components (uint8[1])
		confirmation	%0: First transmission of this command. 1-255: Confirmation transmissions (e.g. for kill command) (uint8[1])
	end

    
    methods
        
        %Constructor: msg_command_long
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_command_long(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_command_long.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_command_long.ID;
                
			packet.payload.putSINGLE(obj.param1);

			packet.payload.putSINGLE(obj.param2);

			packet.payload.putSINGLE(obj.param3);

			packet.payload.putSINGLE(obj.param4);

			packet.payload.putSINGLE(obj.param5);

			packet.payload.putSINGLE(obj.param6);

			packet.payload.putSINGLE(obj.param7);

			packet.payload.putUINT16(obj.command);

			packet.payload.putUINT8(obj.target_system);

			packet.payload.putUINT8(obj.target_component);

			packet.payload.putUINT8(obj.confirmation);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.param1 = payload.getSINGLE();

			obj.param2 = payload.getSINGLE();

			obj.param3 = payload.getSINGLE();

			obj.param4 = payload.getSINGLE();

			obj.param5 = payload.getSINGLE();

			obj.param6 = payload.getSINGLE();

			obj.param7 = payload.getSINGLE();

			obj.command = payload.getUINT16();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

			obj.confirmation = payload.getUINT8();

		end
        
        function set.param1(obj,value)
            obj.param1 = single(value);
        end
                                
        function set.param2(obj,value)
            obj.param2 = single(value);
        end
                                
        function set.param3(obj,value)
            obj.param3 = single(value);
        end
                                
        function set.param4(obj,value)
            obj.param4 = single(value);
        end
                                
        function set.param5(obj,value)
            obj.param5 = single(value);
        end
                                
        function set.param6(obj,value)
            obj.param6 = single(value);
        end
                                
        function set.param7(obj,value)
            obj.param7 = single(value);
        end
                                    
        function set.command(obj,value)
            if value == uint16(value)
                obj.command = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | command_long.set.command()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | command_long.set.target_system()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | command_long.set.target_component()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.confirmation(obj,value)
            if value == uint8(value)
                obj.confirmation = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | command_long.set.confirmation()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end