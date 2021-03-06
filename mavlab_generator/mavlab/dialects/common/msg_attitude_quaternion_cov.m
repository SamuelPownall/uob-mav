classdef msg_attitude_quaternion_cov < MAVLinkMessage
	%MSG_ATTITUDE_QUATERNION_COV: MAVLink Message ID = 61
    %Description:
    %    The attitude in the aeronautical frame (right-handed, Z-down, X-front, Y-right), expressed as quaternion. Quaternion order is w, x, y, z and a zero rotation would be expressed as (1 0 0 0).
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_usec(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    time_usec(uint64): Timestamp (microseconds since system boot or since UNIX epoch)
    %    q(single[4]): Quaternion components, w, x, y, z (1 0 0 0 is the null-rotation)
    %    rollspeed(single): Roll angular speed (rad/s)
    %    pitchspeed(single): Pitch angular speed (rad/s)
    %    yawspeed(single): Yaw angular speed (rad/s)
    %    covariance(single[9]): Attitude covariance
	
	properties(Constant)
		ID = 61
		LEN = 72
	end
	
	properties
        time_usec	%Timestamp (microseconds since system boot or since UNIX epoch)	|	(uint64)
        q	%Quaternion components, w, x, y, z (1 0 0 0 is the null-rotation)	|	(single[4])
        rollspeed	%Roll angular speed (rad/s)	|	(single)
        pitchspeed	%Pitch angular speed (rad/s)	|	(single)
        yawspeed	%Yaw angular speed (rad/s)	|	(single)
        covariance	%Attitude covariance	|	(single[9])
    end

    methods(Static)

        function send(out,time_usec,q,rollspeed,pitchspeed,yawspeed,covariance,varargin)

            if nargin == 6 + 1
                msg = msg_attitude_quaternion_cov(time_usec,q,rollspeed,pitchspeed,yawspeed,covariance,varargin);
            elseif nargin == 2
                msg = msg_attitude_quaternion_cov(time_usec);
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

        function obj = msg_attitude_quaternion_cov(time_usec,q,rollspeed,pitchspeed,yawspeed,covariance,varargin)
        %MSG_ATTITUDE_QUATERNION_COV: Create a new attitude_quaternion_cov message object
        
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
            elseif nargin >= 6 && isempty(varargin{1})
                obj.time_usec = time_usec;
                obj.q = q;
                obj.rollspeed = rollspeed;
                obj.pitchspeed = pitchspeed;
                obj.yawspeed = yawspeed;
                obj.covariance = covariance;
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

                packet = MAVLinkPacket(msg_attitude_quaternion_cov.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_attitude_quaternion_cov.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                for i=1:1:4
                    packet.payload.putSINGLE(obj.q(i));
                end
                packet.payload.putSINGLE(obj.rollspeed);
                packet.payload.putSINGLE(obj.pitchspeed);
                packet.payload.putSINGLE(obj.yawspeed);
                for i=1:1:9
                    packet.payload.putSINGLE(obj.covariance(i));
                end

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
            for i=1:1:4
                obj.q(i) = payload.getSINGLE();
            end
            obj.rollspeed = payload.getSINGLE();
            obj.pitchspeed = payload.getSINGLE();
            obj.yawspeed = payload.getSINGLE();
            for i=1:1:9
                obj.covariance(i) = payload.getSINGLE();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.q,2) ~= 4
                result = 'q';
            elseif size(obj.rollspeed,2) ~= 1
                result = 'rollspeed';
            elseif size(obj.pitchspeed,2) ~= 1
                result = 'pitchspeed';
            elseif size(obj.yawspeed,2) ~= 1
                result = 'yawspeed';
            elseif size(obj.covariance,2) ~= 9
                result = 'covariance';

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
        
        function set.q(obj,value)
            obj.q = single(value);
        end
        
        function set.rollspeed(obj,value)
            obj.rollspeed = single(value);
        end
        
        function set.pitchspeed(obj,value)
            obj.pitchspeed = single(value);
        end
        
        function set.yawspeed(obj,value)
            obj.yawspeed = single(value);
        end
        
        function set.covariance(obj,value)
            obj.covariance = single(value);
        end
        
    end

end