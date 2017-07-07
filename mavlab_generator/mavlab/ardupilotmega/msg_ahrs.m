classdef msg_ahrs < mavlink_message
    %MAVLINK Message Class
    %Name: ahrs	ID: 163
    %Description: Status of DCM attitude estimator
            
    properties(Constant)
        ID = 163
        LEN = 28
    end
    
    properties        
		omegaix	%X gyro drift estimate rad/s (single)
		omegaiy	%Y gyro drift estimate rad/s (single)
		omegaiz	%Z gyro drift estimate rad/s (single)
		accel_weight	%average accel_weight (single)
		renorm_val	%average renormalisation value (single)
		error_rp	%average error_roll_pitch value (single)
		error_yaw	%average error_yaw value (single)
	end
    
    methods
        
        %Constructor: msg_ahrs
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_ahrs(packet,omegaix,omegaiy,omegaiz,accel_weight,renorm_val,error_rp,error_yaw)
        
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
                
            elseif nargin == 8
                
				obj.omegaix = omegaix;
				obj.omegaiy = omegaiy;
				obj.omegaiz = omegaiz;
				obj.accel_weight = accel_weight;
				obj.renorm_val = renorm_val;
				obj.error_rp = error_rp;
				obj.error_yaw = error_yaw;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_ahrs.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_ahrs.ID;
                
				packet.payload.putSINGLE(obj.omegaix);

				packet.payload.putSINGLE(obj.omegaiy);

				packet.payload.putSINGLE(obj.omegaiz);

				packet.payload.putSINGLE(obj.accel_weight);

				packet.payload.putSINGLE(obj.renorm_val);

				packet.payload.putSINGLE(obj.error_rp);

				packet.payload.putSINGLE(obj.error_yaw);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.omegaix = payload.getSINGLE();

			obj.omegaiy = payload.getSINGLE();

			obj.omegaiz = payload.getSINGLE();

			obj.accel_weight = payload.getSINGLE();

			obj.renorm_val = payload.getSINGLE();

			obj.error_rp = payload.getSINGLE();

			obj.error_yaw = payload.getSINGLE();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.omegaix,2) ~= 1
                result = 'omegaix';                                        
            elseif size(obj.omegaiy,2) ~= 1
                result = 'omegaiy';                                        
            elseif size(obj.omegaiz,2) ~= 1
                result = 'omegaiz';                                        
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
                            
        function set.omegaix(obj,value)
            obj.omegaix = single(value);
        end
                                
        function set.omegaiy(obj,value)
            obj.omegaiy = single(value);
        end
                                
        function set.omegaiz(obj,value)
            obj.omegaiz = single(value);
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