classdef msg_raw_imu < mavlink_message
    %MAVLINK Message Class
    %Name: raw_imu	ID: 27
    %Description: The RAW IMU readings for the usual 9DOF sensor setup. This message should always contain the true raw values without any scaling to allow data capture and system debugging.
            
    properties(Constant)
        ID = 27
        LEN = 26
    end
    
    properties        
		time_usec	%Timestamp (microseconds since UNIX epoch or microseconds since system boot) (uint64[1])
		xacc	%X acceleration (raw) (int16[1])
		yacc	%Y acceleration (raw) (int16[1])
		zacc	%Z acceleration (raw) (int16[1])
		xgyro	%Angular speed around X axis (raw) (int16[1])
		ygyro	%Angular speed around Y axis (raw) (int16[1])
		zgyro	%Angular speed around Z axis (raw) (int16[1])
		xmag	%X Magnetic field (raw) (int16[1])
		ymag	%Y Magnetic field (raw) (int16[1])
		zmag	%Z Magnetic field (raw) (int16[1])
	end

    
    methods
        
        %Constructor: msg_raw_imu
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_raw_imu(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_raw_imu.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_raw_imu.ID;
                
			packet.payload.putUINT64(obj.time_usec);

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
        
			obj.time_usec = payload.getUINT64();

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
            
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | raw_imu.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                    
        function set.xacc(obj,value)
            if value == int16(value)
                obj.xacc = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | raw_imu.set.xacc()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.yacc(obj,value)
            if value == int16(value)
                obj.yacc = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | raw_imu.set.yacc()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.zacc(obj,value)
            if value == int16(value)
                obj.zacc = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | raw_imu.set.zacc()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.xgyro(obj,value)
            if value == int16(value)
                obj.xgyro = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | raw_imu.set.xgyro()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.ygyro(obj,value)
            if value == int16(value)
                obj.ygyro = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | raw_imu.set.ygyro()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.zgyro(obj,value)
            if value == int16(value)
                obj.zgyro = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | raw_imu.set.zgyro()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.xmag(obj,value)
            if value == int16(value)
                obj.xmag = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | raw_imu.set.xmag()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.ymag(obj,value)
            if value == int16(value)
                obj.ymag = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | raw_imu.set.ymag()\n\t Input "value" is not of type "int16"\n');
            end
        end
                                    
        function set.zmag(obj,value)
            if value == int16(value)
                obj.zmag = int16(value);
            else
                fprintf(2,'MAVLAB-ERROR | raw_imu.set.zmag()\n\t Input "value" is not of type "int16"\n');
            end
        end
                        
	end
end