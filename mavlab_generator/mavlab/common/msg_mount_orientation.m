classdef msg_mount_orientation < mavlink_message
	%MSG_MOUNT_ORIENTATION(packet,time_boot_ms,roll,pitch,yaw): MAVLINK Message ID = 265
    %Description:
    %    WIP: Orientation of a mount
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    time_boot_ms(uint32): Timestamp (milliseconds since system boot)
    %    roll(single): Roll in degrees
    %    pitch(single): Pitch in degrees
    %    yaw(single): Yaw in degrees
	
	properties(Constant)
		ID = 265
		LEN = 16
	end
	
	properties
        time_boot_ms	%Timestamp (milliseconds since system boot)	|	(uint32)
        roll	%Roll in degrees	|	(single)
        pitch	%Pitch in degrees	|	(single)
        yaw	%Yaw in degrees	|	(single)
    end

    methods

        %Constructor: msg_mount_orientation
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_mount_orientation(packet,time_boot_ms,roll,pitch,yaw)
        
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
            
            elseif nargin-1 == 4
                obj.time_boot_ms = time_boot_ms;
                obj.roll = roll;
                obj.pitch = pitch;
                obj.yaw = yaw;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_mount_orientation.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_mount_orientation.ID;
                
                packet.payload.putUINT32(obj.time_boot_ms);
                packet.payload.putSINGLE(obj.roll);
                packet.payload.putSINGLE(obj.pitch);
                packet.payload.putSINGLE(obj.yaw);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.time_boot_ms = payload.getUINT32();
            obj.roll = payload.getSINGLE();
            obj.pitch = payload.getSINGLE();
            obj.yaw = payload.getSINGLE();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.time_boot_ms,2) ~= 1
                result = 'time_boot_ms';
            elseif size(obj.roll,2) ~= 1
                result = 'roll';
            elseif size(obj.pitch,2) ~= 1
                result = 'pitch';
            elseif size(obj.yaw,2) ~= 1
                result = 'yaw';

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
        
        function set.roll(obj,value)
            obj.roll = single(value);
        end
        
        function set.pitch(obj,value)
            obj.pitch = single(value);
        end
        
        function set.yaw(obj,value)
            obj.yaw = single(value);
        end
        
    end

end