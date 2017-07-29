classdef msg_ahrs < mavlink_message
	%MSG_AHRS: MAVLINK Message ID = 163
    %Description:
    %    Status of DCM attitude estimator
    %    If constructing from fields, packet argument should be set to [].
	%Arguments:
    %    packet(mavlink_packet): Packet to be decoded into this message type
    %    omegaIx(single): X gyro drift estimate rad/s
    %    omegaIy(single): Y gyro drift estimate rad/s
    %    omegaIz(single): Z gyro drift estimate rad/s
    %    accel_weight(single): average accel_weight
    %    renorm_val(single): average renormalisation value
    %    error_rp(single): average error_roll_pitch value
    %    error_yaw(single): average error_yaw value
	
	properties(Constant)
		ID = 163
		LEN = 28
	end
	
	properties
        omegaIx	%X gyro drift estimate rad/s	|	(single)
        omegaIy	%Y gyro drift estimate rad/s	|	(single)
        omegaIz	%Z gyro drift estimate rad/s	|	(single)
        accel_weight	%average accel_weight	|	(single)
        renorm_val	%average renormalisation value	|	(single)
        error_rp	%average error_roll_pitch value	|	(single)
        error_yaw	%average error_yaw value	|	(single)
    end

    methods

        function obj = msg_ahrs(packet,omegaIx,omegaIy,omegaIz,accel_weight,renorm_val,error_rp,error_yaw)
        %Create a new ahrs message
        
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
                obj.omegaIx = omegaIx;
                obj.omegaIy = omegaIy;
                obj.omegaIz = omegaIz;
                obj.accel_weight = accel_weight;
                obj.renorm_val = renorm_val;
                obj.error_rp = error_rp;
                obj.error_yaw = error_yaw;
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

                packet = mavlink_packet(msg_ahrs.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_ahrs.ID;
                
                packet.payload.putSINGLE(obj.omegaIx);
                packet.payload.putSINGLE(obj.omegaIy);
                packet.payload.putSINGLE(obj.omegaIz);
                packet.payload.putSINGLE(obj.accel_weight);
                packet.payload.putSINGLE(obj.renorm_val);
                packet.payload.putSINGLE(obj.error_rp);
                packet.payload.putSINGLE(obj.error_yaw);

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
            
            obj.omegaIx = payload.getSINGLE();
            obj.omegaIy = payload.getSINGLE();
            obj.omegaIz = payload.getSINGLE();
            obj.accel_weight = payload.getSINGLE();
            obj.renorm_val = payload.getSINGLE();
            obj.error_rp = payload.getSINGLE();
            obj.error_yaw = payload.getSINGLE();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.omegaIx,2) ~= 1
                result = 'omegaIx';
            elseif size(obj.omegaIy,2) ~= 1
                result = 'omegaIy';
            elseif size(obj.omegaIz,2) ~= 1
                result = 'omegaIz';
            elseif size(obj.accel_weight,2) ~= 1
                result = 'accel_weight';
            elseif size(obj.renorm_val,2) ~= 1
                result = 'renorm_val';
            elseif size(obj.error_rp,2) ~= 1
                result = 'error_rp';
            elseif size(obj.error_yaw,2) ~= 1
                result = 'error_yaw';

            else
                result = 0;
            end
        end

        function set.omegaIx(obj,value)
            obj.omegaIx = single(value);
        end
        
        function set.omegaIy(obj,value)
            obj.omegaIy = single(value);
        end
        
        function set.omegaIz(obj,value)
            obj.omegaIz = single(value);
        end
        
        function set.accel_weight(obj,value)
            obj.accel_weight = single(value);
        end
        
        function set.renorm_val(obj,value)
            obj.renorm_val = single(value);
        end
        
        function set.error_rp(obj,value)
            obj.error_rp = single(value);
        end
        
        function set.error_yaw(obj,value)
            obj.error_yaw = single(value);
        end
        
    end

end