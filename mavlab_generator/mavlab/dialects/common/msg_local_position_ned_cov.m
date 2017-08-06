classdef msg_local_position_ned_cov < MAVLinkMessage
	%MSG_LOCAL_POSITION_NED_COV: MAVLink Message ID = 64
    %Description:
    %    The filtered local position (e.g. fused computer vision and accelerometers). Coordinate frame is right-handed, Z-axis down (aeronautical frame, NED / north-east-down convention)
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_usec(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    time_usec(uint64): Timestamp (microseconds since system boot or since UNIX epoch)
    %    x(single): X Position
    %    y(single): Y Position
    %    z(single): Z Position
    %    vx(single): X Speed (m/s)
    %    vy(single): Y Speed (m/s)
    %    vz(single): Z Speed (m/s)
    %    ax(single): X Acceleration (m/s^2)
    %    ay(single): Y Acceleration (m/s^2)
    %    az(single): Z Acceleration (m/s^2)
    %    covariance(single[45]): Covariance matrix upper right triangular (first nine entries are the first ROW, next eight entries are the second row, etc.)
    %    estimator_type(uint8): Class id of the estimator this estimate originated from.
	
	properties(Constant)
		ID = 64
		LEN = 127
	end
	
	properties
        time_usec	%Timestamp (microseconds since system boot or since UNIX epoch)	|	(uint64)
        x	%X Position	|	(single)
        y	%Y Position	|	(single)
        z	%Z Position	|	(single)
        vx	%X Speed (m/s)	|	(single)
        vy	%Y Speed (m/s)	|	(single)
        vz	%Z Speed (m/s)	|	(single)
        ax	%X Acceleration (m/s^2)	|	(single)
        ay	%Y Acceleration (m/s^2)	|	(single)
        az	%Z Acceleration (m/s^2)	|	(single)
        covariance	%Covariance matrix upper right triangular (first nine entries are the first ROW, next eight entries are the second row, etc.)	|	(single[45])
        estimator_type	%Class id of the estimator this estimate originated from.	|	(uint8)
    end

    methods(Static)

        function send(out,time_usec,x,y,z,vx,vy,vz,ax,ay,az,covariance,estimator_type,varargin)

            if nargin == 12 + 1
                msg = msg_local_position_ned_cov(time_usec,x,y,z,vx,vy,vz,ax,ay,az,covariance,estimator_type,varargin);
            elseif nargin == 2
                msg = msg_local_position_ned_cov(time_usec);
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

        function obj = msg_local_position_ned_cov(time_usec,x,y,z,vx,vy,vz,ax,ay,az,covariance,estimator_type,varargin)
        %MSG_LOCAL_POSITION_NED_COV: Create a new local_position_ned_cov message object
        
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
            elseif nargin >= 12 && isempty(varargin{1})
                obj.time_usec = time_usec;
                obj.x = x;
                obj.y = y;
                obj.z = z;
                obj.vx = vx;
                obj.vy = vy;
                obj.vz = vz;
                obj.ax = ax;
                obj.ay = ay;
                obj.az = az;
                obj.covariance = covariance;
                obj.estimator_type = estimator_type;
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

                packet = MAVLinkPacket(msg_local_position_ned_cov.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_local_position_ned_cov.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                packet.payload.putSINGLE(obj.x);
                packet.payload.putSINGLE(obj.y);
                packet.payload.putSINGLE(obj.z);
                packet.payload.putSINGLE(obj.vx);
                packet.payload.putSINGLE(obj.vy);
                packet.payload.putSINGLE(obj.vz);
                packet.payload.putSINGLE(obj.ax);
                packet.payload.putSINGLE(obj.ay);
                packet.payload.putSINGLE(obj.az);
                for i=1:1:45
                    packet.payload.putSINGLE(obj.covariance(i));
                end
                packet.payload.putUINT8(obj.estimator_type);

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
            obj.x = payload.getSINGLE();
            obj.y = payload.getSINGLE();
            obj.z = payload.getSINGLE();
            obj.vx = payload.getSINGLE();
            obj.vy = payload.getSINGLE();
            obj.vz = payload.getSINGLE();
            obj.ax = payload.getSINGLE();
            obj.ay = payload.getSINGLE();
            obj.az = payload.getSINGLE();
            for i=1:1:45
                obj.covariance(i) = payload.getSINGLE();
            end
            obj.estimator_type = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.x,2) ~= 1
                result = 'x';
            elseif size(obj.y,2) ~= 1
                result = 'y';
            elseif size(obj.z,2) ~= 1
                result = 'z';
            elseif size(obj.vx,2) ~= 1
                result = 'vx';
            elseif size(obj.vy,2) ~= 1
                result = 'vy';
            elseif size(obj.vz,2) ~= 1
                result = 'vz';
            elseif size(obj.ax,2) ~= 1
                result = 'ax';
            elseif size(obj.ay,2) ~= 1
                result = 'ay';
            elseif size(obj.az,2) ~= 1
                result = 'az';
            elseif size(obj.covariance,2) ~= 45
                result = 'covariance';
            elseif size(obj.estimator_type,2) ~= 1
                result = 'estimator_type';

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
        
        function set.x(obj,value)
            obj.x = single(value);
        end
        
        function set.y(obj,value)
            obj.y = single(value);
        end
        
        function set.z(obj,value)
            obj.z = single(value);
        end
        
        function set.vx(obj,value)
            obj.vx = single(value);
        end
        
        function set.vy(obj,value)
            obj.vy = single(value);
        end
        
        function set.vz(obj,value)
            obj.vz = single(value);
        end
        
        function set.ax(obj,value)
            obj.ax = single(value);
        end
        
        function set.ay(obj,value)
            obj.ay = single(value);
        end
        
        function set.az(obj,value)
            obj.az = single(value);
        end
        
        function set.covariance(obj,value)
            obj.covariance = single(value);
        end
        
        function set.estimator_type(obj,value)
            if value == uint8(value)
                obj.estimator_type = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end