classdef msg_pid_tuning < mavlink_handle
	%MSG_PID_TUNING(packet,desired,achieved,FF,P,I,D,axis): MAVLINK Message ID = 194
    %Description:
    %    PID tuning information
    %    If constructing from fields, packet argument should be set to []
	%Fields:
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

        %Constructor: msg_pid_tuning
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_pid_tuning(packet,desired,achieved,FF,P,I,D,axis)
        
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

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

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

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.desired = payload.getSINGLE();
            obj.achieved = payload.getSINGLE();
            obj.FF = payload.getSINGLE();
            obj.P = payload.getSINGLE();
            obj.I = payload.getSINGLE();
            obj.D = payload.getSINGLE();
            obj.axis = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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