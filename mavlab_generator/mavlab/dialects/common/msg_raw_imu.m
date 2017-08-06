classdef msg_raw_imu < MAVLinkMessage
	%MSG_RAW_IMU: MAVLink Message ID = 27
    %Description:
    %    The RAW IMU readings for the usual 9DOF sensor setup. This message should always contain the true raw values without any scaling to allow data capture and system debugging.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_usec(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,time_usec,xacc,yacc,zacc,xgyro,ygyro,zgyro,xmag,ymag,zmag,varargin)

            if nargin == 10 + 1
                msg = msg_raw_imu(time_usec,xacc,yacc,zacc,xgyro,ygyro,zgyro,xmag,ymag,zmag,varargin);
            elseif nargin == 2
                msg = msg_raw_imu(time_usec);
            else
                MAVLink.throwCustomError('The number of function arguments is not valid');
                return;
            end

            packet = msg.pack();
            if ~isempty(packet)
                buffer = packet.encode();
                write(out,buffer);
            else
                MAVLink.throwCustomError('The packet could not be verified');
            end
        
        end

    end

    methods

        function obj = msg_raw_imu(time_usec,xacc,yacc,zacc,xgyro,ygyro,zgyro,xmag,ymag,zmag,varargin)
        %MSG_RAW_IMU: Create a new raw_imu message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(time_usec,'MAVLinkPacket')
                    packet = time_usec;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('time_usec','MAVLinkPacket');
                end
            elseif nargin >= 10 && isempty(varargin{1})
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
                MAVLink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        function packet = pack(obj)
        %PACK: Packs this MAVLink message into a MAVLinkPacket
        %Description:
        %    Packs the fields of a message into a MAVLinkPacket which can be encoded
        %    for transmission.

            errorField = obj.verify();
            if errorField == 0

                packet = MAVLinkPacket(msg_raw_imu.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
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
                MAVLink.throwPackingError(errorField);
            end

        end

        function unpack(obj, payload)
        %UNPACK: Unpacks a MAVLinkPayload into this MAVLink message
        %Description:
        %    Extracts the data from a MAVLinkPayload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(MAVLinkPayload): The payload to be unpacked into this MAVLink message

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

            else
                result = 0;
            end
        end

        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                MAVLink.throwTypeError('value','uint64');
            end
        end
        
        function set.xacc(obj,value)
            if value == int16(value)
                obj.xacc = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.yacc(obj,value)
            if value == int16(value)
                obj.yacc = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.zacc(obj,value)
            if value == int16(value)
                obj.zacc = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.xgyro(obj,value)
            if value == int16(value)
                obj.xgyro = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.ygyro(obj,value)
            if value == int16(value)
                obj.ygyro = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.zgyro(obj,value)
            if value == int16(value)
                obj.zgyro = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.xmag(obj,value)
            if value == int16(value)
                obj.xmag = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.ymag(obj,value)
            if value == int16(value)
                obj.ymag = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
        function set.zmag(obj,value)
            if value == int16(value)
                obj.zmag = int16(value);
            else
                MAVLink.throwTypeError('value','int16');
            end
        end
        
    end

end