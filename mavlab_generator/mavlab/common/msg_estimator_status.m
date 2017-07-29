classdef msg_estimator_status < mavlink_message
	%MSG_ESTIMATOR_STATUS: MAVLINK Message ID = 230
    %Description:
    %    Estimator status message including flags, innovation test ratios and estimated accuracies. The flags message is an integer bitmask containing information on which EKF outputs are valid. See the ESTIMATOR_STATUS_FLAGS enum definition for further information. The innovaton test ratios show the magnitude of the sensor innovation divided by the innovation check threshold. Under normal operation the innovaton test ratios should be below 0.5 with occasional values up to 1.0. Values greater than 1.0 should be rare under normal operation and indicate that a measurement has been rejected by the filter. The user should be notified if an innovation test ratio greater than 1.0 is recorded. Notifications for values in the range between 0.5 and 1.0 should be optional and controllable by the user.
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
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

    methods

        function obj = msg_estimator_status(packet,time_usec,vel_ratio,pos_horiz_ratio,pos_vert_ratio,mag_ratio,hagl_ratio,tas_ratio,pos_horiz_accuracy,pos_vert_accuracy,flags)
        %Create a new estimator_status message
        
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
            
            elseif nargin-1 == 10
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

                packet = mavlink_packet(msg_estimator_status.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
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
                mavlink.throwTypeError('value','uint64');
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
                mavlink.throwTypeError('value','uint16');
            end
        end
        
    end

end