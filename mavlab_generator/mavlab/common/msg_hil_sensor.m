classdef msg_hil_sensor < mavlink_message
    %MAVLINK Message Class
    %Name: hil_sensor	ID: 107
    %Description: The IMU readings in SI units in NED body frame
            
    properties(Constant)
        ID = 107
        LEN = 64
    end
    
    properties        
		time_usec	%Timestamp (microseconds, synced to UNIX time or since system boot) (uint64[1])
		fields_updated	%Bitmask for fields that have updated since last message, bit 0 = xacc, bit 12: temperature, bit 31: full reset of attitude/position/velocities/etc was performed in sim. (uint32[1])
		xacc	%X acceleration (m/s^2) (single[1])
		yacc	%Y acceleration (m/s^2) (single[1])
		zacc	%Z acceleration (m/s^2) (single[1])
		xgyro	%Angular speed around X axis in body frame (rad / sec) (single[1])
		ygyro	%Angular speed around Y axis in body frame (rad / sec) (single[1])
		zgyro	%Angular speed around Z axis in body frame (rad / sec) (single[1])
		xmag	%X Magnetic field (Gauss) (single[1])
		ymag	%Y Magnetic field (Gauss) (single[1])
		zmag	%Z Magnetic field (Gauss) (single[1])
		abs_pressure	%Absolute pressure in millibar (single[1])
		diff_pressure	%Differential pressure (airspeed) in millibar (single[1])
		pressure_alt	%Altitude calculated from pressure (single[1])
		temperature	%Temperature in degrees celsius (single[1])
	end

    
    methods
        
        %Constructor: msg_hil_sensor
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_hil_sensor(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
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

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
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
            
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_sensor.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                    
        function set.fields_updated(obj,value)
            if value == uint32(value)
                obj.fields_updated = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_sensor.set.fields_updated()\n\t Input "value" is not of type "uint32"\n');
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