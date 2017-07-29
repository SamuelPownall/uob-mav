classdef msg_pid_tuning < mavlink_message
	%MSG_PID_TUNING: MAVLINK Message ID = 194
    %Description:
    %    PID tuning information
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
    %    desired(single): desired rate (degrees/s)
    %    achieved(single): achieved rate (degrees/s)
    %    FF(single): FF component
    %    P(single): P component
    %    I(single): I component
    %    D(single): D component
    %    axis(uint8): axis
	
	properties(Constant)
		ID = 194
		LEN = 25
	end
	
	properties
        desired	%desired rate (degrees/s)	|	(single)
        achieved	%achieved rate (degrees/s)	|	(single)
        FF	%FF component	|	(single)
        P	%P component	|	(single)
        I	%I component	|	(single)
        D	%D component	|	(single)
        axis	%axis	|	(uint8)
    end

    methods

        function obj = msg_pid_tuning(packet,desired,achieved,FF,P,I,D,axis)
        %Create a new pid_tuning message
        
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
            
            elseif nargin-1 == 7
                obj.desired = desired;
                obj.achieved = achieved;
                obj.FF = FF;
                obj.P = P;
                obj.I = I;
                obj.D = D;
                obj.axis = axis;
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

                packet = mavlink_packet(msg_pid_tuning.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_pid_tuning.ID;
                
                packet.payload.putSINGLE(obj.desired);
                packet.payload.putSINGLE(obj.achieved);
                packet.payload.putSINGLE(obj.FF);
                packet.payload.putSINGLE(obj.P);
                packet.payload.putSINGLE(obj.I);
                packet.payload.putSINGLE(obj.D);
                packet.payload.putUINT8(obj.axis);

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
            
            obj.desired = payload.getSINGLE();
            obj.achieved = payload.getSINGLE();
            obj.FF = payload.getSINGLE();
            obj.P = payload.getSINGLE();
            obj.I = payload.getSINGLE();
            obj.D = payload.getSINGLE();
            obj.axis = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.desired,2) ~= 1
                result = 'desired';
            elseif size(obj.achieved,2) ~= 1
                result = 'achieved';
            elseif size(obj.FF,2) ~= 1
                result = 'FF';
            elseif size(obj.P,2) ~= 1
                result = 'P';
            elseif size(obj.I,2) ~= 1
                result = 'I';
            elseif size(obj.D,2) ~= 1
                result = 'D';
            elseif size(obj.axis,2) ~= 1
                result = 'axis';

            else
                result = 0;
            end
        end

        function set.desired(obj,value)
            obj.desired = single(value);
        end
        
        function set.achieved(obj,value)
            obj.achieved = single(value);
        end
        
        function set.FF(obj,value)
            obj.FF = single(value);
        end
        
        function set.P(obj,value)
            obj.P = single(value);
        end
        
        function set.I(obj,value)
            obj.I = single(value);
        end
        
        function set.D(obj,value)
            obj.D = single(value);
        end
        
        function set.axis(obj,value)
            if value == uint8(value)
                obj.axis = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end