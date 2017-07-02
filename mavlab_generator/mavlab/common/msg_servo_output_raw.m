classdef msg_servo_output_raw < mavlink_message
    %MAVLINK Message Class
    %Name: servo_output_raw	ID: 36
    %Description: The RAW values of the servo outputs (for RC input from the remote, use the RC_CHANNELS messages). The standard PPM modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 100%.
            
    properties(Constant)
        ID = 36
        LEN = 37
    end
    
    properties        
		time_usec	%Timestamp (microseconds since system boot) (uint32[1])
		servo1_raw	%Servo output 1 value, in microseconds (uint16[1])
		servo2_raw	%Servo output 2 value, in microseconds (uint16[1])
		servo3_raw	%Servo output 3 value, in microseconds (uint16[1])
		servo4_raw	%Servo output 4 value, in microseconds (uint16[1])
		servo5_raw	%Servo output 5 value, in microseconds (uint16[1])
		servo6_raw	%Servo output 6 value, in microseconds (uint16[1])
		servo7_raw	%Servo output 7 value, in microseconds (uint16[1])
		servo8_raw	%Servo output 8 value, in microseconds (uint16[1])
		servo9_raw	%Servo output 9 value, in microseconds (uint16[1])
		servo10_raw	%Servo output 10 value, in microseconds (uint16[1])
		servo11_raw	%Servo output 11 value, in microseconds (uint16[1])
		servo12_raw	%Servo output 12 value, in microseconds (uint16[1])
		servo13_raw	%Servo output 13 value, in microseconds (uint16[1])
		servo14_raw	%Servo output 14 value, in microseconds (uint16[1])
		servo15_raw	%Servo output 15 value, in microseconds (uint16[1])
		servo16_raw	%Servo output 16 value, in microseconds (uint16[1])
		port	%Servo output port (set of 8 outputs = 1 port). Most MAVs will just use one, but this allows to encode more than 8 servos. (uint8[1])
	end

    
    methods
        
        %Constructor: msg_servo_output_raw
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_servo_output_raw(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_servo_output_raw.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_servo_output_raw.ID;
                
			packet.payload.putUINT32(obj.time_usec);

			packet.payload.putUINT16(obj.servo1_raw);

			packet.payload.putUINT16(obj.servo2_raw);

			packet.payload.putUINT16(obj.servo3_raw);

			packet.payload.putUINT16(obj.servo4_raw);

			packet.payload.putUINT16(obj.servo5_raw);

			packet.payload.putUINT16(obj.servo6_raw);

			packet.payload.putUINT16(obj.servo7_raw);

			packet.payload.putUINT16(obj.servo8_raw);

			packet.payload.putUINT16(obj.servo9_raw);

			packet.payload.putUINT16(obj.servo10_raw);

			packet.payload.putUINT16(obj.servo11_raw);

			packet.payload.putUINT16(obj.servo12_raw);

			packet.payload.putUINT16(obj.servo13_raw);

			packet.payload.putUINT16(obj.servo14_raw);

			packet.payload.putUINT16(obj.servo15_raw);

			packet.payload.putUINT16(obj.servo16_raw);

			packet.payload.putUINT8(obj.port);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT32();

			obj.servo1_raw = payload.getUINT16();

			obj.servo2_raw = payload.getUINT16();

			obj.servo3_raw = payload.getUINT16();

			obj.servo4_raw = payload.getUINT16();

			obj.servo5_raw = payload.getUINT16();

			obj.servo6_raw = payload.getUINT16();

			obj.servo7_raw = payload.getUINT16();

			obj.servo8_raw = payload.getUINT16();

			obj.servo9_raw = payload.getUINT16();

			obj.servo10_raw = payload.getUINT16();

			obj.servo11_raw = payload.getUINT16();

			obj.servo12_raw = payload.getUINT16();

			obj.servo13_raw = payload.getUINT16();

			obj.servo14_raw = payload.getUINT16();

			obj.servo15_raw = payload.getUINT16();

			obj.servo16_raw = payload.getUINT16();

			obj.port = payload.getUINT8();

		end
            
        function set.time_usec(obj,value)
            if value == uint32(value)
                obj.time_usec = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | servo_output_raw.set.time_usec()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.servo1_raw(obj,value)
            if value == uint16(value)
                obj.servo1_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | servo_output_raw.set.servo1_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.servo2_raw(obj,value)
            if value == uint16(value)
                obj.servo2_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | servo_output_raw.set.servo2_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.servo3_raw(obj,value)
            if value == uint16(value)
                obj.servo3_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | servo_output_raw.set.servo3_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.servo4_raw(obj,value)
            if value == uint16(value)
                obj.servo4_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | servo_output_raw.set.servo4_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.servo5_raw(obj,value)
            if value == uint16(value)
                obj.servo5_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | servo_output_raw.set.servo5_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.servo6_raw(obj,value)
            if value == uint16(value)
                obj.servo6_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | servo_output_raw.set.servo6_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.servo7_raw(obj,value)
            if value == uint16(value)
                obj.servo7_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | servo_output_raw.set.servo7_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.servo8_raw(obj,value)
            if value == uint16(value)
                obj.servo8_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | servo_output_raw.set.servo8_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.servo9_raw(obj,value)
            if value == uint16(value)
                obj.servo9_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | servo_output_raw.set.servo9_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.servo10_raw(obj,value)
            if value == uint16(value)
                obj.servo10_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | servo_output_raw.set.servo10_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.servo11_raw(obj,value)
            if value == uint16(value)
                obj.servo11_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | servo_output_raw.set.servo11_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.servo12_raw(obj,value)
            if value == uint16(value)
                obj.servo12_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | servo_output_raw.set.servo12_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.servo13_raw(obj,value)
            if value == uint16(value)
                obj.servo13_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | servo_output_raw.set.servo13_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.servo14_raw(obj,value)
            if value == uint16(value)
                obj.servo14_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | servo_output_raw.set.servo14_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.servo15_raw(obj,value)
            if value == uint16(value)
                obj.servo15_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | servo_output_raw.set.servo15_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.servo16_raw(obj,value)
            if value == uint16(value)
                obj.servo16_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | servo_output_raw.set.servo16_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.port(obj,value)
            if value == uint8(value)
                obj.port = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | servo_output_raw.set.port()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end