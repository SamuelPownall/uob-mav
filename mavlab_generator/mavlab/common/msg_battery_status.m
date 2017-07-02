classdef msg_battery_status < mavlink_message
    %MAVLINK Message Class
    %Name: battery_status	ID: 147
    %Description: Battery information
            
    properties(Constant)
        ID = 147
        LEN = 36
    end
    
    properties        
		current_consumed	%Consumed charge, in milliampere hours (1 = 1 mAh), -1: autopilot does not provide mAh consumption estimate (int32[1])
		energy_consumed	%Consumed energy, in 100*Joules (intergrated U*I*dt)  (1 = 100 Joule), -1: autopilot does not provide energy consumption estimate (int32[1])
		temperature	%Temperature of the battery in centi-degrees celsius. INT16_MAX for unknown temperature. (int16[1])
		voltages	%Battery voltage of cells, in millivolts (1 = 1 millivolt). Cells above the valid cell count for this battery should have the UINT16_MAX value. (uint16[10])
		current_battery	%Battery current, in 10*milliamperes (1 = 10 milliampere), -1: autopilot does not measure the current (int16[1])
		id	%Battery ID (uint8[1])
		battery_function	%Function of the battery (uint8[1])
		type	%Type (chemistry) of the battery (uint8[1])
		battery_remaining	%Remaining battery energy: (0%: 0, 100%: 100), -1: autopilot does not estimate the remaining battery (int8[1])
	end

    
    methods
        
        %Constructor: msg_battery_status
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_battery_status(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_battery_status.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_battery_status.ID;
                
			packet.payload.putINT32(obj.current_consumed);

			packet.payload.putINT32(obj.energy_consumed);

			packet.payload.putINT16(obj.temperature);
            
            for i = 1:10
                packet.payload.putUINT16(obj.voltages(i));
            end
                            
			packet.payload.putINT16(obj.current_battery);

			packet.payload.putUINT8(obj.id);

			packet.payload.putUINT8(obj.battery_function);

			packet.payload.putUINT8(obj.type);

			packet.payload.putINT8(obj.battery_remaining);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.current_consumed = payload.getINT32();

			obj.energy_consumed = payload.getINT32();

			obj.temperature = payload.getINT16();
            
            for i = 1:10
                obj.voltages(i) = payload.getUINT16();
            end
                            
			obj.current_battery = payload.getINT16();

			obj.id = payload.getUINT8();

			obj.battery_function = payload.getUINT8();

			obj.type = payload.getUINT8();

			obj.battery_remaining = payload.getINT8();

		end
            
        function set.current_consumed(obj,value)
            if value == int32(value)
                obj.current_consumed = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | battery_status.set.current_consumed()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.energy_consumed(obj,value)
            if value == int32(value)
                obj.energy_consumed = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | battery_status.set.energy_consumed()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.temperature(obj,value)
            if value == int16(value)
                obj.temperature = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | battery_status.set.temperature()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.voltages(obj,value)
            if value == uint16(value)
                obj.voltages = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | battery_status.set.voltages()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.current_battery(obj,value)
            if value == int16(value)
                obj.current_battery = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | battery_status.set.current_battery()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.id(obj,value)
            if value == uint8(value)
                obj.id = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | battery_status.set.id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.battery_function(obj,value)
            if value == uint8(value)
                obj.battery_function = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | battery_status.set.battery_function()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.type(obj,value)
            if value == uint8(value)
                obj.type = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | battery_status.set.type()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.battery_remaining(obj,value)
            if value == int8(value)
                obj.battery_remaining = int8(value);
            else
                fprintf(2,'MAVLAB-ERROR | battery_status.set.battery_remaining()\n\t Input "value" is not of type "int8"\n');
            end
        end
                        
	end
end