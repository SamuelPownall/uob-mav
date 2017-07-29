classdef msg_ekf_status_report < mavlink_handle
	%MSG_EKF_STATUS_REPORT(packet,velocity_variance,pos_horiz_variance,pos_vert_variance,compass_variance,terrain_alt_variance,flags): MAVLINK Message ID = 193
    %Description:
    %    EKF Status message including flags and variances
    %    If constructing from fields, packet argument should be set to []
	%Fields:
    %    velocity_variance(single): Velocity variance
    %    pos_horiz_variance(single): Horizontal Position variance
    %    pos_vert_variance(single): Vertical Position variance
    %    compass_variance(single): Compass variance
    %    terrain_alt_variance(single): Terrain Altitude variance
    %    flags(uint16): Flags
	
	properties(Constant)
		ID = 193
		LEN = 22
	end
	
	properties
        velocity_variance	%Velocity variance	|	(single)
        pos_horiz_variance	%Horizontal Position variance	|	(single)
        pos_vert_variance	%Vertical Position variance	|	(single)
        compass_variance	%Compass variance	|	(single)
        terrain_alt_variance	%Terrain Altitude variance	|	(single)
        flags	%Flags	|	(uint16)
    end

    methods

        %Constructor: msg_ekf_status_report
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_ekf_status_report(packet,velocity_variance,pos_horiz_variance,pos_vert_variance,compass_variance,terrain_alt_variance,flags)
        
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
            
            elseif nargin-1 == 6
                obj.velocity_variance = velocity_variance;
                obj.pos_horiz_variance = pos_horiz_variance;
                obj.pos_vert_variance = pos_vert_variance;
                obj.compass_variance = compass_variance;
                obj.terrain_alt_variance = terrain_alt_variance;
                obj.flags = flags;
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)

            errorField = obj.verify();
            if errorField == 0

                packet = mavlink_packet(msg_ekf_status_report.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_ekf_status_report.ID;
                
                packet.payload.putSINGLE(obj.velocity_variance);
                packet.payload.putSINGLE(obj.pos_horiz_variance);
                packet.payload.putSINGLE(obj.pos_vert_variance);
                packet.payload.putSINGLE(obj.compass_variance);
                packet.payload.putSINGLE(obj.terrain_alt_variance);
                packet.payload.putUINT16(obj.flags);

            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end

        end

        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)

            payload.resetIndex();
            
            obj.velocity_variance = payload.getSINGLE();
            obj.pos_horiz_variance = payload.getSINGLE();
            obj.pos_vert_variance = payload.getSINGLE();
            obj.compass_variance = payload.getSINGLE();
            obj.terrain_alt_variance = payload.getSINGLE();
            obj.flags = payload.getUINT16();

        end
        
        %Function: Returns either 0 or the name of the first encountered empty field
        function result = verify(obj)

            if 1==0
            elseif size(obj.velocity_variance,2) ~= 1
                result = 'velocity_variance';
            elseif size(obj.pos_horiz_variance,2) ~= 1
                result = 'pos_horiz_variance';
            elseif size(obj.pos_vert_variance,2) ~= 1
                result = 'pos_vert_variance';
            elseif size(obj.compass_variance,2) ~= 1
                result = 'compass_variance';
            elseif size(obj.terrain_alt_variance,2) ~= 1
                result = 'terrain_alt_variance';
            elseif size(obj.flags,2) ~= 1
                result = 'flags';

            else
                result = 0;
            end
        end

        function set.velocity_variance(obj,value)
            obj.velocity_variance = single(value);
        end
        
        function set.pos_horiz_variance(obj,value)
            obj.pos_horiz_variance = single(value);
        end
        
        function set.pos_vert_variance(obj,value)
            obj.pos_vert_variance = single(value);
        end
        
        function set.compass_variance(obj,value)
            obj.compass_variance = single(value);
        end
        
        function set.terrain_alt_variance(obj,value)
            obj.terrain_alt_variance = single(value);
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