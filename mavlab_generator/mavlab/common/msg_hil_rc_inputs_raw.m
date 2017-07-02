classdef msg_hil_rc_inputs_raw < mavlink_message
    %MAVLINK Message Class
    %Name: hil_rc_inputs_raw	ID: 92
    %Description: Sent from simulation to autopilot. The RAW values of the RC channels received. The standard PPM modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters might violate this specification.
            
    properties(Constant)
        ID = 92
        LEN = 33
    end
    
    properties        
		time_usec	%Timestamp (microseconds since UNIX epoch or microseconds since system boot) (uint64[1])
		chan1_raw	%RC channel 1 value, in microseconds (uint16[1])
		chan2_raw	%RC channel 2 value, in microseconds (uint16[1])
		chan3_raw	%RC channel 3 value, in microseconds (uint16[1])
		chan4_raw	%RC channel 4 value, in microseconds (uint16[1])
		chan5_raw	%RC channel 5 value, in microseconds (uint16[1])
		chan6_raw	%RC channel 6 value, in microseconds (uint16[1])
		chan7_raw	%RC channel 7 value, in microseconds (uint16[1])
		chan8_raw	%RC channel 8 value, in microseconds (uint16[1])
		chan9_raw	%RC channel 9 value, in microseconds (uint16[1])
		chan10_raw	%RC channel 10 value, in microseconds (uint16[1])
		chan11_raw	%RC channel 11 value, in microseconds (uint16[1])
		chan12_raw	%RC channel 12 value, in microseconds (uint16[1])
		rssi	%Receive signal strength indicator, 0: 0%, 255: 100% (uint8[1])
	end

    
    methods
        
        %Constructor: msg_hil_rc_inputs_raw
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_hil_rc_inputs_raw(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            packet = mavlink_packet(msg_hil_rc_inputs_raw.LEN);
            packet.sysid = mavlink.SYSID;
            packet.compid = mavlink.COMPID;
            packet.msgid = msg_hil_rc_inputs_raw.ID;
                
			packet.payload.putUINT64(obj.time_usec);

			packet.payload.putUINT16(obj.chan1_raw);

			packet.payload.putUINT16(obj.chan2_raw);

			packet.payload.putUINT16(obj.chan3_raw);

			packet.payload.putUINT16(obj.chan4_raw);

			packet.payload.putUINT16(obj.chan5_raw);

			packet.payload.putUINT16(obj.chan6_raw);

			packet.payload.putUINT16(obj.chan7_raw);

			packet.payload.putUINT16(obj.chan8_raw);

			packet.payload.putUINT16(obj.chan9_raw);

			packet.payload.putUINT16(obj.chan10_raw);

			packet.payload.putUINT16(obj.chan11_raw);

			packet.payload.putUINT16(obj.chan12_raw);

			packet.payload.putUINT8(obj.rssi);

		end
        
        %%Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.time_usec = payload.getUINT64();

			obj.chan1_raw = payload.getUINT16();

			obj.chan2_raw = payload.getUINT16();

			obj.chan3_raw = payload.getUINT16();

			obj.chan4_raw = payload.getUINT16();

			obj.chan5_raw = payload.getUINT16();

			obj.chan6_raw = payload.getUINT16();

			obj.chan7_raw = payload.getUINT16();

			obj.chan8_raw = payload.getUINT16();

			obj.chan9_raw = payload.getUINT16();

			obj.chan10_raw = payload.getUINT16();

			obj.chan11_raw = payload.getUINT16();

			obj.chan12_raw = payload.getUINT16();

			obj.rssi = payload.getUINT8();

		end
            
        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_rc_inputs_raw.set.time_usec()\n\t Input "value" is not of type "uint64"\n');
            end
        end
                                    
        function set.chan1_raw(obj,value)
            if value == uint16(value)
                obj.chan1_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_rc_inputs_raw.set.chan1_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan2_raw(obj,value)
            if value == uint16(value)
                obj.chan2_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_rc_inputs_raw.set.chan2_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan3_raw(obj,value)
            if value == uint16(value)
                obj.chan3_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_rc_inputs_raw.set.chan3_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan4_raw(obj,value)
            if value == uint16(value)
                obj.chan4_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_rc_inputs_raw.set.chan4_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan5_raw(obj,value)
            if value == uint16(value)
                obj.chan5_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_rc_inputs_raw.set.chan5_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan6_raw(obj,value)
            if value == uint16(value)
                obj.chan6_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_rc_inputs_raw.set.chan6_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan7_raw(obj,value)
            if value == uint16(value)
                obj.chan7_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_rc_inputs_raw.set.chan7_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan8_raw(obj,value)
            if value == uint16(value)
                obj.chan8_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_rc_inputs_raw.set.chan8_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan9_raw(obj,value)
            if value == uint16(value)
                obj.chan9_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_rc_inputs_raw.set.chan9_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan10_raw(obj,value)
            if value == uint16(value)
                obj.chan10_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_rc_inputs_raw.set.chan10_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan11_raw(obj,value)
            if value == uint16(value)
                obj.chan11_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_rc_inputs_raw.set.chan11_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.chan12_raw(obj,value)
            if value == uint16(value)
                obj.chan12_raw = uint16(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_rc_inputs_raw.set.chan12_raw()\n\t Input "value" is not of type "uint16"\n');
            end
        end
                                    
        function set.rssi(obj,value)
            if value == uint8(value)
                obj.rssi = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | hil_rc_inputs_raw.set.rssi()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end