classdef msg_memory_vect < mavlink_message
	%MSG_MEMORY_VECT: MAVLINK Message ID = 249
    %Description:
    %    Send raw controller memory. The use of this message is discouraged for normal packets, but a quite efficient way for testing new messages and getting experimental debug output.
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    address(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    address(uint16): Starting address of the debug variables
    %    ver(uint8): Version code of the type variable. 0=unknown, type ignored and assumed int16_t. 1=as below
    %    type(uint8): Type code of the memory variables. for ver = 1: 0=16 x int16_t, 1=16 x uint16_t, 2=16 x Q15, 3=16 x 1Q14
    %    value(int8[32]): Memory contents at specified address
	
	properties(Constant)
		ID = 249
		LEN = 36
	end
	
	properties
        address	%Starting address of the debug variables	|	(uint16)
        ver	%Version code of the type variable. 0=unknown, type ignored and assumed int16_t. 1=as below	|	(uint8)
        type	%Type code of the memory variables. for ver = 1: 0=16 x int16_t, 1=16 x uint16_t, 2=16 x Q15, 3=16 x 1Q14	|	(uint8)
        value	%Memory contents at specified address	|	(int8[32])
    end

    methods

        function obj = msg_memory_vect(address,ver,type,value,varargin)
        %MSG_MEMORY_VECT: Create a new memory_vect message object
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1 
                if isa(address,'mavlink_packet')
                    packet = address;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('address','mavlink_packet');
                end
            elseif nargin == 4
                obj.address = address;
                obj.ver = ver;
                obj.type = type;
                obj.value = value;
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

                packet = mavlink_packet(msg_memory_vect.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_memory_vect.ID;
                
                packet.payload.putUINT16(obj.address);
                packet.payload.putUINT8(obj.ver);
                packet.payload.putUINT8(obj.type);
                for i=1:1:32
                    packet.payload.putINT8(obj.value(i));
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
            
            obj.address = payload.getUINT16();
            obj.ver = payload.getUINT8();
            obj.type = payload.getUINT8();
            for i=1:1:32
                obj.value(i) = payload.getINT8();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.address,2) ~= 1
                result = 'address';
            elseif size(obj.ver,2) ~= 1
                result = 'ver';
            elseif size(obj.type,2) ~= 1
                result = 'type';
            elseif size(obj.value,2) ~= 32
                result = 'value';

            else
                result = 0;
            end
        end

        function set.address(obj,value)
            if value == uint16(value)
                obj.address = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
        function set.ver(obj,value)
            if value == uint8(value)
                obj.ver = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.type(obj,value)
            if value == uint8(value)
                obj.type = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.value(obj,value)
            if value == int8(value)
                obj.value = int8(value);
            else
                mavlink.throwTypeError('value','int8');
            end
        end
        
    end

end