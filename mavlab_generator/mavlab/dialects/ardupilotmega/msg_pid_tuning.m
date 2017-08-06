classdef msg_pid_tuning < MAVLinkMessage
	%MSG_PID_TUNING: MAVLink Message ID = 194
    %Description:
    %    PID tuning information
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    desired(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,desired,achieved,FF,P,I,D,axis,varargin)

            if nargin == 7 + 1
                msg = msg_pid_tuning(desired,achieved,FF,P,I,D,axis,varargin);
            elseif nargin == 2
                msg = msg_pid_tuning(desired);
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

        function obj = msg_pid_tuning(desired,achieved,FF,P,I,D,axis,varargin)
        %MSG_PID_TUNING: Create a new pid_tuning message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(desired,'MAVLinkPacket')
                    packet = desired;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('desired','MAVLinkPacket');
                end
            elseif nargin >= 7 && isempty(varargin{1})
                obj.desired = desired;
                obj.achieved = achieved;
                obj.FF = FF;
                obj.P = P;
                obj.I = I;
                obj.D = D;
                obj.axis = axis;
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

                packet = MAVLinkPacket(msg_pid_tuning.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
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
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end