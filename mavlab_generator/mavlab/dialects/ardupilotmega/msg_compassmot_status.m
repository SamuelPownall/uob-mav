classdef msg_compassmot_status < MAVLinkMessage
	%MSG_COMPASSMOT_STATUS: MAVLink Message ID = 177
    %Description:
    %    Status of compassmot calibration
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    current(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    current(single): current (amps)
    %    CompensationX(single): Motor Compensation X
    %    CompensationY(single): Motor Compensation Y
    %    CompensationZ(single): Motor Compensation Z
    %    throttle(uint16): throttle (percent*10)
    %    interference(uint16): interference (percent)
	
	properties(Constant)
		ID = 177
		LEN = 20
	end
	
	properties
        current	%current (amps)	|	(single)
        CompensationX	%Motor Compensation X	|	(single)
        CompensationY	%Motor Compensation Y	|	(single)
        CompensationZ	%Motor Compensation Z	|	(single)
        throttle	%throttle (percent*10)	|	(uint16)
        interference	%interference (percent)	|	(uint16)
    end

    methods(Static)

        function send(out,current,CompensationX,CompensationY,CompensationZ,throttle,interference,varargin)

            if nargin == 6 + 1
                msg = msg_compassmot_status(current,CompensationX,CompensationY,CompensationZ,throttle,interference,varargin);
            elseif nargin == 2
                msg = msg_compassmot_status(current);
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

        function obj = msg_compassmot_status(current,CompensationX,CompensationY,CompensationZ,throttle,interference,varargin)
        %MSG_COMPASSMOT_STATUS: Create a new compassmot_status message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(current,'MAVLinkPacket')
                    packet = current;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('current','MAVLinkPacket');
                end
            elseif nargin >= 6 && isempty(varargin{1})
                obj.current = current;
                obj.CompensationX = CompensationX;
                obj.CompensationY = CompensationY;
                obj.CompensationZ = CompensationZ;
                obj.throttle = throttle;
                obj.interference = interference;
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

                packet = MAVLinkPacket(msg_compassmot_status.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_compassmot_status.ID;
                
                packet.payload.putSINGLE(obj.current);
                packet.payload.putSINGLE(obj.CompensationX);
                packet.payload.putSINGLE(obj.CompensationY);
                packet.payload.putSINGLE(obj.CompensationZ);
                packet.payload.putUINT16(obj.throttle);
                packet.payload.putUINT16(obj.interference);

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
            
            obj.current = payload.getSINGLE();
            obj.CompensationX = payload.getSINGLE();
            obj.CompensationY = payload.getSINGLE();
            obj.CompensationZ = payload.getSINGLE();
            obj.throttle = payload.getUINT16();
            obj.interference = payload.getUINT16();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.current,2) ~= 1
                result = 'current';
            elseif size(obj.CompensationX,2) ~= 1
                result = 'CompensationX';
            elseif size(obj.CompensationY,2) ~= 1
                result = 'CompensationY';
            elseif size(obj.CompensationZ,2) ~= 1
                result = 'CompensationZ';
            elseif size(obj.throttle,2) ~= 1
                result = 'throttle';
            elseif size(obj.interference,2) ~= 1
                result = 'interference';

            else
                result = 0;
            end
        end

        function set.current(obj,value)
            obj.current = single(value);
        end
        
        function set.CompensationX(obj,value)
            obj.CompensationX = single(value);
        end
        
        function set.CompensationY(obj,value)
            obj.CompensationY = single(value);
        end
        
        function set.CompensationZ(obj,value)
            obj.CompensationZ = single(value);
        end
        
        function set.throttle(obj,value)
            if value == uint16(value)
                obj.throttle = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
        function set.interference(obj,value)
            if value == uint16(value)
                obj.interference = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
    end

end