classdef msg_mount_status < mavlink_message
	%MSG_MOUNT_STATUS: MAVLINK Message ID = 158
    %Description:
    %    Message with some status from APM to GCS about camera or antenna mount
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    pointing_a(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    pointing_a(int32): pitch(deg*100)
    %    pointing_b(int32): roll(deg*100)
    %    pointing_c(int32): yaw(deg*100)
    %    target_system(uint8): System ID
    %    target_component(uint8): Component ID
	
	properties(Constant)
		ID = 158
		LEN = 14
	end
	
	properties
        pointing_a	%pitch(deg*100)	|	(int32)
        pointing_b	%roll(deg*100)	|	(int32)
        pointing_c	%yaw(deg*100)	|	(int32)
        target_system	%System ID	|	(uint8)
        target_component	%Component ID	|	(uint8)
    end

    methods

        function obj = msg_mount_status(pointing_a,pointing_b,pointing_c,target_system,target_component,varargin)
        %Create a new mount_status message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(pointing_a,'mavlink_packet')
                    packet = pointing_a;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('pointing_a','mavlink_packet');
                end
            
            elseif nargin == 5
                obj.pointing_a = pointing_a;
                obj.pointing_b = pointing_b;
                obj.pointing_c = pointing_c;
                obj.target_system = target_system;
                obj.target_component = target_component;
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

                packet = mavlink_packet(msg_mount_status.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_mount_status.ID;
                
                packet.payload.putINT32(obj.pointing_a);
                packet.payload.putINT32(obj.pointing_b);
                packet.payload.putINT32(obj.pointing_c);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);

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
            
            obj.pointing_a = payload.getINT32();
            obj.pointing_b = payload.getINT32();
            obj.pointing_c = payload.getINT32();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.pointing_a,2) ~= 1
                result = 'pointing_a';
            elseif size(obj.pointing_b,2) ~= 1
                result = 'pointing_b';
            elseif size(obj.pointing_c,2) ~= 1
                result = 'pointing_c';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';

            else
                result = 0;
            end
        end

        function set.pointing_a(obj,value)
            if value == int32(value)
                obj.pointing_a = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
        
        function set.pointing_b(obj,value)
            if value == int32(value)
                obj.pointing_b = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
        
        function set.pointing_c(obj,value)
            if value == int32(value)
                obj.pointing_c = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
        
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end