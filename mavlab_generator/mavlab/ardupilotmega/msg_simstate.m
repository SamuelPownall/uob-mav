classdef msg_simstate < mavlink_message
    %MAVLINK Message Class
    %Name: simstate	ID: 164
    %Description: Status of simulation environment, if used
            
    properties(Constant)
        ID = 164
        LEN = 44
    end
    
    properties        
		roll	%Roll angle (rad) (single)
		pitch	%Pitch angle (rad) (single)
		yaw	%Yaw angle (rad) (single)
		xacc	%X acceleration m/s/s (single)
		yacc	%Y acceleration m/s/s (single)
		zacc	%Z acceleration m/s/s (single)
		xgyro	%Angular speed around X axis rad/s (single)
		ygyro	%Angular speed around Y axis rad/s (single)
		zgyro	%Angular speed around Z axis rad/s (single)
		lat	%Latitude in degrees * 1E7 (int32)
		lng	%Longitude in degrees * 1E7 (int32)
	end
    
    methods
        
        %Constructor: msg_simstate
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_simstate(packet,roll,pitch,yaw,xacc,yacc,zacc,xgyro,ygyro,zgyro,lat,lng)
        
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
                
            elseif nargin == 12
                
				obj.roll = roll;
				obj.pitch = pitch;
				obj.yaw = yaw;
				obj.xacc = xacc;
				obj.yacc = yacc;
				obj.zacc = zacc;
				obj.xgyro = xgyro;
				obj.ygyro = ygyro;
				obj.zgyro = zgyro;
				obj.lat = lat;
				obj.lng = lng;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_simstate.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_simstate.ID;
                
				packet.payload.putSINGLE(obj.roll);

				packet.payload.putSINGLE(obj.pitch);

				packet.payload.putSINGLE(obj.yaw);

				packet.payload.putSINGLE(obj.xacc);

				packet.payload.putSINGLE(obj.yacc);

				packet.payload.putSINGLE(obj.zacc);

				packet.payload.putSINGLE(obj.xgyro);

				packet.payload.putSINGLE(obj.ygyro);

				packet.payload.putSINGLE(obj.zgyro);

				packet.payload.putINT32(obj.lat);

				packet.payload.putINT32(obj.lng);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.roll = payload.getSINGLE();

			obj.pitch = payload.getSINGLE();

			obj.yaw = payload.getSINGLE();

			obj.xacc = payload.getSINGLE();

			obj.yacc = payload.getSINGLE();

			obj.zacc = payload.getSINGLE();

			obj.xgyro = payload.getSINGLE();

			obj.ygyro = payload.getSINGLE();

			obj.zgyro = payload.getSINGLE();

			obj.lat = payload.getINT32();

			obj.lng = payload.getINT32();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.roll,2) ~= 1
                result = 'roll';                                        
            elseif size(obj.pitch,2) ~= 1
                result = 'pitch';                                        
            elseif size(obj.yaw,2) ~= 1
                result = 'yaw';                                        
            elseif size(obj.xacc,2) ~= 1
                result = 'xacc';                                        
            elseif size(obj.yacc,2) ~= 1
                result = 'yacc';                                        
            elseif size(obj.zacc,2) ~= 1
                result = 'zacc';                                        
            elseif size(obj.xgyro,2) ~= 1
                result = 'xgyro';                                        
            elseif size(obj.ygyro,2) ~= 1
                result = 'ygyro';                                        
            elseif size(obj.zgyro,2) ~= 1
                result = 'zgyro';                                        
            elseif size(obj.lat,2) ~= 1
                result = 'lat';                                        
            elseif size(obj.lng,2) ~= 1
                result = 'lng';                            
            else
                result = 0;
            end
            
        end
                            
        function set.roll(obj,value)
            obj.roll = single(value);
        end
                                
        function set.pitch(obj,value)
            obj.pitch = single(value);
        end
                                
        function set.yaw(obj,value)
            obj.yaw = single(value);
        end
                                
        function set.xacc(obj,value)
            obj.xacc = single(value);
        end
                                
        function set.yacc(obj,value)
            obj.yacc = single(value);
        end
                                
        function set.zacc(obj,value)
            obj.zacc = single(value);
        end
                                
        function set.xgyro(obj,value)
            obj.xgyro = single(value);
        end
                                
        function set.ygyro(obj,value)
            obj.ygyro = single(value);
        end
                                
        function set.zgyro(obj,value)
            obj.zgyro = single(value);
        end
                                    
        function set.lat(obj,value)
            if value == int32(value)
                obj.lat = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                                    
        function set.lng(obj,value)
            if value == int32(value)
                obj.lng = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                        
	end
end