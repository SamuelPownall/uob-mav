classdef msg_gps_rtk < mavlink_message
    %MAVLINK Message Class
    %Name: gps_rtk	ID: 127
    %Description: RTK GPS data. Gives information on the relative baseline calculation the GPS is reporting
            
    properties(Constant)
        ID = 127
        LEN = 35
    end
    
    properties        
		time_last_baseline_ms	%Time since boot of last baseline message received in ms. (uint32)
		tow	%GPS Time of Week of last baseline (uint32)
		baseline_a_mm	%Current baseline in ECEF x or NED north component in mm. (int32)
		baseline_b_mm	%Current baseline in ECEF y or NED east component in mm. (int32)
		baseline_c_mm	%Current baseline in ECEF z or NED down component in mm. (int32)
		accuracy	%Current estimate of baseline accuracy. (uint32)
		iar_num_hypotheses	%Current number of integer ambiguity hypotheses. (int32)
		wn	%GPS Week Number of last baseline (uint16)
		rtk_receiver_id	%Identification of connected RTK receiver. (uint8)
		rtk_health	%GPS-specific health report for RTK data. (uint8)
		rtk_rate	%Rate of baseline messages being received by GPS, in HZ (uint8)
		nsats	%Current number of sats used for RTK calculation. (uint8)
		baseline_coords_type	%Coordinate system of baseline. 0 == ECEF, 1 == NED (uint8)
	end
    
    methods
        
        %Constructor: msg_gps_rtk
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_gps_rtk(packet)
        
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
        
                packet = mavlink_packet(msg_gps_rtk.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_gps_rtk.ID;
                
				packet.payload.putUINT32(obj.time_last_baseline_ms);

				packet.payload.putUINT32(obj.tow);

				packet.payload.putINT32(obj.baseline_a_mm);

				packet.payload.putINT32(obj.baseline_b_mm);

				packet.payload.putINT32(obj.baseline_c_mm);

				packet.payload.putUINT32(obj.accuracy);

				packet.payload.putINT32(obj.iar_num_hypotheses);

				packet.payload.putUINT16(obj.wn);

				packet.payload.putUINT8(obj.rtk_receiver_id);

				packet.payload.putUINT8(obj.rtk_health);

				packet.payload.putUINT8(obj.rtk_rate);

				packet.payload.putUINT8(obj.nsats);

				packet.payload.putUINT8(obj.baseline_coords_type);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_last_baseline_ms = payload.getUINT32();

			obj.tow = payload.getUINT32();

			obj.baseline_a_mm = payload.getINT32();

			obj.baseline_b_mm = payload.getINT32();

			obj.baseline_c_mm = payload.getINT32();

			obj.accuracy = payload.getUINT32();

			obj.iar_num_hypotheses = payload.getINT32();

			obj.wn = payload.getUINT16();

			obj.rtk_receiver_id = payload.getUINT8();

			obj.rtk_health = payload.getUINT8();

			obj.rtk_rate = payload.getUINT8();

			obj.nsats = payload.getUINT8();

			obj.baseline_coords_type = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_last_baseline_ms,2) ~= 1
                result = 'time_last_baseline_ms';                                        
            elseif size(obj.tow,2) ~= 1
                result = 'tow';                                        
            elseif size(obj.baseline_a_mm,2) ~= 1
                result = 'baseline_a_mm';                                        
            elseif size(obj.baseline_b_mm,2) ~= 1
                result = 'baseline_b_mm';                                        
            elseif size(obj.baseline_c_mm,2) ~= 1
                result = 'baseline_c_mm';                                        
            elseif size(obj.accuracy,2) ~= 1
                result = 'accuracy';                                        
            elseif size(obj.iar_num_hypotheses,2) ~= 1
                result = 'iar_num_hypotheses';                                        
            elseif size(obj.wn,2) ~= 1
                result = 'wn';                                        
            elseif size(obj.rtk_receiver_id,2) ~= 1
                result = 'rtk_receiver_id';                                        
            elseif size(obj.rtk_health,2) ~= 1
                result = 'rtk_health';                                        
            elseif size(obj.rtk_rate,2) ~= 1
                result = 'rtk_rate';                                        
            elseif size(obj.nsats,2) ~= 1
                result = 'nsats';                                        
            elseif size(obj.baseline_coords_type,2) ~= 1
                result = 'baseline_coords_type';                            
            else
                result = 0;
            end
            
        end
                                
        function set.time_last_baseline_ms(obj,value)
            if value == uint32(value)
                obj.time_last_baseline_ms = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
                                    
        function set.tow(obj,value)
            if value == uint32(value)
                obj.tow = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
                                    
        function set.baseline_a_mm(obj,value)
            if value == int32(value)
                obj.baseline_a_mm = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                                    
        function set.baseline_b_mm(obj,value)
            if value == int32(value)
                obj.baseline_b_mm = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                                    
        function set.baseline_c_mm(obj,value)
            if value == int32(value)
                obj.baseline_c_mm = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                                    
        function set.accuracy(obj,value)
            if value == uint32(value)
                obj.accuracy = uint32(value);
            else
                mavlink.throwTypeError('value','uint32');
            end
        end
                                    
        function set.iar_num_hypotheses(obj,value)
            if value == int32(value)
                obj.iar_num_hypotheses = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                                    
        function set.wn(obj,value)
            if value == uint16(value)
                obj.wn = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.rtk_receiver_id(obj,value)
            if value == uint8(value)
                obj.rtk_receiver_id = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.rtk_health(obj,value)
            if value == uint8(value)
                obj.rtk_health = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.rtk_rate(obj,value)
            if value == uint8(value)
                obj.rtk_rate = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.nsats(obj,value)
            if value == uint8(value)
                obj.nsats = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.baseline_coords_type(obj,value)
            if value == uint8(value)
                obj.baseline_coords_type = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end