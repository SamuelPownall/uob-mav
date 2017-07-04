classdef msg_wind_cov < mavlink_message
    %MAVLINK Message Class
    %Name: wind_cov	ID: 231
    %Description: None
            
    properties(Constant)
        ID = 231
        LEN = 40
    end
    
    properties        
		time_usec	%Timestamp (micros since boot or Unix epoch) (uint64)
		wind_x	%Wind in X (NED) direction in m/s (single)
		wind_y	%Wind in Y (NED) direction in m/s (single)
		wind_z	%Wind in Z (NED) direction in m/s (single)
		var_horiz	%Variability of the wind in XY. RMS of a 1 Hz lowpassed wind estimate. (single)
		var_vert	%Variability of the wind in Z. RMS of a 1 Hz lowpassed wind estimate. (single)
		wind_alt	%AMSL altitude (m) this measurement was taken at (single)
		horiz_accuracy	%Horizontal speed 1-STD accuracy (single)
		vert_accuracy	%Vertical speed 1-STD accuracy (single)
	end
    
    methods
        
        %Constructor: msg_wind_cov
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_wind_cov(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
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
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
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
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_usec,2) ~= 1
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