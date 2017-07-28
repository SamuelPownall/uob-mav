classdef msg_local_position_ned < mavlink_message
	%MSG_LOCAL_POSITION_NED(packet,time_boot_ms,x,y,z,vx,vy,vz): MAVLINK Message ID = 32
    %Description:
    %    The filtered local position (e.g. fused computer vision and accelerometers). Coordinate frame is right-handed, Z-axis down (aeronautical frame, NED / north-east-down convention)
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    time_boot_ms(uint32): Timestamp (milliseconds since system boot)
    %    x(single): X Position
    %    y(single): Y Position
    %    z(single): Z Position
    %    vx(single): X Speed
    %    vy(single): Y Speed
    %    vz(single): Z Speed
	
	properties(Constant)
		ID = 32
		LEN = 28
	end
	
	properties
        time_boot_ms	%Timestamp (milliseconds since system boot)	|	(uint32)
        x	%X Position	|	(single)
        y	%Y Position	|	(single)
        z	%Z Position	|	(single)
        vx	%X Speed	|	(single)
        vy	%Y Speed	|	(single)
        vz	%Z Speed	|	(single)
    end

    methods

        %Constructor: msg_local_position_ned
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_local_position_ned(packet,time_boot_ms,x,y,z,vx,vy,vz)
        
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
            
            elseif nargin-1 == 7
                obj.time_boot_ms = time_boot_ms;
                obj.x = x;
                obj.y = y;
                obj.z = z;
                obj.vx = vx;
                obj.vy = vy;
                obj.vz = vz;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_local_position_ned.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_local_position_ned.ID;
                
                packet.payload.putUINT32(obj.time_boot_ms);
                packet.payload.putSINGLE(obj.x);
                packet.payload.putSINGLE(obj.y);
                packet.payload.putSINGLE(obj.z);
                packet.payload.putSINGLE(obj.vx);
                packet.payload.putSINGLE(obj.vy);
                packet.payload.putSINGLE(obj.vz);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.time_boot_ms = payload.getUINT32();
            obj.x = payload.getSINGLE();
            obj.y = payload.getSINGLE();
            obj.z = payload.getSINGLE();
            obj.vx = payload.getSINGLE();
            obj.vy = payload.getSINGLE();
            obj.vz = payload.getSINGLE();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';
            elseif size(obj.x,2) ~= 1
                result = 'x';
            elseif size(obj.y,2) ~= 1
                result = 'y';
            elseif size(obj.z,2) ~= 1
                result = 'z';
            elseif size(obj.vx,2) ~= 1
                result = 'vx';
            elseif size(obj.vy,2) ~= 1
                result = 'vy';
            elseif size(obj.vz,2) ~= 1
                result = 'vz';

            else
                result = 0;
            end
        end

        function set.time_boot_ms(obj,value)
            if value == uint32(value)
                obj.time_boot_ms = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
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
        
        function set.vx(obj,value)
            obj.vx = single(value);
        end
        
        function set.vy(obj,value)
            obj.vy = single(value);
        end
        
        function set.vz(obj,value)
            obj.vz = single(value);
        end
        
    end

end