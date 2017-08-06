classdef msg_estimator_status < MAVLinkMessage
	%MSG_ESTIMATOR_STATUS: MAVLink Message ID = 230
    %Description:
    %    Estimator status message including flags, innovation test ratios and estimated accuracies. The flags message is an integer bitmask containing information on which EKF outputs are valid. See the ESTIMATOR_STATUS_FLAGS enum definition for further information. The innovaton test ratios show the magnitude of the sensor innovation divided by the innovation check threshold. Under normal operation the innovaton test ratios should be below 0.5 with occasional values up to 1.0. Values greater than 1.0 should be rare under normal operation and indicate that a measurement has been rejected by the filter. The user should be notified if an innovation test ratio greater than 1.0 is recorded. Notifications for values in the range between 0.5 and 1.0 should be optional and controllable by the user.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_usec(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    time_usec(uint64): Timestamp (micros since boot or Unix epoch)
    %    vel_ratio(single): Velocity innovation test ratio
    %    pos_horiz_ratio(single): Horizontal position innovation test ratio
    %    pos_vert_ratio(single): Vertical position innovation test ratio
    %    mag_ratio(single): Magnetometer innovation test ratio
    %    hagl_ratio(single): Height above terrain innovation test ratio
    %    tas_ratio(single): True airspeed innovation test ratio
    %    pos_horiz_accuracy(single): Horizontal position 1-STD accuracy relative to the EKF local origin (m)
    %    pos_vert_accuracy(single): Vertical position 1-STD accuracy relative to the EKF local origin (m)
    %    flags(uint16): Integer bitmask indicating which EKF outputs are valid. See definition for ESTIMATOR_STATUS_FLAGS.
	
	properties(Constant)
		ID = 230
		LEN = 42
	end
	
	properties
        time_usec	%Timestamp (micros since boot or Unix epoch)	|	(uint64)
        vel_ratio	%Velocity innovation test ratio	|	(single)
        pos_horiz_ratio	%Horizontal position innovation test ratio	|	(single)
        pos_vert_ratio	%Vertical position innovation test ratio	|	(single)
        mag_ratio	%Magnetometer innovation test ratio	|	(single)
        hagl_ratio	%Height above terrain innovation test ratio	|	(single)
        tas_ratio	%True airspeed innovation test ratio	|	(single)
        pos_horiz_accuracy	%Horizontal position 1-STD accuracy relative to the EKF local origin (m)	|	(single)
        pos_vert_accuracy	%Vertical position 1-STD accuracy relative to the EKF local origin (m)	|	(single)
        flags	%Integer bitmask indicating which EKF outputs are valid. See definition for ESTIMATOR_STATUS_FLAGS.	|	(uint16)
    end

    methods(Static)

        function send(out,time_usec,vel_ratio,pos_horiz_ratio,pos_vert_ratio,mag_ratio,hagl_ratio,tas_ratio,pos_horiz_accuracy,pos_vert_accuracy,flags,varargin)

            if nargin == 10 + 1
                msg = msg_estimator_status(time_usec,vel_ratio,pos_horiz_ratio,pos_vert_ratio,mag_ratio,hagl_ratio,tas_ratio,pos_horiz_accuracy,pos_vert_accuracy,flags,varargin);
            elseif nargin == 2
                msg = msg_estimator_status(time_usec);
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

        function obj = msg_estimator_status(time_usec,vel_ratio,pos_horiz_ratio,pos_vert_ratio,mag_ratio,hagl_ratio,tas_ratio,pos_horiz_accuracy,pos_vert_accuracy,flags,varargin)
        %MSG_ESTIMATOR_STATUS: Create a new estimator_status message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(time_usec,'MAVLinkPacket')
                    packet = time_usec;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('time_usec','MAVLinkPacket');
                end
            elseif nargin >= 10 && isempty(varargin{1})
                obj.time_usec = time_usec;
                obj.vel_ratio = vel_ratio;
                obj.pos_horiz_ratio = pos_horiz_ratio;
                obj.pos_vert_ratio = pos_vert_ratio;
                obj.mag_ratio = mag_ratio;
                obj.hagl_ratio = hagl_ratio;
                obj.tas_ratio = tas_ratio;
                obj.pos_horiz_accuracy = pos_horiz_accuracy;
                obj.pos_vert_accuracy = pos_vert_accuracy;
                obj.flags = flags;
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

                packet = MAVLinkPacket(msg_estimator_status.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_estimator_status.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                packet.payload.putSINGLE(obj.vel_ratio);
                packet.payload.putSINGLE(obj.pos_horiz_ratio);
                packet.payload.putSINGLE(obj.pos_vert_ratio);
                packet.payload.putSINGLE(obj.mag_ratio);
                packet.payload.putSINGLE(obj.hagl_ratio);
                packet.payload.putSINGLE(obj.tas_ratio);
                packet.payload.putSINGLE(obj.pos_horiz_accuracy);
                packet.payload.putSINGLE(obj.pos_vert_accuracy);
                packet.payload.putUINT16(obj.flags);

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
            
            obj.time_usec = payload.getUINT64();
            obj.vel_ratio = payload.getSINGLE();
            obj.pos_horiz_ratio = payload.getSINGLE();
            obj.pos_vert_ratio = payload.getSINGLE();
            obj.mag_ratio = payload.getSINGLE();
            obj.hagl_ratio = payload.getSINGLE();
            obj.tas_ratio = payload.getSINGLE();
            obj.pos_horiz_accuracy = payload.getSINGLE();
            obj.pos_vert_accuracy = payload.getSINGLE();
            obj.flags = payload.getUINT16();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.vel_ratio,2) ~= 1
                result = 'vel_ratio';
            elseif size(obj.pos_horiz_ratio,2) ~= 1
                result = 'pos_horiz_ratio';
            elseif size(obj.pos_vert_ratio,2) ~= 1
                result = 'pos_vert_ratio';
            elseif size(obj.mag_ratio,2) ~= 1
                result = 'mag_ratio';
            elseif size(obj.hagl_ratio,2) ~= 1
                result = 'hagl_ratio';
            elseif size(obj.tas_ratio,2) ~= 1
                result = 'tas_ratio';
            elseif size(obj.pos_horiz_accuracy,2) ~= 1
                result = 'pos_horiz_accuracy';
            elseif size(obj.pos_vert_accuracy,2) ~= 1
                result = 'pos_vert_accuracy';
            elseif size(obj.flags,2) ~= 1
                result = 'flags';

            else
                result = 0;
            end
        end

        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                MAVLink.throwTypeError('value','uint64');
            end
        end
        
        function set.vel_ratio(obj,value)
            obj.vel_ratio = single(value);
        end
        
        function set.pos_horiz_ratio(obj,value)
            obj.pos_horiz_ratio = single(value);
        end
        
        function set.pos_vert_ratio(obj,value)
            obj.pos_vert_ratio = single(value);
        end
        
        function set.mag_ratio(obj,value)
            obj.mag_ratio = single(value);
        end
        
        function set.hagl_ratio(obj,value)
            obj.hagl_ratio = single(value);
        end
        
        function set.tas_ratio(obj,value)
            obj.tas_ratio = single(value);
        end
        
        function set.pos_horiz_accuracy(obj,value)
            obj.pos_horiz_accuracy = single(value);
        end
        
        function set.pos_vert_accuracy(obj,value)
            obj.pos_vert_accuracy = single(value);
        end
        
        function set.flags(obj,value)
            if value == uint16(value)
                obj.flags = uint16(value);
            else
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
    end

end