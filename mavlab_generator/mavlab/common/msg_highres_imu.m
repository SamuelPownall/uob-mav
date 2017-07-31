classdef msg_highres_imu < mavlink_message
	%MSG_HIGHRES_IMU: MAVLINK Message ID = 105
    %Description:
    %    The IMU readings in SI units in NED body frame
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    time_usec(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    time_usec(uint64): Timestamp (microseconds, synced to UNIX time or since system boot)
    %    xacc(single): X acceleration (m/s^2)
    %    yacc(single): Y acceleration (m/s^2)
    %    zacc(single): Z acceleration (m/s^2)
    %    xgyro(single): Angular speed around X axis (rad / sec)
    %    ygyro(single): Angular speed around Y axis (rad / sec)
    %    zgyro(single): Angular speed around Z axis (rad / sec)
    %    xmag(single): X Magnetic field (Gauss)
    %    ymag(single): Y Magnetic field (Gauss)
    %    zmag(single): Z Magnetic field (Gauss)
    %    abs_pressure(single): Absolute pressure in millibar
    %    diff_pressure(single): Differential pressure in millibar
    %    pressure_alt(single): Altitude calculated from pressure
    %    temperature(single): Temperature in degrees celsius
    %    fields_updated(uint16): Bitmask for fields that have updated since last message, bit 0 = xacc, bit 12: temperature
	
	properties(Constant)
		ID = 105
		LEN = 62
	end
	
	properties
        time_usec	%Timestamp (microseconds, synced to UNIX time or since system boot)	|	(uint64)
        xacc	%X acceleration (m/s^2)	|	(single)
        yacc	%Y acceleration (m/s^2)	|	(single)
        zacc	%Z acceleration (m/s^2)	|	(single)
        xgyro	%Angular speed around X axis (rad / sec)	|	(single)
        ygyro	%Angular speed around Y axis (rad / sec)	|	(single)
        zgyro	%Angular speed around Z axis (rad / sec)	|	(single)
        xmag	%X Magnetic field (Gauss)	|	(single)
        ymag	%Y Magnetic field (Gauss)	|	(single)
        zmag	%Z Magnetic field (Gauss)	|	(single)
        abs_pressure	%Absolute pressure in millibar	|	(single)
        diff_pressure	%Differential pressure in millibar	|	(single)
        pressure_alt	%Altitude calculated from pressure	|	(single)
        temperature	%Temperature in degrees celsius	|	(single)
        fields_updated	%Bitmask for fields that have updated since last message, bit 0 = xacc, bit 12: temperature	|	(uint16)
    end

    methods

        function obj = msg_highres_imu(time_usec,xacc,yacc,zacc,xgyro,ygyro,zgyro,xmag,ymag,zmag,abs_pressure,diff_pressure,pressure_alt,temperature,fields_updated,varargin)
        %Create a new highres_imu message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(time_usec,'mavlink_packet')
                    packet = time_usec;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('time_usec','mavlink_packet');
                end
            
            elseif nargin == 15
                obj.time_usec = time_usec;
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
                obj.fields_updated = fields_updated;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        function packet = pack(obj)
        %PACK: Packs this MAVLINK message into a mavlink_packet
        %Description:
        %    Packs the fields of a message into a mavlink_packet which can be encoded
        %    for transmission.

            errorField = obj.verify();
            if errorField == 0

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
                mavlink.throwPackingError(errorField);
            end

        end

        function unpack(obj, payload)
        %UNPACK: Unpacks a mavlink_payload into this MAVLINK message
        %Description:
        %    Extracts the data from a mavlink_payload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(mavlink_payload): The payload to be unpacked into this MAVLINK message

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
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
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
                mavlink.throwTypeError('value','uint64');
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
                mavlink.throwTypeError('value','uint16');
            end
        end
        
    end

end