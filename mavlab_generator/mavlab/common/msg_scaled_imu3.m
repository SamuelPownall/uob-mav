classdef msg_scaled_imu3 < mavlink_message
    %MAVLINK Message Class
    %Name: scaled_imu3	ID: 129
    %Description: The RAW IMU readings for 3rd 9DOF sensor setup. This message should contain the scaled values to the described units
            
    properties(Constant)
        ID = 129
        LEN = 22
    end
    
    properties        
		time_boot_ms	%Timestamp (milliseconds since system boot) (uint32[1])
		xacc	%X acceleration (mg) (int16[1])
		yacc	%Y acceleration (mg) (int16[1])
		zacc	%Z acceleration (mg) (int16[1])
		xgyro	%Angular speed around X axis (millirad /sec) (int16[1])
		ygyro	%Angular speed around Y axis (millirad /sec) (int16[1])
		zgyro	%Angular speed around Z axis (millirad /sec) (int16[1])
		xmag	%X Magnetic field (milli tesla) (int16[1])
		ymag	%Y Magnetic field (milli tesla) (int16[1])
		zmag	%Z Magnetic field (milli tesla) (int16[1])
	end

    
    methods
        
        %Constructor: msg_scaled_imu3
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_scaled_imu3(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_scaled_imu3.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_scaled_imu3.ID;
                
			packet.payload.putUINT32(obj.time_boot_ms);

			packet.payload.putINT16(obj.xacc);

			packet.payload.putINT16(obj.yacc);

			packet.payload.putINT16(obj.zacc);

			packet.payload.putINT16(obj.xgyro);

			packet.payload.putINT16(obj.ygyro);

			packet.payload.putINT16(obj.zgyro);

			packet.payload.putINT16(obj.xmag);

			packet.payload.putINT16(obj.ymag);

			packet.payload.putINT16(obj.zmag);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_boot_ms = payload.getUINT32();

			obj.xacc = payload.getINT16();

			obj.yacc = payload.getINT16();

			obj.zacc = payload.getINT16();

			obj.xgyro = payload.getINT16();

			obj.ygyro = payload.getINT16();

			obj.zgyro = payload.getINT16();

			obj.xmag = payload.getINT16();

			obj.ymag = payload.getINT16();

			obj.zmag = payload.getINT16();

		end
            
        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | scaled_imu3.set.time_boot_ms()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.xacc(obj,value)
            if value == int16(value)
                obj.xacc = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | scaled_imu3.set.xacc()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.yacc(obj,value)
            if value == int16(value)
                obj.yacc = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | scaled_imu3.set.yacc()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.zacc(obj,value)
            if value == int16(value)
                obj.zacc = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | scaled_imu3.set.zacc()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.xgyro(obj,value)
            if value == int16(value)
                obj.xgyro = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | scaled_imu3.set.xgyro()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.ygyro(obj,value)
            if value == int16(value)
                obj.ygyro = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | scaled_imu3.set.ygyro()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.zgyro(obj,value)
            if value == int16(value)
                obj.zgyro = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | scaled_imu3.set.zgyro()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.xmag(obj,value)
            if value == int16(value)
                obj.xmag = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | scaled_imu3.set.xmag()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.ymag(obj,value)
            if value == int16(value)
                obj.ymag = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | scaled_imu3.set.ymag()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.zmag(obj,value)
            if value == int16(value)
                obj.zmag = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | scaled_imu3.set.zmag()\n\t Input "value" is not of type "int16"\n');
            end
        end
                        
	end
end