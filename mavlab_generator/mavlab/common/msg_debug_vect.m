classdef msg_debug_vect < mavlink_message
	%MSG_DEBUG_VECT(packet,time_usec,x,y,z,name): MAVLINK Message ID = 250
    %Description:
    %    No description available
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    time_usec(uint64): Timestamp
    %    x(single): x
    %    y(single): y
    %    z(single): z
    %    name(uint8[10]): Name
	
	properties(Constant)
		ID = 250
		LEN = 30
	end
	
	properties
        time_usec	%Timestamp	|	(uint64)
        x	%x	|	(single)
        y	%y	|	(single)
        z	%z	|	(single)
        name	%Name	|	(uint8[10])
    end

    methods

        %Constructor: msg_debug_vect
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_debug_vect(packet,time_usec,x,y,z,name)
        
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
            
            elseif nargin-1 == 5
                obj.time_usec = time_usec;
                obj.x = x;
                obj.y = y;
                obj.z = z;
                obj.name = name;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_debug_vect.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_debug_vect.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                packet.payload.putSINGLE(obj.x);
                packet.payload.putSINGLE(obj.y);
                packet.payload.putSINGLE(obj.z);
                for i=1:1:10
                    packet.payload.putUINT8(obj.name(i));
                end

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.time_usec = payload.getUINT64();
            obj.x = payload.getSINGLE();
            obj.y = payload.getSINGLE();
            obj.z = payload.getSINGLE();
            for i=1:1:10
                obj.name(i) = payload.getUINT8();
            end

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.x,2) ~= 1
                result = 'x';
            elseif size(obj.y,2) ~= 1
                result = 'y';
            elseif size(obj.z,2) ~= 1
                result = 'z';
            elseif size(obj.name,2) ~= 10
                result = 'name';

            else
                result = 0;
            end
        end

        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                mavlink.throwTypeError('value','uint64');
            end
        end
        
        function set.x(obj,value)
            obj.x = single(value);
        end
        
        function set.y(obj,value)
            obj.y = single(value);
        end
        
        function set.z(obj,value)
            obj.z = single(value);
        end
        
        function set.name(obj,value)
            if value == uint8(value)
                obj.name = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end