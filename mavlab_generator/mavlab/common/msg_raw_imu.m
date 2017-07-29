classdef msg_raw_imu < mavlink_handle
	%MSG_RAW_IMU(packet,time_usec,xacc,yacc,zacc,xgyro,ygyro,zgyro,xmag,ymag,zmag): MAVLINK Message ID = 27
    %Description:
    %    The RAW IMU readings for the usual 9DOF sensor setup. This message should always contain the true raw values without any scaling to allow data capture and system debugging.
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    time_usec(uint64): Timestamp (microseconds since UNIX epoch or microseconds since system boot)
    %    xacc(int16): X acceleration (raw)
    %    yacc(int16): Y acceleration (raw)
    %    zacc(int16): Z acceleration (raw)
    %    xgyro(int16): Angular speed around X axis (raw)
    %    ygyro(int16): Angular speed around Y axis (raw)
    %    zgyro(int16): Angular speed around Z axis (raw)
    %    xmag(int16): X Magnetic field (raw)
    %    ymag(int16): Y Magnetic field (raw)
    %    zmag(int16): Z Magnetic field (raw)
	
	properties(Constant)
		ID = 27
		LEN = 26
	end
	
	properties
        time_usec	%Timestamp (microseconds since UNIX epoch or microseconds since system boot)	|	(uint64)
        xacc	%X acceleration (raw)	|	(int16)
        yacc	%Y acceleration (raw)	|	(int16)
        zacc	%Z acceleration (raw)	|	(int16)
        xgyro	%Angular speed around X axis (raw)	|	(int16)
        ygyro	%Angular speed around Y axis (raw)	|	(int16)
        zgyro	%Angular speed around Z axis (raw)	|	(int16)
        xmag	%X Magnetic field (raw)	|	(int16)
        ymag	%Y Magnetic field (raw)	|	(int16)
        zmag	%Z Magnetic field (raw)	|	(int16)
    end

    methods

        %Constructor: msg_raw_imu
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_raw_imu(packet,time_usec,xacc,yacc,zacc,xgyro,ygyro,zgyro,xmag,ymag,zmag)
        
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
            
            elseif nargin-1 == 10
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
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

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

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
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
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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