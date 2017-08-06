classdef msg_ekf_status_report < MAVLinkMessage
	%MSG_EKF_STATUS_REPORT: MAVLink Message ID = 193
    %Description:
    %    EKF Status message including flags and variances
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    velocity_variance(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
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

    methods(Static)

        function send(out,velocity_variance,pos_horiz_variance,pos_vert_variance,compass_variance,terrain_alt_variance,flags,varargin)

            if nargin == 6 + 1
                msg = msg_ekf_status_report(velocity_variance,pos_horiz_variance,pos_vert_variance,compass_variance,terrain_alt_variance,flags,varargin);
            elseif nargin == 2
                msg = msg_ekf_status_report(velocity_variance);
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

        function obj = msg_ekf_status_report(velocity_variance,pos_horiz_variance,pos_vert_variance,compass_variance,terrain_alt_variance,flags,varargin)
        %MSG_EKF_STATUS_REPORT: Create a new ekf_status_report message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(velocity_variance,'MAVLinkPacket')
                    packet = velocity_variance;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('velocity_variance','MAVLinkPacket');
                end
            elseif nargin >= 6 && isempty(varargin{1})
                obj.velocity_variance = velocity_variance;
                obj.pos_horiz_variance = pos_horiz_variance;
                obj.pos_vert_variance = pos_vert_variance;
                obj.compass_variance = compass_variance;
                obj.terrain_alt_variance = terrain_alt_variance;
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

                packet = MAVLinkPacket(msg_ekf_status_report.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_ekf_status_report.ID;
                
                packet.payload.putSINGLE(obj.velocity_variance);
                packet.payload.putSINGLE(obj.pos_horiz_variance);
                packet.payload.putSINGLE(obj.pos_vert_variance);
                packet.payload.putSINGLE(obj.compass_variance);
                packet.payload.putSINGLE(obj.terrain_alt_variance);
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
            
            obj.velocity_variance = payload.getSINGLE();
            obj.pos_horiz_variance = payload.getSINGLE();
            obj.pos_vert_variance = payload.getSINGLE();
            obj.compass_variance = payload.getSINGLE();
            obj.terrain_alt_variance = payload.getSINGLE();
            obj.flags = payload.getUINT16();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

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
                MAVLink.throwTypeError('value','uint16');
            end
        end
        
    end

end