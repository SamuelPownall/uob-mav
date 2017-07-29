classdef msg_compassmot_status < mavlink_message
	%MSG_COMPASSMOT_STATUS: MAVLINK Message ID = 177
    %Description:
    %    Status of compassmot calibration
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
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

    methods

        function obj = msg_compassmot_status(packet,current,CompensationX,CompensationY,CompensationZ,throttle,interference)
        %Create a new compassmot_status message
        
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
            
            elseif nargin-1 == 6
                obj.current = current;
                obj.CompensationX = CompensationX;
                obj.CompensationY = CompensationY;
                obj.CompensationZ = CompensationZ;
                obj.throttle = throttle;
                obj.interference = interference;
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

                packet = mavlink_packet(msg_compassmot_status.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_compassmot_status.ID;
                
                packet.payload.putSINGLE(obj.current);
                packet.payload.putSINGLE(obj.CompensationX);
                packet.payload.putSINGLE(obj.CompensationY);
                packet.payload.putSINGLE(obj.CompensationZ);
                packet.payload.putUINT16(obj.throttle);
                packet.payload.putUINT16(obj.interference);

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
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.interference(obj,value)
            if value == uint16(value)
                obj.interference = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
    end

end