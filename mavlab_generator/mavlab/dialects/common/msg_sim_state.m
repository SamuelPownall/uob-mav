classdef msg_sim_state < MAVLinkMessage
	%MSG_SIM_STATE: MAVLink Message ID = 108
    %Description:
    %    Status of simulation environment, if used
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    q1(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    q1(single): True attitude quaternion component 1, w (1 in null-rotation)
    %    q2(single): True attitude quaternion component 2, x (0 in null-rotation)
    %    q3(single): True attitude quaternion component 3, y (0 in null-rotation)
    %    q4(single): True attitude quaternion component 4, z (0 in null-rotation)
    %    roll(single): Attitude roll expressed as Euler angles, not recommended except for human-readable outputs
    %    pitch(single): Attitude pitch expressed as Euler angles, not recommended except for human-readable outputs
    %    yaw(single): Attitude yaw expressed as Euler angles, not recommended except for human-readable outputs
    %    xacc(single): X acceleration m/s/s
    %    yacc(single): Y acceleration m/s/s
    %    zacc(single): Z acceleration m/s/s
    %    xgyro(single): Angular speed around X axis rad/s
    %    ygyro(single): Angular speed around Y axis rad/s
    %    zgyro(single): Angular speed around Z axis rad/s
    %    lat(single): Latitude in degrees
    %    lon(single): Longitude in degrees
    %    alt(single): Altitude in meters
    %    std_dev_horz(single): Horizontal position standard deviation
    %    std_dev_vert(single): Vertical position standard deviation
    %    vn(single): True velocity in m/s in NORTH direction in earth-fixed NED frame
    %    ve(single): True velocity in m/s in EAST direction in earth-fixed NED frame
    %    vd(single): True velocity in m/s in DOWN direction in earth-fixed NED frame
	
	properties(Constant)
		ID = 108
		LEN = 84
	end
	
	properties
        q1	%True attitude quaternion component 1, w (1 in null-rotation)	|	(single)
        q2	%True attitude quaternion component 2, x (0 in null-rotation)	|	(single)
        q3	%True attitude quaternion component 3, y (0 in null-rotation)	|	(single)
        q4	%True attitude quaternion component 4, z (0 in null-rotation)	|	(single)
        roll	%Attitude roll expressed as Euler angles, not recommended except for human-readable outputs	|	(single)
        pitch	%Attitude pitch expressed as Euler angles, not recommended except for human-readable outputs	|	(single)
        yaw	%Attitude yaw expressed as Euler angles, not recommended except for human-readable outputs	|	(single)
        xacc	%X acceleration m/s/s	|	(single)
        yacc	%Y acceleration m/s/s	|	(single)
        zacc	%Z acceleration m/s/s	|	(single)
        xgyro	%Angular speed around X axis rad/s	|	(single)
        ygyro	%Angular speed around Y axis rad/s	|	(single)
        zgyro	%Angular speed around Z axis rad/s	|	(single)
        lat	%Latitude in degrees	|	(single)
        lon	%Longitude in degrees	|	(single)
        alt	%Altitude in meters	|	(single)
        std_dev_horz	%Horizontal position standard deviation	|	(single)
        std_dev_vert	%Vertical position standard deviation	|	(single)
        vn	%True velocity in m/s in NORTH direction in earth-fixed NED frame	|	(single)
        ve	%True velocity in m/s in EAST direction in earth-fixed NED frame	|	(single)
        vd	%True velocity in m/s in DOWN direction in earth-fixed NED frame	|	(single)
    end

    methods(Static)

        function send(out,q1,q2,q3,q4,roll,pitch,yaw,xacc,yacc,zacc,xgyro,ygyro,zgyro,lat,lon,alt,std_dev_horz,std_dev_vert,vn,ve,vd,varargin)

            if nargin == 21 + 1
                msg = msg_sim_state(q1,q2,q3,q4,roll,pitch,yaw,xacc,yacc,zacc,xgyro,ygyro,zgyro,lat,lon,alt,std_dev_horz,std_dev_vert,vn,ve,vd,varargin);
            elseif nargin == 2
                msg = msg_sim_state(q1);
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

        function obj = msg_sim_state(q1,q2,q3,q4,roll,pitch,yaw,xacc,yacc,zacc,xgyro,ygyro,zgyro,lat,lon,alt,std_dev_horz,std_dev_vert,vn,ve,vd,varargin)
        %MSG_SIM_STATE: Create a new sim_state message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(q1,'MAVLinkPacket')
                    packet = q1;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('q1','MAVLinkPacket');
                end
            elseif nargin >= 21 && isempty(varargin{1})
                obj.q1 = q1;
                obj.q2 = q2;
                obj.q3 = q3;
                obj.q4 = q4;
                obj.roll = roll;
                obj.pitch = pitch;
                obj.yaw = yaw;
                obj.xacc = xacc;
                obj.yacc = yacc;
                obj.zacc = zacc;
                obj.xgyro = xgyro;
                obj.ygyro = ygyro;
                obj.zgyro = zgyro;
                obj.lat = lat;
                obj.lon = lon;
                obj.alt = alt;
                obj.std_dev_horz = std_dev_horz;
                obj.std_dev_vert = std_dev_vert;
                obj.vn = vn;
                obj.ve = ve;
                obj.vd = vd;
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

                packet = MAVLinkPacket(msg_sim_state.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_sim_state.ID;
                
                packet.payload.putSINGLE(obj.q1);
                packet.payload.putSINGLE(obj.q2);
                packet.payload.putSINGLE(obj.q3);
                packet.payload.putSINGLE(obj.q4);
                packet.payload.putSINGLE(obj.roll);
                packet.payload.putSINGLE(obj.pitch);
                packet.payload.putSINGLE(obj.yaw);
                packet.payload.putSINGLE(obj.xacc);
                packet.payload.putSINGLE(obj.yacc);
                packet.payload.putSINGLE(obj.zacc);
                packet.payload.putSINGLE(obj.xgyro);
                packet.payload.putSINGLE(obj.ygyro);
                packet.payload.putSINGLE(obj.zgyro);
                packet.payload.putSINGLE(obj.lat);
                packet.payload.putSINGLE(obj.lon);
                packet.payload.putSINGLE(obj.alt);
                packet.payload.putSINGLE(obj.std_dev_horz);
                packet.payload.putSINGLE(obj.std_dev_vert);
                packet.payload.putSINGLE(obj.vn);
                packet.payload.putSINGLE(obj.ve);
                packet.payload.putSINGLE(obj.vd);

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
            
            obj.q1 = payload.getSINGLE();
            obj.q2 = payload.getSINGLE();
            obj.q3 = payload.getSINGLE();
            obj.q4 = payload.getSINGLE();
            obj.roll = payload.getSINGLE();
            obj.pitch = payload.getSINGLE();
            obj.yaw = payload.getSINGLE();
            obj.xacc = payload.getSINGLE();
            obj.yacc = payload.getSINGLE();
            obj.zacc = payload.getSINGLE();
            obj.xgyro = payload.getSINGLE();
            obj.ygyro = payload.getSINGLE();
            obj.zgyro = payload.getSINGLE();
            obj.lat = payload.getSINGLE();
            obj.lon = payload.getSINGLE();
            obj.alt = payload.getSINGLE();
            obj.std_dev_horz = payload.getSINGLE();
            obj.std_dev_vert = payload.getSINGLE();
            obj.vn = payload.getSINGLE();
            obj.ve = payload.getSINGLE();
            obj.vd = payload.getSINGLE();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.q1,2) ~= 1
                result = 'q1';
            elseif size(obj.q2,2) ~= 1
                result = 'q2';
            elseif size(obj.q3,2) ~= 1
                result = 'q3';
            elseif size(obj.q4,2) ~= 1
                result = 'q4';
            elseif size(obj.roll,2) ~= 1
                result = 'roll';
            elseif size(obj.pitch,2) ~= 1
                result = 'pitch';
            elseif size(obj.yaw,2) ~= 1
                result = 'yaw';
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
            elseif size(obj.lat,2) ~= 1
                result = 'lat';
            elseif size(obj.lon,2) ~= 1
                result = 'lon';
            elseif size(obj.alt,2) ~= 1
                result = 'alt';
            elseif size(obj.std_dev_horz,2) ~= 1
                result = 'std_dev_horz';
            elseif size(obj.std_dev_vert,2) ~= 1
                result = 'std_dev_vert';
            elseif size(obj.vn,2) ~= 1
                result = 'vn';
            elseif size(obj.ve,2) ~= 1
                result = 've';
            elseif size(obj.vd,2) ~= 1
                result = 'vd';

            else
                result = 0;
            end
        end

        function set.q1(obj,value)
            obj.q1 = single(value);
        end
        
        function set.q2(obj,value)
            obj.q2 = single(value);
        end
        
        function set.q3(obj,value)
            obj.q3 = single(value);
        end
        
        function set.q4(obj,value)
            obj.q4 = single(value);
        end
        
        function set.roll(obj,value)
            obj.roll = single(value);
        end
        
        function set.pitch(obj,value)
            obj.pitch = single(value);
        end
        
        function set.yaw(obj,value)
            obj.yaw = single(value);
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
        
        function set.lat(obj,value)
            obj.lat = single(value);
        end
        
        function set.lon(obj,value)
            obj.lon = single(value);
        end
        
        function set.alt(obj,value)
            obj.alt = single(value);
        end
        
        function set.std_dev_horz(obj,value)
            obj.std_dev_horz = single(value);
        end
        
        function set.std_dev_vert(obj,value)
            obj.std_dev_vert = single(value);
        end
        
        function set.vn(obj,value)
            obj.vn = single(value);
        end
        
        function set.ve(obj,value)
            obj.ve = single(value);
        end
        
        function set.vd(obj,value)
            obj.vd = single(value);
        end
        
    end

end