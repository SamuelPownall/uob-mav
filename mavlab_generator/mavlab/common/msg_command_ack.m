classdef msg_command_ack < mavlink_message
    %MAVLINK Message Class
    %Name: command_ack	ID: 77
    %Description: Report status of a command. Includes feedback wether the command was executed.
            
    properties(Constant)
        ID = 77
        LEN = 3
    end
    
    properties        
		command	%Command ID, as defined by MAV_CMD enum. (uint16[1])
		result	%See MAV_RESULT enum (uint8[1])
	end

    
    methods
        
        %Constructor: msg_command_ack
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_command_ack(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_command_ack.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_command_ack.ID;
                
			packet.payload.putUINT16(obj.command);

			packet.payload.putUINT8(obj.result);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.command = payload.getUINT16();

			obj.result = payload.getUINT8();

		end
            
        function set.command(obj,value)
            if value == uint16(value)
                obj.command = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | command_ack.set.command()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.result(obj,value)
            if value == uint8(value)
                obj.result = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | command_ack.set.result()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end