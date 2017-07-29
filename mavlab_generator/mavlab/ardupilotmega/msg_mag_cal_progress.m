classdef msg_mag_cal_progress < mavlink_message
	%MSG_MAG_CAL_PROGRESS: MAVLINK Message ID = 191
    %Description:
    %    Reports progress of compass calibration.
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
    %    direction_x(single): Body frame direction vector for display
    %    direction_y(single): Body frame direction vector for display
    %    direction_z(single): Body frame direction vector for display
    %    compass_id(uint8): Compass being calibrated
    %    cal_mask(uint8): Bitmask of compasses being calibrated
    %    cal_status(uint8): Status (see MAG_CAL_STATUS enum)
    %    attempt(uint8): Attempt number
    %    completion_pct(uint8): Completion percentage
    %    completion_mask(uint8[10]): Bitmask of sphere sections (see http://en.wikipedia.org/wiki/Geodesic_grid)
	
	properties(Constant)
		ID = 191
		LEN = 27
	end
	
	properties
        direction_x	%Body frame direction vector for display	|	(single)
        direction_y	%Body frame direction vector for display	|	(single)
        direction_z	%Body frame direction vector for display	|	(single)
        compass_id	%Compass being calibrated	|	(uint8)
        cal_mask	%Bitmask of compasses being calibrated	|	(uint8)
        cal_status	%Status (see MAG_CAL_STATUS enum)	|	(uint8)
        attempt	%Attempt number	|	(uint8)
        completion_pct	%Completion percentage	|	(uint8)
        completion_mask	%Bitmask of sphere sections (see http://en.wikipedia.org/wiki/Geodesic_grid)	|	(uint8[10])
    end

    methods

        function obj = msg_mag_cal_progress(packet,direction_x,direction_y,direction_z,compass_id,cal_mask,cal_status,attempt,completion_pct,completion_mask)
        %Create a new mag_cal_progress message
        
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
            
            elseif nargin-1 == 9
                obj.direction_x = direction_x;
                obj.direction_y = direction_y;
                obj.direction_z = direction_z;
                obj.compass_id = compass_id;
                obj.cal_mask = cal_mask;
                obj.cal_status = cal_status;
                obj.attempt = attempt;
                obj.completion_pct = completion_pct;
                obj.completion_mask = completion_mask;
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

                packet = mavlink_packet(msg_mag_cal_progress.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_mag_cal_progress.ID;
                
                packet.payload.putSINGLE(obj.direction_x);
                packet.payload.putSINGLE(obj.direction_y);
                packet.payload.putSINGLE(obj.direction_z);
                packet.payload.putUINT8(obj.compass_id);
                packet.payload.putUINT8(obj.cal_mask);
                packet.payload.putUINT8(obj.cal_status);
                packet.payload.putUINT8(obj.attempt);
                packet.payload.putUINT8(obj.completion_pct);
                for i=1:1:10
                    packet.payload.putUINT8(obj.completion_mask(i));
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
            
            obj.direction_x = payload.getSINGLE();
            obj.direction_y = payload.getSINGLE();
            obj.direction_z = payload.getSINGLE();
            obj.compass_id = payload.getUINT8();
            obj.cal_mask = payload.getUINT8();
            obj.cal_status = payload.getUINT8();
            obj.attempt = payload.getUINT8();
            obj.completion_pct = payload.getUINT8();
            for i=1:1:10
                obj.completion_mask(i) = payload.getUINT8();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.direction_x,2) ~= 1
                result = 'direction_x';
            elseif size(obj.direction_y,2) ~= 1
                result = 'direction_y';
            elseif size(obj.direction_z,2) ~= 1
                result = 'direction_z';
            elseif size(obj.compass_id,2) ~= 1
                result = 'compass_id';
            elseif size(obj.cal_mask,2) ~= 1
                result = 'cal_mask';
            elseif size(obj.cal_status,2) ~= 1
                result = 'cal_status';
            elseif size(obj.attempt,2) ~= 1
                result = 'attempt';
            elseif size(obj.completion_pct,2) ~= 1
                result = 'completion_pct';
            elseif size(obj.completion_mask,2) ~= 10
                result = 'completion_mask';

            else
                result = 0;
            end
        end

        function set.direction_x(obj,value)
            obj.direction_x = single(value);
        end
        
        function set.direction_y(obj,value)
            obj.direction_y = single(value);
        end
        
        function set.direction_z(obj,value)
            obj.direction_z = single(value);
        end
        
        function set.compass_id(obj,value)
            if value == uint8(value)
                obj.compass_id = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.cal_mask(obj,value)
            if value == uint8(value)
                obj.cal_mask = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.cal_status(obj,value)
            if value == uint8(value)
                obj.cal_status = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.attempt(obj,value)
            if value == uint8(value)
                obj.attempt = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.completion_pct(obj,value)
            if value == uint8(value)
                obj.completion_pct = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
        function set.completion_mask(obj,value)
            if value == uint8(value)
                obj.completion_mask = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end