classdef msg_command_ack < mavlink_message
    %MAVLINK Message Class
    %Name: command_ack	ID: 77
    %Description: Report status of a command. Includes feedback wether the command was executed.
            
    properties(Constant)
        ID = 77
        LEN = 3
    end
    
    properties        
		command	%Command ID, as defined by MAV_CMD enum. (uint16)
		result	%See MAV_RESULT enum (uint8)
	end
    
    methods
        
        %Constructor: msg_command_ack
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_command_ack(packet,command,result)
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(packet,'mavlink_packet')
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('packet','mavlink_packet');
                end
                
            elseif nargin == 3
                
				obj.command = command;
				obj.result = result;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_command_ack.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_command_ack.ID;
                
				packet.payload.putUINT16(obj.command);

				packet.payload.putUINT8(obj.result);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.command = payload.getUINT16();

			obj.result = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.command,2) ~= 1
                result = 'command';                                        
            elseif size(obj.result,2) ~= 1
                result = 'result';                            
            else
                result = 0;
            end
            
        end
                                
        function set.command(obj,value)
            if value == uint16(value)
                obj.command = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.result(obj,value)
            if value == uint8(value)
                obj.result = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end