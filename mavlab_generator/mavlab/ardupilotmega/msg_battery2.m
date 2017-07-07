classdef msg_battery2 < mavlink_message
    %MAVLINK Message Class
    %Name: battery2	ID: 181
    %Description: 2nd Battery status
            
    properties(Constant)
        ID = 181
        LEN = 4
    end
    
    properties        
		voltage	%voltage in millivolts (uint16)
		current_battery	%Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current (int16)
	end
    
    methods
        
        %Constructor: msg_battery2
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_battery2(packet,voltage,current_battery)
        
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
                
				obj.voltage = voltage;
				obj.current_battery = current_battery;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_battery2.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_battery2.ID;
                
				packet.payload.putUINT16(obj.voltage);

				packet.payload.putINT16(obj.current_battery);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.voltage = payload.getUINT16();

			obj.current_battery = payload.getINT16();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.voltage,2) ~= 1
                result = 'voltage';                                        
            elseif size(obj.current_battery,2) ~= 1
                result = 'current_battery';                            
            else
                result = 0;
            end
            
        end
                                
        function set.voltage(obj,value)
            if value == uint16(value)
                obj.voltage = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.current_battery(obj,value)
            if value == int16(value)
                obj.current_battery = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
                        
	end
end