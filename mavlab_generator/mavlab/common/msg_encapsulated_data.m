classdef msg_encapsulated_data < mavlink_message
	%MSG_ENCAPSULATED_DATA: MAVLINK Message ID = 131
    %Description:
    %    No description available
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    seqnr(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    seqnr(uint16): sequence number (starting with 0 on every transmission)
    %    data(uint8[127]): image data bytes
	
	properties(Constant)
		ID = 131
		LEN = 127
	end
	
	properties
        seqnr	%sequence number (starting with 0 on every transmission)	|	(uint16)
        data	%image data bytes	|	(uint8[127])
    end

    methods

        function obj = msg_encapsulated_data(seqnr,data,varargin)
        %MSG_ENCAPSULATED_DATA: Create a new encapsulated_data message object
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1 
                if isa(seqnr,'mavlink_packet')
                    packet = seqnr;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('seqnr','mavlink_packet');
                end
            elseif nargin == 2
                obj.seqnr = seqnr;
                obj.data = data;
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

                packet = mavlink_packet(msg_encapsulated_data.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_encapsulated_data.ID;
                
                packet.payload.putUINT16(obj.seqnr);
                for i=1:1:127
                    packet.payload.putUINT8(obj.data(i));
                end

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
            
            obj.seqnr = payload.getUINT16();
            for i=1:1:127
                obj.data(i) = payload.getUINT8();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.seqnr,2) ~= 1
                result = 'seqnr';
            elseif size(obj.data,2) ~= 127
                result = 'data';

            else
                result = 0;
            end
        end

        function set.seqnr(obj,value)
            if value == uint16(value)
                obj.seqnr = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.data(obj,value)
            if value == uint8(value)
                obj.data = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end