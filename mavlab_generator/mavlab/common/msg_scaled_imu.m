classdef msg_scaled_imu < mavlink_message
	%MSG_SCALED_IMU: MAVLINK Message ID = 26
    %Description:
    %    The RAW IMU readings for the usual 9DOF sensor setup. This message should contain the scaled values to the described units
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    time_boot_ms(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    time_boot_ms(uint32): Timestamp (milliseconds since system boot)
    %    xacc(int16): X acceleration (mg)
    %    yacc(int16): Y acceleration (mg)
    %    zacc(int16): Z acceleration (mg)
    %    xgyro(int16): Angular speed around X axis (millirad /sec)
    %    ygyro(int16): Angular speed around Y axis (millirad /sec)
    %    zgyro(int16): Angular speed around Z axis (millirad /sec)
    %    xmag(int16): X Magnetic field (milli tesla)
    %    ymag(int16): Y Magnetic field (milli tesla)
    %    zmag(int16): Z Magnetic field (milli tesla)
	
	properties(Constant)
		ID = 26
		LEN = 22
	end
	
	properties
        time_boot_ms	%Timestamp (milliseconds since system boot)	|	(uint32)
        xacc	%X acceleration (mg)	|	(int16)
        yacc	%Y acceleration (mg)	|	(int16)
        zacc	%Z acceleration (mg)	|	(int16)
        xgyro	%Angular speed around X axis (millirad /sec)	|	(int16)
        ygyro	%Angular speed around Y axis (millirad /sec)	|	(int16)
        zgyro	%Angular speed around Z axis (millirad /sec)	|	(int16)
        xmag	%X Magnetic field (milli tesla)	|	(int16)
        ymag	%Y Magnetic field (milli tesla)	|	(int16)
        zmag	%Z Magnetic field (milli tesla)	|	(int16)
    end

    methods

        function obj = msg_scaled_imu(time_boot_ms,xacc,yacc,zacc,xgyro,ygyro,zgyro,xmag,ymag,zmag,varargin)
        %Create a new scaled_imu message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(time_boot_ms,'mavlink_packet')
                    packet = time_boot_ms;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('time_boot_ms','mavlink_packet');
                end
            
            elseif nargin == 10
                obj.time_boot_ms = time_boot_ms;
                obj.xacc = xacc;
                obj.yacc = yacc;
                obj.zacc = zacc;
                obj.xgyro = xgyro;
                obj.ygyro = ygyro;
                obj.zgyro = zgyro;
                obj.xmag = xmag;
                obj.ymag = ymag;
                obj.zmag = zmag;
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

                packet = mavlink_packet(msg_scaled_imu.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_scaled_imu.ID;
                
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
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';
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

            else
                result = 0;
            end
        end

        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
        
        function set.xacc(obj,value)
            if value == int16(value)
                obj.xacc = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.yacc(obj,value)
            if value == int16(value)
                obj.yacc = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.zacc(obj,value)
            if value == int16(value)
                obj.zacc = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.xgyro(obj,value)
            if value == int16(value)
                obj.xgyro = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.ygyro(obj,value)
            if value == int16(value)
                obj.ygyro = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.zgyro(obj,value)
            if value == int16(value)
                obj.zgyro = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.xmag(obj,value)
            if value == int16(value)
                obj.xmag = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.ymag(obj,value)
            if value == int16(value)
                obj.ymag = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.zmag(obj,value)
            if value == int16(value)
                obj.zmag = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
    end

end