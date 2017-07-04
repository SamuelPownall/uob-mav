classdef msg_gps_rtcm_data < mavlink_message
    %MAVLINK Message Class
    %Name: gps_rtcm_data	ID: 233
    %Description: WORK IN PROGRESS! RTCM message for injecting into the onboard GPS (used for DGPS)
            
    properties(Constant)
        ID = 233
        LEN = 182
    end
    
    properties        
		flags	%LSB: 1 means message is fragmented (uint8)
		len	%data length (uint8)
		data	%RTCM message (may be fragmented) (uint8[180])
	end
    
    methods
        
        %Constructor: msg_gps_rtcm_data
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_gps_rtcm_data(packet,flags,len,data)
        
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
                
            elseif nargin == 4
                
				obj.flags = flags;
				obj.len = len;
				obj.data = data;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_gps_rtcm_data.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_gps_rtcm_data.ID;
                
				packet.payload.putUINT8(obj.flags);

				packet.payload.putUINT8(obj.len);
            
                for i = 1:180
                    packet.payload.putUINT8(obj.data(i));
                end
                                        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.flags = payload.getUINT8();

			obj.len = payload.getUINT8();
            
            for i = 1:180
                obj.data(i) = payload.getUINT8();
            end
                            
		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.flags,2) ~= 1
                result = 'flags';                                        
            elseif size(obj.len,2) ~= 1
                result = 'len';                                        
            elseif size(obj.data,2) ~= 180
                result = 'data';                            
            else
                result = 0;
            end
            
        end
                                
        function set.flags(obj,value)
            if value == uint8(value)
                obj.flags = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.len(obj,value)
            if value == uint8(value)
                obj.len = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.data(obj,value)
            if value == uint8(value)
                obj.data = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end