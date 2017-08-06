classdef msg_mag_cal_progress < MAVLinkMessage
	%MSG_MAG_CAL_PROGRESS: MAVLink Message ID = 191
    %Description:
    %    Reports progress of compass calibration.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    direction_x(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,direction_x,direction_y,direction_z,compass_id,cal_mask,cal_status,attempt,completion_pct,completion_mask,varargin)

            if nargin == 9 + 1
                msg = msg_mag_cal_progress(direction_x,direction_y,direction_z,compass_id,cal_mask,cal_status,attempt,completion_pct,completion_mask,varargin);
            elseif nargin == 2
                msg = msg_mag_cal_progress(direction_x);
            else
                MAVLink.throwCustomError('The number of function arguments is not valid');
                return;
            end

            packet = msg.pack();
            if ~isempty(packet)
                buffer = packet.encode();
                write(out,buffer);
            else
                MAVLink.throwCustomError('The packet could not be verified');
            end
        
        end

    end

    methods

        function obj = msg_mag_cal_progress(direction_x,direction_y,direction_z,compass_id,cal_mask,cal_status,attempt,completion_pct,completion_mask,varargin)
        %MSG_MAG_CAL_PROGRESS: Create a new mag_cal_progress message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(direction_x,'MAVLinkPacket')
                    packet = direction_x;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('direction_x','MAVLinkPacket');
                end
            elseif nargin >= 9 && isempty(varargin{1})
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
                MAVLink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        function packet = pack(obj)
        %PACK: Packs this MAVLink message into a MAVLinkPacket
        %Description:
        %    Packs the fields of a message into a MAVLinkPacket which can be encoded
        %    for transmission.

            errorField = obj.verify();
            if errorField == 0

                packet = MAVLinkPacket(msg_mag_cal_progress.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
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
                MAVLink.throwPackingError(errorField);
            end

        end

        function unpack(obj, payload)
        %UNPACK: Unpacks a MAVLinkPayload into this MAVLink message
        %Description:
        %    Extracts the data from a MAVLinkPayload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(MAVLinkPayload): The payload to be unpacked into this MAVLink message

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
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.cal_mask(obj,value)
            if value == uint8(value)
                obj.cal_mask = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.cal_status(obj,value)
            if value == uint8(value)
                obj.cal_status = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.attempt(obj,value)
            if value == uint8(value)
                obj.attempt = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.completion_pct(obj,value)
            if value == uint8(value)
                obj.completion_pct = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.completion_mask(obj,value)
            if value == uint8(value)
                obj.completion_mask = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end