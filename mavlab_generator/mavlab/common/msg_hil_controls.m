classdef msg_hil_controls < mavlink_message
	%MSG_HIL_CONTROLS: MAVLINK Message ID = 91
    %Description:
    %    Sent from autopilot to simulation. Hardware in the loop control outputs
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
    %    time_usec(uint64): Timestamp (microseconds since UNIX epoch or microseconds since system boot)
    %    roll_ailerons(single): Control output -1 .. 1
    %    pitch_elevator(single): Control output -1 .. 1
    %    yaw_rudder(single): Control output -1 .. 1
    %    throttle(single): Throttle 0 .. 1
    %    aux1(single): Aux 1, -1 .. 1
    %    aux2(single): Aux 2, -1 .. 1
    %    aux3(single): Aux 3, -1 .. 1
    %    aux4(single): Aux 4, -1 .. 1
    %    mode(uint8): System mode (MAV_MODE)
    %    nav_mode(uint8): Navigation mode (MAV_NAV_MODE)
	
	properties(Constant)
		ID = 91
		LEN = 42
	end
	
	properties
        time_usec	%Timestamp (microseconds since UNIX epoch or microseconds since system boot)	|	(uint64)
        roll_ailerons	%Control output -1 .. 1	|	(single)
        pitch_elevator	%Control output -1 .. 1	|	(single)
        yaw_rudder	%Control output -1 .. 1	|	(single)
        throttle	%Throttle 0 .. 1	|	(single)
        aux1	%Aux 1, -1 .. 1	|	(single)
        aux2	%Aux 2, -1 .. 1	|	(single)
        aux3	%Aux 3, -1 .. 1	|	(single)
        aux4	%Aux 4, -1 .. 1	|	(single)
        mode	%System mode (MAV_MODE)	|	(uint8)
        nav_mode	%Navigation mode (MAV_NAV_MODE)	|	(uint8)
    end

    methods

        function obj = msg_hil_controls(packet,time_usec,roll_ailerons,pitch_elevator,yaw_rudder,throttle,aux1,aux2,aux3,aux4,mode,nav_mode)
        %Create a new hil_controls message
        
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
            
            elseif nargin-1 == 11
                obj.time_usec = time_usec;
                obj.roll_ailerons = roll_ailerons;
                obj.pitch_elevator = pitch_elevator;
                obj.yaw_rudder = yaw_rudder;
                obj.throttle = throttle;
                obj.aux1 = aux1;
                obj.aux2 = aux2;
                obj.aux3 = aux3;
                obj.aux4 = aux4;
                obj.mode = mode;
                obj.nav_mode = nav_mode;
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

                packet = mavlink_packet(msg_hil_controls.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_hil_controls.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                packet.payload.putSINGLE(obj.roll_ailerons);
                packet.payload.putSINGLE(obj.pitch_elevator);
                packet.payload.putSINGLE(obj.yaw_rudder);
                packet.payload.putSINGLE(obj.throttle);
                packet.payload.putSINGLE(obj.aux1);
                packet.payload.putSINGLE(obj.aux2);
                packet.payload.putSINGLE(obj.aux3);
                packet.payload.putSINGLE(obj.aux4);
                packet.payload.putUINT8(obj.mode);
                packet.payload.putUINT8(obj.nav_mode);

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
            obj.roll_ailerons = payload.getSINGLE();
            obj.pitch_elevator = payload.getSINGLE();
            obj.yaw_rudder = payload.getSINGLE();
            obj.throttle = payload.getSINGLE();
            obj.aux1 = payload.getSINGLE();
            obj.aux2 = payload.getSINGLE();
            obj.aux3 = payload.getSINGLE();
            obj.aux4 = payload.getSINGLE();
            obj.mode = payload.getUINT8();
            obj.nav_mode = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.roll_ailerons,2) ~= 1
                result = 'roll_ailerons';
            elseif size(obj.pitch_elevator,2) ~= 1
                result = 'pitch_elevator';
            elseif size(obj.yaw_rudder,2) ~= 1
                result = 'yaw_rudder';
            elseif size(obj.throttle,2) ~= 1
                result = 'throttle';
            elseif size(obj.aux1,2) ~= 1
                result = 'aux1';
            elseif size(obj.aux2,2) ~= 1
                result = 'aux2';
            elseif size(obj.aux3,2) ~= 1
                result = 'aux3';
            elseif size(obj.aux4,2) ~= 1
                result = 'aux4';
            elseif size(obj.mode,2) ~= 1
                result = 'mode';
            elseif size(obj.nav_mode,2) ~= 1
                result = 'nav_mode';

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
        
        function set.roll_ailerons(obj,value)
            obj.roll_ailerons = single(value);
        end
        
        function set.pitch_elevator(obj,value)
            obj.pitch_elevator = single(value);
        end
        
        function set.yaw_rudder(obj,value)
            obj.yaw_rudder = single(value);
        end
        
        function set.throttle(obj,value)
            obj.throttle = single(value);
        end
        
        function set.aux1(obj,value)
            obj.aux1 = single(value);
        end
        
        function set.aux2(obj,value)
            obj.aux2 = single(value);
        end
        
        function set.aux3(obj,value)
            obj.aux3 = single(value);
        end
        
        function set.aux4(obj,value)
            obj.aux4 = single(value);
        end
        
        function set.mode(obj,value)
            if value == uint8(value)
                obj.mode = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.nav_mode(obj,value)
            if value == uint8(value)
                obj.nav_mode = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end