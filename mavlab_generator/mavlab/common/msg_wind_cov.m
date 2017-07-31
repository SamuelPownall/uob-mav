classdef msg_wind_cov < mavlink_message
	%MSG_WIND_COV: MAVLINK Message ID = 231
    %Description:
    %    No description available
    %    Can also be constructed by using a mavlink_packet as the only argument
	%Arguments:
    %    time_usec(mavlink_packet): Alternative way to construct a message using a mavlink_packet
    %    time_usec(uint64): Timestamp (micros since boot or Unix epoch)
    %    wind_x(single): Wind in X (NED) direction in m/s
    %    wind_y(single): Wind in Y (NED) direction in m/s
    %    wind_z(single): Wind in Z (NED) direction in m/s
    %    var_horiz(single): Variability of the wind in XY. RMS of a 1 Hz lowpassed wind estimate.
    %    var_vert(single): Variability of the wind in Z. RMS of a 1 Hz lowpassed wind estimate.
    %    wind_alt(single): AMSL altitude (m) this measurement was taken at
    %    horiz_accuracy(single): Horizontal speed 1-STD accuracy
    %    vert_accuracy(single): Vertical speed 1-STD accuracy
	
	properties(Constant)
		ID = 231
		LEN = 40
	end
	
	properties
        time_usec	%Timestamp (micros since boot or Unix epoch)	|	(uint64)
        wind_x	%Wind in X (NED) direction in m/s	|	(single)
        wind_y	%Wind in Y (NED) direction in m/s	|	(single)
        wind_z	%Wind in Z (NED) direction in m/s	|	(single)
        var_horiz	%Variability of the wind in XY. RMS of a 1 Hz lowpassed wind estimate.	|	(single)
        var_vert	%Variability of the wind in Z. RMS of a 1 Hz lowpassed wind estimate.	|	(single)
        wind_alt	%AMSL altitude (m) this measurement was taken at	|	(single)
        horiz_accuracy	%Horizontal speed 1-STD accuracy	|	(single)
        vert_accuracy	%Vertical speed 1-STD accuracy	|	(single)
    end

    methods

        function obj = msg_wind_cov(time_usec,wind_x,wind_y,wind_z,var_horiz,var_vert,wind_alt,horiz_accuracy,vert_accuracy,varargin)
        %Create a new wind_cov message
        
            obj.msgid = obj.ID;
            obj.sysid = mavlink.SYSID;
            obj.compid = mavlink.COMPID;

            if nargin == 1
            
                if isa(time_usec,'mavlink_packet')
                    packet = time_usec;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    mavlink.throwTypeError('time_usec','mavlink_packet');
                end
            
            elseif nargin == 9
                obj.time_usec = time_usec;
                obj.wind_x = wind_x;
                obj.wind_y = wind_y;
                obj.wind_z = wind_z;
                obj.var_horiz = var_horiz;
                obj.var_vert = var_vert;
                obj.wind_alt = wind_alt;
                obj.horiz_accuracy = horiz_accuracy;
                obj.vert_accuracy = vert_accuracy;
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

                packet = mavlink_packet(msg_wind_cov.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_wind_cov.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                packet.payload.putSINGLE(obj.wind_x);
                packet.payload.putSINGLE(obj.wind_y);
                packet.payload.putSINGLE(obj.wind_z);
                packet.payload.putSINGLE(obj.var_horiz);
                packet.payload.putSINGLE(obj.var_vert);
                packet.payload.putSINGLE(obj.wind_alt);
                packet.payload.putSINGLE(obj.horiz_accuracy);
                packet.payload.putSINGLE(obj.vert_accuracy);

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
            obj.wind_x = payload.getSINGLE();
            obj.wind_y = payload.getSINGLE();
            obj.wind_z = payload.getSINGLE();
            obj.var_horiz = payload.getSINGLE();
            obj.var_vert = payload.getSINGLE();
            obj.wind_alt = payload.getSINGLE();
            obj.horiz_accuracy = payload.getSINGLE();
            obj.vert_accuracy = payload.getSINGLE();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.wind_x,2) ~= 1
                result = 'wind_x';
            elseif size(obj.wind_y,2) ~= 1
                result = 'wind_y';
            elseif size(obj.wind_z,2) ~= 1
                result = 'wind_z';
            elseif size(obj.var_horiz,2) ~= 1
                result = 'var_horiz';
            elseif size(obj.var_vert,2) ~= 1
                result = 'var_vert';
            elseif size(obj.wind_alt,2) ~= 1
                result = 'wind_alt';
            elseif size(obj.horiz_accuracy,2) ~= 1
                result = 'horiz_accuracy';
            elseif size(obj.vert_accuracy,2) ~= 1
                result = 'vert_accuracy';

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
        
        function set.wind_x(obj,value)
            obj.wind_x = single(value);
        end
        
        function set.wind_y(obj,value)
            obj.wind_y = single(value);
        end
        
        function set.wind_z(obj,value)
            obj.wind_z = single(value);
        end
        
        function set.var_horiz(obj,value)
            obj.var_horiz = single(value);
        end
        
        function set.var_vert(obj,value)
            obj.var_vert = single(value);
        end
        
        function set.wind_alt(obj,value)
            obj.wind_alt = single(value);
        end
        
        function set.horiz_accuracy(obj,value)
            obj.horiz_accuracy = single(value);
        end
        
        function set.vert_accuracy(obj,value)
            obj.vert_accuracy = single(value);
        end
        
    end

end