classdef msg_gps2_rtk < mavlink_message
    %MAVLINK Message Class
    %Name: gps2_rtk	ID: 128
    %Description: RTK GPS data. Gives information on the relative baseline calculation the GPS is reporting
            
    properties(Constant)
        ID = 128
        LEN = 35
    end
    
    properties        
		time_last_baseline_ms	%Time since boot of last baseline message received in ms. (uint32[1])
		tow	%GPS Time of Week of last baseline (uint32[1])
		baseline_a_mm	%Current baseline in ECEF x or NED north component in mm. (int32[1])
		baseline_b_mm	%Current baseline in ECEF y or NED east component in mm. (int32[1])
		baseline_c_mm	%Current baseline in ECEF z or NED down component in mm. (int32[1])
		accuracy	%Current estimate of baseline accuracy. (uint32[1])
		iar_num_hypotheses	%Current number of integer ambiguity hypotheses. (int32[1])
		wn	%GPS Week Number of last baseline (uint16[1])
		rtk_receiver_id	%Identification of connected RTK receiver. (uint8[1])
		rtk_health	%GPS-specific health report for RTK data. (uint8[1])
		rtk_rate	%Rate of baseline messages being received by GPS, in HZ (uint8[1])
		nsats	%Current number of sats used for RTK calculation. (uint8[1])
		baseline_coords_type	%Coordinate system of baseline. 0 == ECEF, 1 == NED (uint8[1])
	end

    
    methods
        
        %Constructor: msg_gps2_rtk
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_gps2_rtk(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_gps2_rtk.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_gps2_rtk.ID;
                
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

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
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
            
        function set.time_last_baseline_ms(obj,value)
            if value == uint32(value)
                obj.time_last_baseline_ms = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_rtk.set.time_last_baseline_ms()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.tow(obj,value)
            if value == uint32(value)
                obj.tow = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_rtk.set.tow()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.baseline_a_mm(obj,value)
            if value == int32(value)
                obj.baseline_a_mm = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_rtk.set.baseline_a_mm()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.baseline_b_mm(obj,value)
            if value == int32(value)
                obj.baseline_b_mm = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_rtk.set.baseline_b_mm()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.baseline_c_mm(obj,value)
            if value == int32(value)
                obj.baseline_c_mm = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_rtk.set.baseline_c_mm()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.accuracy(obj,value)
            if value == uint32(value)
                obj.accuracy = uint32(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_rtk.set.accuracy()\n\t Input "value" is not of type "uint32"\n');
            end
        end
                                    
        function set.iar_num_hypotheses(obj,value)
            if value == int32(value)
                obj.iar_num_hypotheses = int32(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_rtk.set.iar_num_hypotheses()\n\t Input "value" is not of type "int32"\n');
            end
        end
                                    
        function set.wn(obj,value)
            if value == uint16(value)
                obj.wn = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_rtk.set.wn()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.rtk_receiver_id(obj,value)
            if value == uint8(value)
                obj.rtk_receiver_id = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_rtk.set.rtk_receiver_id()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.rtk_health(obj,value)
            if value == uint8(value)
                obj.rtk_health = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_rtk.set.rtk_health()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.rtk_rate(obj,value)
            if value == uint8(value)
                obj.rtk_rate = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_rtk.set.rtk_rate()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.nsats(obj,value)
            if value == uint8(value)
                obj.nsats = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_rtk.set.nsats()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.baseline_coords_type(obj,value)
            if value == uint8(value)
                obj.baseline_coords_type = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps2_rtk.set.baseline_coords_type()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end