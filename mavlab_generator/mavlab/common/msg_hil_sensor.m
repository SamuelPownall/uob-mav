classdef msg_hil_sensor < mavlink_message
    %MAVLINK Message Class
    %Name: hil_sensor	ID: 107
    %Description: The IMU readings in SI units in NED body frame
            
    properties(Constant)
        ID = 107
        LEN = 64
    end
    
    properties        
		time_usec	%Timestamp (microseconds, synced to UNIX time or since system boot) (uint64)
		fields_updated	%Bitmask for fields that have updated since last message, bit 0 = xacc, bit 12: temperature, bit 31: full reset of attitude/position/velocities/etc was performed in sim. (uint32)
		xacc	%X acceleration (m/s^2) (single)
		yacc	%Y acceleration (m/s^2) (single)
		zacc	%Z acceleration (m/s^2) (single)
		xgyro	%Angular speed around X axis in body frame (rad / sec) (single)
		ygyro	%Angular speed around Y axis in body frame (rad / sec) (single)
		zgyro	%Angular speed around Z axis in body frame (rad / sec) (single)
		xmag	%X Magnetic field (Gauss) (single)
		ymag	%Y Magnetic field (Gauss) (single)
		zmag	%Z Magnetic field (Gauss) (single)
		abs_pressure	%Absolute pressure in millibar (single)
		diff_pressure	%Differential pressure (airspeed) in millibar (single)
		pressure_alt	%Altitude calculated from pressure (single)
		temperature	%Temperature in degrees celsius (single)
	end
    
    methods
        
        %Constructor: msg_hil_sensor
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_hil_sensor(packet,time_usec,fields_updated,xacc,yacc,zacc,xgyro,ygyro,zgyro,xmag,ymag,zmag,abs_pressure,diff_pressure,pressure_alt,temperature)
        
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
                
            elseif nargin == 16
                
				obj.time_usec = time_usec;
				obj.fields_updated = fields_updated;
				obj.xacc = xacc;
				obj.yacc = yacc;
				obj.zacc = zacc;
				obj.xgyro = xgyro;
				obj.ygyro = ygyro;
				obj.zgyro = zgyro;
				obj.xmag = xmag;
				obj.ymag = ymag;
				obj.zmag = zmag;
				obj.abs_pressure = abs_pressure;
				obj.diff_pressure = diff_pressure;
				obj.pressure_alt = pressure_alt;
				obj.temperature = temperature;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_hil_sensor.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_hil_sensor.ID;
                
				packet.payload.putUINT64(obj.time_usec);

				packet.payload.putUINT32(obj.fields_updated);

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
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();

			obj.fields_updated = payload.getUINT32();

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

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_usec,2) ~= 1
                result = 'time_usec';                                        
            elseif size(obj.fields_updated,2) ~= 1
                result = 'fields_updated';                                        
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
            else
                result = 0;
            end
            
        end
                                
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                mavlink.throwTypeError('value','uint64');
            end
        end
                                    
        function set.fields_updated(obj,value)
            if value == uint32(value)
                obj.fields_updated = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
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
                        
	end
end