classdef msg_mag_cal_report < mavlink_message
	%MSG_MAG_CAL_REPORT(packet,fitness,ofs_x,ofs_y,ofs_z,diag_x,diag_y,diag_z,offdiag_x,offdiag_y,offdiag_z,compass_id,cal_mask,cal_status,autosaved): MAVLINK Message ID = 192
    %Description:
    %    Reports results of completed compass calibration. Sent until MAG_CAL_ACK received.
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    fitness(single): RMS milligauss residuals
    %    ofs_x(single): X offset
    %    ofs_y(single): Y offset
    %    ofs_z(single): Z offset
    %    diag_x(single): X diagonal (matrix 11)
    %    diag_y(single): Y diagonal (matrix 22)
    %    diag_z(single): Z diagonal (matrix 33)
    %    offdiag_x(single): X off-diagonal (matrix 12 and 21)
    %    offdiag_y(single): Y off-diagonal (matrix 13 and 31)
    %    offdiag_z(single): Z off-diagonal (matrix 32 and 23)
    %    compass_id(uint8): Compass being calibrated
    %    cal_mask(uint8): Bitmask of compasses being calibrated
    %    cal_status(uint8): Status (see MAG_CAL_STATUS enum)
    %    autosaved(uint8): 0=requires a MAV_CMD_DO_ACCEPT_MAG_CAL, 1=saved to parameters
	
	properties(Constant)
		ID = 192
		LEN = 44
	end
	
	properties
        fitness	%RMS milligauss residuals	|	(single)
        ofs_x	%X offset	|	(single)
        ofs_y	%Y offset	|	(single)
        ofs_z	%Z offset	|	(single)
        diag_x	%X diagonal (matrix 11)	|	(single)
        diag_y	%Y diagonal (matrix 22)	|	(single)
        diag_z	%Z diagonal (matrix 33)	|	(single)
        offdiag_x	%X off-diagonal (matrix 12 and 21)	|	(single)
        offdiag_y	%Y off-diagonal (matrix 13 and 31)	|	(single)
        offdiag_z	%Z off-diagonal (matrix 32 and 23)	|	(single)
        compass_id	%Compass being calibrated	|	(uint8)
        cal_mask	%Bitmask of compasses being calibrated	|	(uint8)
        cal_status	%Status (see MAG_CAL_STATUS enum)	|	(uint8)
        autosaved	%0=requires a MAV_CMD_DO_ACCEPT_MAG_CAL, 1=saved to parameters	|	(uint8)
    end

    methods

        %Constructor: msg_mag_cal_report
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_mag_cal_report(packet,fitness,ofs_x,ofs_y,ofs_z,diag_x,diag_y,diag_z,offdiag_x,offdiag_y,offdiag_z,compass_id,cal_mask,cal_status,autosaved)
        
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
            
            elseif nargin-1 == 14
                obj.fitness = fitness;
                obj.ofs_x = ofs_x;
                obj.ofs_y = ofs_y;
                obj.ofs_z = ofs_z;
                obj.diag_x = diag_x;
                obj.diag_y = diag_y;
                obj.diag_z = diag_z;
                obj.offdiag_x = offdiag_x;
                obj.offdiag_y = offdiag_y;
                obj.offdiag_z = offdiag_z;
                obj.compass_id = compass_id;
                obj.cal_mask = cal_mask;
                obj.cal_status = cal_status;
                obj.autosaved = autosaved;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_mag_cal_report.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_mag_cal_report.ID;
                
                packet.payload.putSINGLE(obj.fitness);
                packet.payload.putSINGLE(obj.ofs_x);
                packet.payload.putSINGLE(obj.ofs_y);
                packet.payload.putSINGLE(obj.ofs_z);
                packet.payload.putSINGLE(obj.diag_x);
                packet.payload.putSINGLE(obj.diag_y);
                packet.payload.putSINGLE(obj.diag_z);
                packet.payload.putSINGLE(obj.offdiag_x);
                packet.payload.putSINGLE(obj.offdiag_y);
                packet.payload.putSINGLE(obj.offdiag_z);
                packet.payload.putUINT8(obj.compass_id);
                packet.payload.putUINT8(obj.cal_mask);
                packet.payload.putUINT8(obj.cal_status);
                packet.payload.putUINT8(obj.autosaved);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.fitness = payload.getSINGLE();
            obj.ofs_x = payload.getSINGLE();
            obj.ofs_y = payload.getSINGLE();
            obj.ofs_z = payload.getSINGLE();
            obj.diag_x = payload.getSINGLE();
            obj.diag_y = payload.getSINGLE();
            obj.diag_z = payload.getSINGLE();
            obj.offdiag_x = payload.getSINGLE();
            obj.offdiag_y = payload.getSINGLE();
            obj.offdiag_z = payload.getSINGLE();
            obj.compass_id = payload.getUINT8();
            obj.cal_mask = payload.getUINT8();
            obj.cal_status = payload.getUINT8();
            obj.autosaved = payload.getUINT8();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.fitness,2) ~= 1
                result = 'fitness';
            elseif size(obj.ofs_x,2) ~= 1
                result = 'ofs_x';
            elseif size(obj.ofs_y,2) ~= 1
                result = 'ofs_y';
            elseif size(obj.ofs_z,2) ~= 1
                result = 'ofs_z';
            elseif size(obj.diag_x,2) ~= 1
                result = 'diag_x';
            elseif size(obj.diag_y,2) ~= 1
                result = 'diag_y';
            elseif size(obj.diag_z,2) ~= 1
                result = 'diag_z';
            elseif size(obj.offdiag_x,2) ~= 1
                result = 'offdiag_x';
            elseif size(obj.offdiag_y,2) ~= 1
                result = 'offdiag_y';
            elseif size(obj.offdiag_z,2) ~= 1
                result = 'offdiag_z';
            elseif size(obj.compass_id,2) ~= 1
                result = 'compass_id';
            elseif size(obj.cal_mask,2) ~= 1
                result = 'cal_mask';
            elseif size(obj.cal_status,2) ~= 1
                result = 'cal_status';
            elseif size(obj.autosaved,2) ~= 1
                result = 'autosaved';

            else
                result = 0;
            end
        end

        function set.fitness(obj,value)
            obj.fitness = single(value);
        end
        
        function set.ofs_x(obj,value)
            obj.ofs_x = single(value);
        end
        
        function set.ofs_y(obj,value)
            obj.ofs_y = single(value);
        end
        
        function set.ofs_z(obj,value)
            obj.ofs_z = single(value);
        end
        
        function set.diag_x(obj,value)
            obj.diag_x = single(value);
        end
        
        function set.diag_y(obj,value)
            obj.diag_y = single(value);
        end
        
        function set.diag_z(obj,value)
            obj.diag_z = single(value);
        end
        
        function set.offdiag_x(obj,value)
            obj.offdiag_x = single(value);
        end
        
        function set.offdiag_y(obj,value)
            obj.offdiag_y = single(value);
        end
        
        function set.offdiag_z(obj,value)
            obj.offdiag_z = single(value);
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
        
        function set.autosaved(obj,value)
            if value == uint8(value)
                obj.autosaved = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
        
    end

end