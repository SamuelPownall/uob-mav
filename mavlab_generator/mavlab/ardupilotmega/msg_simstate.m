classdef msg_simstate < mavlink_message
	%MSG_SIMSTATE: MAVLINK Message ID = 164
    %Description:
    %    Status of simulation environment, if used
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    roll(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    roll(single): Roll angle (rad)
    %    pitch(single): Pitch angle (rad)
    %    yaw(single): Yaw angle (rad)
    %    xacc(single): X acceleration m/s/s
    %    yacc(single): Y acceleration m/s/s
    %    zacc(single): Z acceleration m/s/s
    %    xgyro(single): Angular speed around X axis rad/s
    %    ygyro(single): Angular speed around Y axis rad/s
    %    zgyro(single): Angular speed around Z axis rad/s
    %    lat(int32): Latitude in degrees * 1E7
    %    lng(int32): Longitude in degrees * 1E7
	
	properties(Constant)
		ID = 164
		LEN = 44
	end
	
	properties
        roll	%Roll angle (rad)	|	(single)
        pitch	%Pitch angle (rad)	|	(single)
        yaw	%Yaw angle (rad)	|	(single)
        xacc	%X acceleration m/s/s	|	(single)
        yacc	%Y acceleration m/s/s	|	(single)
        zacc	%Z acceleration m/s/s	|	(single)
        xgyro	%Angular speed around X axis rad/s	|	(single)
        ygyro	%Angular speed around Y axis rad/s	|	(single)
        zgyro	%Angular speed around Z axis rad/s	|	(single)
        lat	%Latitude in degrees * 1E7	|	(int32)
        lng	%Longitude in degrees * 1E7	|	(int32)
    end

    methods

        function obj = msg_simstate(roll,pitch,yaw,xacc,yacc,zacc,xgyro,ygyro,zgyro,lat,lng,varargin)
        %MSG_SIMSTATE: Create a new simstate message object
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1 
                if isa(roll,'mavlink_packet')
                    packet = roll;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('roll','mavlink_packet');
                end
            elseif nargin == 11
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
                obj.lng = lng;
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

                packet = mavlink_packet(msg_simstate.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_simstate.ID;
                
                packet.payload.putSINGLE(obj.roll);
                packet.payload.putSINGLE(obj.pitch);
                packet.payload.putSINGLE(obj.yaw);
                packet.payload.putSINGLE(obj.xacc);
                packet.payload.putSINGLE(obj.yacc);
                packet.payload.putSINGLE(obj.zacc);
                packet.payload.putSINGLE(obj.xgyro);
                packet.payload.putSINGLE(obj.ygyro);
                packet.payload.putSINGLE(obj.zgyro);
                packet.payload.putINT32(obj.lat);
                packet.payload.putINT32(obj.lng);

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
            
            obj.roll = payload.getSINGLE();
            obj.pitch = payload.getSINGLE();
            obj.yaw = payload.getSINGLE();
            obj.xacc = payload.getSINGLE();
            obj.yacc = payload.getSINGLE();
            obj.zacc = payload.getSINGLE();
            obj.xgyro = payload.getSINGLE();
            obj.ygyro = payload.getSINGLE();
            obj.zgyro = payload.getSINGLE();
            obj.lat = payload.getINT32();
            obj.lng = payload.getINT32();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
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
            elseif size(obj.lng,2) ~= 1
                result = 'lng';

            else
                result = 0;
            end
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
            if value == int32(value)
                obj.lat = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
        
        function set.lng(obj,value)
            if value == int32(value)
                obj.lng = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
        
    end

end