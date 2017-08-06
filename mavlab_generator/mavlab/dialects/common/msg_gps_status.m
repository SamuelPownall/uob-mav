classdef msg_gps_status < MAVLinkMessage
	%MSG_GPS_STATUS: MAVLink Message ID = 25
    %Description:
    %    The positioning status, as reported by GPS. This message is intended to display status information about each satellite visible to the receiver. See message GLOBAL_POSITION for the global position estimate. This message can contain information for up to 20 satellites.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    satellites_visible(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    satellites_visible(uint8): Number of satellites visible
    %    satellite_prn(uint8[20]): Global satellite ID
    %    satellite_used(uint8[20]): 0: Satellite not used, 1: used for localization
    %    satellite_elevation(uint8[20]): Elevation (0: right on top of receiver, 90: on the horizon) of satellite
    %    satellite_azimuth(uint8[20]): Direction of satellite, 0: 0 deg, 255: 360 deg.
    %    satellite_snr(uint8[20]): Signal to noise ratio of satellite
	
	properties(Constant)
		ID = 25
		LEN = 101
	end
	
	properties
        satellites_visible	%Number of satellites visible	|	(uint8)
        satellite_prn	%Global satellite ID	|	(uint8[20])
        satellite_used	%0: Satellite not used, 1: used for localization	|	(uint8[20])
        satellite_elevation	%Elevation (0: right on top of receiver, 90: on the horizon) of satellite	|	(uint8[20])
        satellite_azimuth	%Direction of satellite, 0: 0 deg, 255: 360 deg.	|	(uint8[20])
        satellite_snr	%Signal to noise ratio of satellite	|	(uint8[20])
    end

    methods(Static)

        function send(out,satellites_visible,satellite_prn,satellite_used,satellite_elevation,satellite_azimuth,satellite_snr,varargin)

            if nargin == 6 + 1
                msg = msg_gps_status(satellites_visible,satellite_prn,satellite_used,satellite_elevation,satellite_azimuth,satellite_snr,varargin);
            elseif nargin == 2
                msg = msg_gps_status(satellites_visible);
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

        function obj = msg_gps_status(satellites_visible,satellite_prn,satellite_used,satellite_elevation,satellite_azimuth,satellite_snr,varargin)
        %MSG_GPS_STATUS: Create a new gps_status message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(satellites_visible,'MAVLinkPacket')
                    packet = satellites_visible;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('satellites_visible','MAVLinkPacket');
                end
            elseif nargin >= 6 && isempty(varargin{1})
                obj.satellites_visible = satellites_visible;
                obj.satellite_prn = satellite_prn;
                obj.satellite_used = satellite_used;
                obj.satellite_elevation = satellite_elevation;
                obj.satellite_azimuth = satellite_azimuth;
                obj.satellite_snr = satellite_snr;
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

                packet = MAVLinkPacket(msg_gps_status.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_gps_status.ID;
                
                packet.payload.putUINT8(obj.satellites_visible);
                for i=1:1:20
                    packet.payload.putUINT8(obj.satellite_prn(i));
                end
                for i=1:1:20
                    packet.payload.putUINT8(obj.satellite_used(i));
                end
                for i=1:1:20
                    packet.payload.putUINT8(obj.satellite_elevation(i));
                end
                for i=1:1:20
                    packet.payload.putUINT8(obj.satellite_azimuth(i));
                end
                for i=1:1:20
                    packet.payload.putUINT8(obj.satellite_snr(i));
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
            
            obj.satellites_visible = payload.getUINT8();
            for i=1:1:20
                obj.satellite_prn(i) = payload.getUINT8();
            end
            for i=1:1:20
                obj.satellite_used(i) = payload.getUINT8();
            end
            for i=1:1:20
                obj.satellite_elevation(i) = payload.getUINT8();
            end
            for i=1:1:20
                obj.satellite_azimuth(i) = payload.getUINT8();
            end
            for i=1:1:20
                obj.satellite_snr(i) = payload.getUINT8();
            end

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.satellites_visible,2) ~= 1
                result = 'satellites_visible';
            elseif size(obj.satellite_prn,2) ~= 20
                result = 'satellite_prn';
            elseif size(obj.satellite_used,2) ~= 20
                result = 'satellite_used';
            elseif size(obj.satellite_elevation,2) ~= 20
                result = 'satellite_elevation';
            elseif size(obj.satellite_azimuth,2) ~= 20
                result = 'satellite_azimuth';
            elseif size(obj.satellite_snr,2) ~= 20
                result = 'satellite_snr';

            else
                result = 0;
            end
        end

        function set.satellites_visible(obj,value)
            if value == uint8(value)
                obj.satellites_visible = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.satellite_prn(obj,value)
            if value == uint8(value)
                obj.satellite_prn = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.satellite_used(obj,value)
            if value == uint8(value)
                obj.satellite_used = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.satellite_elevation(obj,value)
            if value == uint8(value)
                obj.satellite_elevation = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.satellite_azimuth(obj,value)
            if value == uint8(value)
                obj.satellite_azimuth = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.satellite_snr(obj,value)
            if value == uint8(value)
                obj.satellite_snr = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end