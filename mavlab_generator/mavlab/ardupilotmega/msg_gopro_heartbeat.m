classdef msg_gopro_heartbeat < mavlink_message
	%MSG_GOPRO_HEARTBEAT: MAVLINK Message ID = 215
    %Description:
    %    Heartbeat from a HeroBus attached GoPro
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    status(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    status(uint8): Status
	
	properties(Constant)
		ID = 215
		LEN = 1
	end
	
	properties
        status	%Status	|	(uint8)
    end

    methods

        function obj = msg_gopro_heartbeat(status,varargin)
        %Create a new gopro_heartbeat message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(status,'mavlink_packet')
                    packet = status;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    obj.status = status;
                end
            
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

        function unpack(obj, payload)
        %UNPACK: Unpacks a mavlink_payload into this MAVLINK message
        %Description:
        %    Extracts the data from a mavlink_payload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(mavlink_payload): The payload to be unpacked into this MAVLINK message

            payload.resetIndex();
            
            obj.status = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

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