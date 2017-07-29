classdef msg_att_pos_mocap < mavlink_handle
	%MSG_ATT_POS_MOCAP(packet,time_usec,q,x,y,z): MAVLINK Message ID = 138
    %Description:
    %    Motion capture attitude and position
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    time_usec(uint64): Timestamp (micros since boot or Unix epoch)
    %    q(single[4]): Attitude quaternion (w, x, y, z order, zero-rotation is 1, 0, 0, 0)
    %    x(single): X position in meters (NED)
    %    y(single): Y position in meters (NED)
    %    z(single): Z position in meters (NED)
	
	properties(Constant)
		ID = 138
		LEN = 36
	end
	
	properties
        time_usec	%Timestamp (micros since boot or Unix epoch)	|	(uint64)
        q	%Attitude quaternion (w, x, y, z order, zero-rotation is 1, 0, 0, 0)	|	(single[4])
        x	%X position in meters (NED)	|	(single)
        y	%Y position in meters (NED)	|	(single)
        z	%Z position in meters (NED)	|	(single)
    end

    methods

        %Constructor: msg_att_pos_mocap
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_att_pos_mocap(packet,time_usec,q,x,y,z)
        
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
                obj.q = q;
                obj.x = x;
                obj.y = y;
                obj.z = z;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_att_pos_mocap.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_att_pos_mocap.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                for i=1:1:4
                    packet.payload.putSINGLE(obj.q(i));
                end
                packet.payload.putSINGLE(obj.x);
                packet.payload.putSINGLE(obj.y);
                packet.payload.putSINGLE(obj.z);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.time_usec = payload.getUINT64();
            for i=1:1:4
                obj.q(i) = payload.getSINGLE();
            end
            obj.x = payload.getSINGLE();
            obj.y = payload.getSINGLE();
            obj.z = payload.getSINGLE();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.q,2) ~= 4
                result = 'q';
            elseif size(obj.x,2) ~= 1
                result = 'x';
            elseif size(obj.y,2) ~= 1
                result = 'y';
            elseif size(obj.z,2) ~= 1
                result = 'z';

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
        
        function set.q(obj,value)
            obj.q = single(value);
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
        
    end

end