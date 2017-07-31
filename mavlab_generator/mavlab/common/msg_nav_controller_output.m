classdef msg_nav_controller_output < mavlink_message
	%MSG_NAV_CONTROLLER_OUTPUT: MAVLINK Message ID = 62
    %Description:
    %    The state of the fixed wing navigation and position controller.
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    nav_roll(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    nav_roll(single): Current desired roll in degrees
    %    nav_pitch(single): Current desired pitch in degrees
    %    alt_error(single): Current altitude error in meters
    %    aspd_error(single): Current airspeed error in meters/second
    %    xtrack_error(single): Current crosstrack error on x-y plane in meters
    %    nav_bearing(int16): Current desired heading in degrees
    %    target_bearing(int16): Bearing to current MISSION/target in degrees
    %    wp_dist(uint16): Distance to active MISSION in meters
	
	properties(Constant)
		ID = 62
		LEN = 26
	end
	
	properties
        nav_roll	%Current desired roll in degrees	|	(single)
        nav_pitch	%Current desired pitch in degrees	|	(single)
        alt_error	%Current altitude error in meters	|	(single)
        aspd_error	%Current airspeed error in meters/second	|	(single)
        xtrack_error	%Current crosstrack error on x-y plane in meters	|	(single)
        nav_bearing	%Current desired heading in degrees	|	(int16)
        target_bearing	%Bearing to current MISSION/target in degrees	|	(int16)
        wp_dist	%Distance to active MISSION in meters	|	(uint16)
    end

    methods

        function obj = msg_nav_controller_output(nav_roll,nav_pitch,alt_error,aspd_error,xtrack_error,nav_bearing,target_bearing,wp_dist,varargin)
        %MSG_NAV_CONTROLLER_OUTPUT: Create a new nav_controller_output message object
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1 
                if isa(nav_roll,'mavlink_packet')
                    packet = nav_roll;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('nav_roll','mavlink_packet');
                end
            elseif nargin == 8
                obj.nav_roll = nav_roll;
                obj.nav_pitch = nav_pitch;
                obj.alt_error = alt_error;
                obj.aspd_error = aspd_error;
                obj.xtrack_error = xtrack_error;
                obj.nav_bearing = nav_bearing;
                obj.target_bearing = target_bearing;
                obj.wp_dist = wp_dist;
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

                packet = mavlink_packet(msg_nav_controller_output.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_nav_controller_output.ID;
                
                packet.payload.putSINGLE(obj.nav_roll);
                packet.payload.putSINGLE(obj.nav_pitch);
                packet.payload.putSINGLE(obj.alt_error);
                packet.payload.putSINGLE(obj.aspd_error);
                packet.payload.putSINGLE(obj.xtrack_error);
                packet.payload.putINT16(obj.nav_bearing);
                packet.payload.putINT16(obj.target_bearing);
                packet.payload.putUINT16(obj.wp_dist);

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
            
            obj.nav_roll = payload.getSINGLE();
            obj.nav_pitch = payload.getSINGLE();
            obj.alt_error = payload.getSINGLE();
            obj.aspd_error = payload.getSINGLE();
            obj.xtrack_error = payload.getSINGLE();
            obj.nav_bearing = payload.getINT16();
            obj.target_bearing = payload.getINT16();
            obj.wp_dist = payload.getUINT16();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.nav_roll,2) ~= 1
                result = 'nav_roll';
            elseif size(obj.nav_pitch,2) ~= 1
                result = 'nav_pitch';
            elseif size(obj.alt_error,2) ~= 1
                result = 'alt_error';
            elseif size(obj.aspd_error,2) ~= 1
                result = 'aspd_error';
            elseif size(obj.xtrack_error,2) ~= 1
                result = 'xtrack_error';
            elseif size(obj.nav_bearing,2) ~= 1
                result = 'nav_bearing';
            elseif size(obj.target_bearing,2) ~= 1
                result = 'target_bearing';
            elseif size(obj.wp_dist,2) ~= 1
                result = 'wp_dist';

            else
                result = 0;
            end
        end

        function set.nav_roll(obj,value)
            obj.nav_roll = single(value);
        end
        
        function set.nav_pitch(obj,value)
            obj.nav_pitch = single(value);
        end
        
        function set.alt_error(obj,value)
            obj.alt_error = single(value);
        end
        
        function set.aspd_error(obj,value)
            obj.aspd_error = single(value);
        end
        
        function set.xtrack_error(obj,value)
            obj.xtrack_error = single(value);
        end
        
        function set.nav_bearing(obj,value)
            if value == int16(value)
                obj.nav_bearing = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.target_bearing(obj,value)
            if value == int16(value)
                obj.target_bearing = int16(value);
            else
                mavlink.throwTypeError('value','int16');
            end
        end
        
        function set.wp_dist(obj,value)
            if value == uint16(value)
                obj.wp_dist = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
        
    end

end