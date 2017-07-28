classdef msg_gopro_heartbeat < mavlink_message
	%MSG_GOPRO_HEARTBEAT(packet,status): MAVLINK Message ID = 215
    %Description:
    %    Heartbeat from a HeroBus attached GoPro
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    status(uint8): Status
	
	properties(Constant)
		ID = 215
		LEN = 1
	end
	
	properties
        status	%Status	|	(uint8)
    end

    methods

        %Constructor: msg_gopro_heartbeat
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_gopro_heartbeat(packet,status)
        
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
            
            elseif nargin-1 == 1
                obj.status = status;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_gopro_heartbeat.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_gopro_heartbeat.ID;
                
                packet.payload.putUINT8(obj.status);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.status = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.status,2) ~= 1
                result = 'status';

            else
                result = 0;
            end
        end

        function set.status(obj,value)
            if value == uint8(value)
                obj.status = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end