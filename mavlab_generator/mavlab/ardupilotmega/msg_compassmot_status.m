classdef msg_compassmot_status < mavlink_handle
	%MSG_COMPASSMOT_STATUS(packet,current,CompensationX,CompensationY,CompensationZ,throttle,interference): MAVLINK Message ID = 177
    %Description:
    %    Status of compassmot calibration
    %    If constructing from fields, packet argument should be set to []
	%Fields:
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

        %Constructor: msg_compassmot_status
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_compassmot_status(packet,current,CompensationX,CompensationY,CompensationZ,throttle,interference)
        
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

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

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

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.current = payload.getSINGLE();
            obj.CompensationX = payload.getSINGLE();
            obj.CompensationY = payload.getSINGLE();
            obj.CompensationZ = payload.getSINGLE();
            obj.throttle = payload.getUINT16();
            obj.interference = payload.getUINT16();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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