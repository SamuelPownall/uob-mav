classdef msg_highres_imu < mavlink_message
    %MAVLINK Message Class
    %Name: highres_imu	ID: 105
    %Description: The IMU readings in SI units in NED body frame
            
    properties(Constant)
        ID = 105
        LEN = 62
    end
    
    properties        
		time_usec	%Timestamp (microseconds, synced to UNIX time or since system boot) (uint64)
		xacc	%X acceleration (m/s^2) (single)
		yacc	%Y acceleration (m/s^2) (single)
		zacc	%Z acceleration (m/s^2) (single)
		xgyro	%Angular speed around X axis (rad / sec) (single)
		ygyro	%Angular speed around Y axis (rad / sec) (single)
		zgyro	%Angular speed around Z axis (rad / sec) (single)
		xmag	%X Magnetic field (Gauss) (single)
		ymag	%Y Magnetic field (Gauss) (single)
		zmag	%Z Magnetic field (Gauss) (single)
		abs_pressure	%Absolute pressure in millibar (single)
		diff_pressure	%Differential pressure in millibar (single)
		pressure_alt	%Altitude calculated from pressure (single)
		temperature	%Temperature in degrees celsius (single)
		fields_updated	%Bitmask for fields that have updated since last message, bit 0 = xacc, bit 12: temperature (uint16)
	end
    
    methods
        
        %Constructor: msg_highres_imu
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_highres_imu(packet)
        
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
        
                packet = mavlink_packet(msg_highres_imu.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_highres_imu.ID;
                
				packet.payload.putUINT64(obj.time_usec);

				packet.payload.putSINGLE(obj.xacc);

				packet.payload.putSINGLE(obj.yacc);

				packet.payload.putSINGLE(obj.zacc);

				packet.payload.putSINGLE(obj.xgyro);

				packet.payload.putSINGLE(obj.ygyro);

				packet.payload.putSINGLE(obj.zgyro);

				packet.payload.putSINGLE(obj.xmag);

				packet.payload.putSINGLE(obj.ymag);

				packet.payload.putSINGLE(obj.zmag);

				packet.payload.putSINGLE(obj.abs_pressure);

				packet.payload.putSINGLE(obj.diff_pressure);

				packet.payload.putSINGLE(obj.pressure_alt);

				packet.payload.putSINGLE(obj.temperature);

				packet.payload.putUINT16(obj.fields_updated);
        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_highres_imu.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();

			obj.xacc = payload.getSINGLE();

			obj.yacc = payload.getSINGLE();

			obj.zacc = payload.getSINGLE();

			obj.xgyro = payload.getSINGLE();

			obj.ygyro = payload.getSINGLE();

			obj.zgyro = payload.getSINGLE();

			obj.xmag = payload.getSINGLE();

			obj.ymag = payload.getSINGLE();

			obj.zmag = payload.getSINGLE();

			obj.abs_pressure = payload.getSINGLE();

			obj.diff_pressure = payload.getSINGLE();

			obj.pressure_alt = payload.getSINGLE();

			obj.temperature = payload.getSINGLE();

			obj.fields_updated = payload.getUINT16();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_usec,2) ~= 1
                result = 'time_usec';                                        
            elseif size(obj.xacc,2) ~= 1
                result = 'xacc';                                        
            elseif size(obj.yacc,2) ~= 1
                result = 'yacc';                                        
            elseif size(obj.zacc,2) ~= 1
                result = 'zacc';                                        
            elseif size(obj.xgyro,2) ~= 1
                result = 'xgyro';                                        
            elseif size(obj.ygyro,2) ~= 1
                result = 'ygyro';                                        
            elseif size(obj.zgyro,2) ~= 1
                result = 'zgyro';                                        
            elseif size(obj.xmag,2) ~= 1
                result = 'xmag';                                        
            elseif size(obj.ymag,2) ~= 1
                result = 'ymag';                                        
            elseif size(obj.zmag,2) ~= 1
                result = 'zmag';                                        
            elseif size(obj.abs_pressure,2) ~= 1
                result = 'abs_pressure';                                        
            elseif size(obj.diff_pressure,2) ~= 1
                result = 'diff_pressure';                                        
            elseif size(obj.pressure_alt,2) ~= 1
                result = 'pressure_alt';                                        
            elseif size(obj.temperature,2) ~= 1
                result = 'temperature';                                        
            elseif size(obj.fields_updated,2) ~= 1
                result = 'fields_updated';                            
            else
                result = 0;
            end
            
        end
                                
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | highres_imu.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                
        function set.xacc(obj,value)
            obj.xacc = single(value);
        end
                                
        function set.yacc(obj,value)
            obj.yacc = single(value);
        end
                                
        function set.zacc(obj,value)
            obj.zacc = single(value);
        end
                                
        function set.xgyro(obj,value)
            obj.xgyro = single(value);
        end
                                
        function set.ygyro(obj,value)
            obj.ygyro = single(value);
        end
                                
        function set.zgyro(obj,value)
            obj.zgyro = single(value);
        end
                                
        function set.xmag(obj,value)
            obj.xmag = single(value);
        end
                                
        function set.ymag(obj,value)
            obj.ymag = single(value);
        end
                                
        function set.zmag(obj,value)
            obj.zmag = single(value);
        end
                                
        function set.abs_pressure(obj,value)
            obj.abs_pressure = single(value);
        end
                                
        function set.diff_pressure(obj,value)
            obj.diff_pressure = single(value);
        end
                                
        function set.pressure_alt(obj,value)
            obj.pressure_alt = single(value);
        end
                                
        function set.temperature(obj,value)
            obj.temperature = single(value);
        end
                                    
        function set.fields_updated(obj,value)
            if value == uint16(value)
                obj.fields_updated = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | highres_imu.set.fields_updated()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                        
	end
end