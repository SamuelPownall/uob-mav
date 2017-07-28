classdef msg_command_long < mavlink_message
	%MSG_COMMAND_LONG(packet,param1,param2,param3,param4,param5,param6,param7,command,target_system,target_component,confirmation): MAVLINK Message ID = 76
    %Description:
    %    Send a command with up to seven parameters to the MAV
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    param1(single): Parameter 1, as defined by MAV_CMD enum.
    %    param2(single): Parameter 2, as defined by MAV_CMD enum.
    %    param3(single): Parameter 3, as defined by MAV_CMD enum.
    %    param4(single): Parameter 4, as defined by MAV_CMD enum.
    %    param5(single): Parameter 5, as defined by MAV_CMD enum.
    %    param6(single): Parameter 6, as defined by MAV_CMD enum.
    %    param7(single): Parameter 7, as defined by MAV_CMD enum.
    %    command(uint16): Command ID, as defined by MAV_CMD enum.
    %    target_system(uint8): System which should execute the command
    %    target_component(uint8): Component which should execute the command, 0 for all components
    %    confirmation(uint8): 0: First transmission of this command. 1-255: Confirmation transmissions (e.g. for kill command)
	
	properties(Constant)
		ID = 76
		LEN = 33
	end
	
	properties
        param1	%Parameter 1, as defined by MAV_CMD enum.	|	(single)
        param2	%Parameter 2, as defined by MAV_CMD enum.	|	(single)
        param3	%Parameter 3, as defined by MAV_CMD enum.	|	(single)
        param4	%Parameter 4, as defined by MAV_CMD enum.	|	(single)
        param5	%Parameter 5, as defined by MAV_CMD enum.	|	(single)
        param6	%Parameter 6, as defined by MAV_CMD enum.	|	(single)
        param7	%Parameter 7, as defined by MAV_CMD enum.	|	(single)
        command	%Command ID, as defined by MAV_CMD enum.	|	(uint16)
        target_system	%System which should execute the command	|	(uint8)
        target_component	%Component which should execute the command, 0 for all components	|	(uint8)
        confirmation	%0: First transmission of this command. 1-255: Confirmation transmissions (e.g. for kill command)	|	(uint8)
    end

    methods

        %Constructor: msg_command_long
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_command_long(packet,param1,param2,param3,param4,param5,param6,param7,command,target_system,target_component,confirmation)
        
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
            
            elseif nargin-1 == 11
                obj.param1 = param1;
                obj.param2 = param2;
                obj.param3 = param3;
                obj.param4 = param4;
                obj.param5 = param5;
                obj.param6 = param6;
                obj.param7 = param7;
                obj.command = command;
                obj.target_system = target_system;
                obj.target_component = target_component;
                obj.confirmation = confirmation;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

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

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
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
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.param1,2) ~= 1
                result = 'param1';
            elseif size(obj.param2,2) ~= 1
                result = 'param2';
            elseif size(obj.param3,2) ~= 1
                result = 'param3';
            elseif size(obj.param4,2) ~= 1
                result = 'param4';
            elseif size(obj.param5,2) ~= 1
                result = 'param5';
            elseif size(obj.param6,2) ~= 1
                result = 'param6';
            elseif size(obj.param7,2) ~= 1
                result = 'param7';
            elseif size(obj.command,2) ~= 1
                result = 'command';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';
            elseif size(obj.confirmation,2) ~= 1
                result = 'confirmation';

            else
                result = 0;
            end
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
        
        function set.confirmation(obj,value)
            if value == uint8(value)
                obj.confirmation = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end