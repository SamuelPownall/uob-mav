classdef msg_raw_pressure < mavlink_message
    %MAVLINK Message Class
    %Name: raw_pressure	ID: 28
    %Description: The RAW pressure readings for the typical setup of one absolute pressure and one differential pressure sensor. The sensor values should be the raw, UNSCALED ADC values.
            
    properties(Constant)
        ID = 28
        LEN = 16
    end
    
    properties        
		time_usec	%Timestamp (microseconds since UNIX epoch or microseconds since system boot) (uint64)
		press_abs	%Absolute pressure (raw) (int16)
		press_diff1	%Differential pressure 1 (raw, 0 if nonexistant) (int16)
		press_diff2	%Differential pressure 2 (raw, 0 if nonexistant) (int16)
		temperature	%Raw Temperature measurement (raw) (int16)
	end
    
    methods
        
        %Constructor: msg_raw_pressure
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_raw_pressure(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            emptyField = obj.verify();
            if emptyField == 0
        
                packet = mavlink_packet(msg_raw_pressure.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_raw_pressure.ID;
                
				packet.payload.putUINT64(obj.time_usec);

				packet.payload.putINT16(obj.press_abs);

				packet.payload.putINT16(obj.press_diff1);

				packet.payload.putINT16(obj.press_diff2);

				packet.payload.putINT16(obj.temperature);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_raw_pressure.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();

			obj.press_abs = payload.getINT16();

			obj.press_diff1 = payload.getINT16();

			obj.press_diff2 = payload.getINT16();

			obj.temperature = payload.getINT16();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_usec,2) ~= 1
                result = 'time_usec';                                        
            elseif size(obj.press_abs,2) ~= 1
                result = 'press_abs';                                        
            elseif size(obj.press_diff1,2) ~= 1
                result = 'press_diff1';                                        
            elseif size(obj.press_diff2,2) ~= 1
                result = 'press_diff2';                                        
            elseif size(obj.temperature,2) ~= 1
                result = 'temperature';                            
            else
                result = 0;
            end
            
        end
                                
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | raw_pressure.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                    
        function set.press_abs(obj,value)
            if value == int16(value)
                obj.press_abs = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | raw_pressure.set.press_abs()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.press_diff1(obj,value)
            if value == int16(value)
                obj.press_diff1 = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | raw_pressure.set.press_diff1()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.press_diff2(obj,value)
            if value == int16(value)
                obj.press_diff2 = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | raw_pressure.set.press_diff2()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.temperature(obj,value)
            if value == int16(value)
                obj.temperature = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | raw_pressure.set.temperature()\n\t Input "value" is not of type "int16"\n');
            end
        end
                        
	end
end