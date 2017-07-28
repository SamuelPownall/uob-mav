classdef msg_encapsulated_data < mavlink_message
	%MSG_ENCAPSULATED_DATA(packet,seqnr,data): MAVLINK Message ID = 131
    %Description:
    %    No description available
    %    If constructing from fields, packet argument should be set to []
	%Fields:
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

        %Constructor: msg_encapsulated_data
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_encapsulated_data(packet,seqnr,data)
        
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
            
            elseif nargin-1 == 2
                obj.seqnr = seqnr;
                obj.data = data;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

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

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.seqnr = payload.getUINT16();
            for i=1:1:127
                obj.data(i) = payload.getUINT8();
            end

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

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