classdef msg_hil_rc_inputs_raw < mavlink_message
    %MAVLINK Message Class
    %Name: hil_rc_inputs_raw	ID: 92
    %Description: Sent from simulation to autopilot. The RAW values of the RC channels received. The standard PPM modulation is as follows: 1000 microseconds: 0%, 2000 microseconds: 100%. Individual receivers/transmitters might violate this specification.
            
    properties(Constant)
        ID = 92
        LEN = 33
    end
    
    properties        
		time_usec	%Timestamp (microseconds since UNIX epoch or microseconds since system boot) (uint64)
		chan1_raw	%RC channel 1 value, in microseconds (uint16)
		chan2_raw	%RC channel 2 value, in microseconds (uint16)
		chan3_raw	%RC channel 3 value, in microseconds (uint16)
		chan4_raw	%RC channel 4 value, in microseconds (uint16)
		chan5_raw	%RC channel 5 value, in microseconds (uint16)
		chan6_raw	%RC channel 6 value, in microseconds (uint16)
		chan7_raw	%RC channel 7 value, in microseconds (uint16)
		chan8_raw	%RC channel 8 value, in microseconds (uint16)
		chan9_raw	%RC channel 9 value, in microseconds (uint16)
		chan10_raw	%RC channel 10 value, in microseconds (uint16)
		chan11_raw	%RC channel 11 value, in microseconds (uint16)
		chan12_raw	%RC channel 12 value, in microseconds (uint16)
		rssi	%Receive signal strength indicator, 0: 0%, 255: 100% (uint8)
	end
    
    methods
        
        %Constructor: msg_hil_rc_inputs_raw
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_hil_rc_inputs_raw(packet,time_usec,chan1_raw,chan2_raw,chan3_raw,chan4_raw,chan5_raw,chan6_raw,chan7_raw,chan8_raw,chan9_raw,chan10_raw,chan11_raw,chan12_raw,rssi)
        
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
                
            elseif nargin == 15
                
				obj.time_usec = time_usec;
				obj.chan1_raw = chan1_raw;
				obj.chan2_raw = chan2_raw;
				obj.chan3_raw = chan3_raw;
				obj.chan4_raw = chan4_raw;
				obj.chan5_raw = chan5_raw;
				obj.chan6_raw = chan6_raw;
				obj.chan7_raw = chan7_raw;
				obj.chan8_raw = chan8_raw;
				obj.chan9_raw = chan9_raw;
				obj.chan10_raw = chan10_raw;
				obj.chan11_raw = chan11_raw;
				obj.chan12_raw = chan12_raw;
				obj.rssi = rssi;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
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
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
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
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.time_usec,2) ~= 1
                result = 'time_usec';                                        
            elseif size(obj.chan1_raw,2) ~= 1
                result = 'chan1_raw';                                        
            elseif size(obj.chan2_raw,2) ~= 1
                result = 'chan2_raw';                                        
            elseif size(obj.chan3_raw,2) ~= 1
                result = 'chan3_raw';                                        
            elseif size(obj.chan4_raw,2) ~= 1
                result = 'chan4_raw';                                        
            elseif size(obj.chan5_raw,2) ~= 1
                result = 'chan5_raw';                                        
            elseif size(obj.chan6_raw,2) ~= 1
                result = 'chan6_raw';                                        
            elseif size(obj.chan7_raw,2) ~= 1
                result = 'chan7_raw';                                        
            elseif size(obj.chan8_raw,2) ~= 1
                result = 'chan8_raw';                                        
            elseif size(obj.chan9_raw,2) ~= 1
                result = 'chan9_raw';                                        
            elseif size(obj.chan10_raw,2) ~= 1
                result = 'chan10_raw';                                        
            elseif size(obj.chan11_raw,2) ~= 1
                result = 'chan11_raw';                                        
            elseif size(obj.chan12_raw,2) ~= 1
                result = 'chan12_raw';                                        
            elseif size(obj.rssi,2) ~= 1
                result = 'rssi';                            
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
                                    
        function set.chan1_raw(obj,value)
            if value == uint16(value)
                obj.chan1_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan2_raw(obj,value)
            if value == uint16(value)
                obj.chan2_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan3_raw(obj,value)
            if value == uint16(value)
                obj.chan3_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan4_raw(obj,value)
            if value == uint16(value)
                obj.chan4_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan5_raw(obj,value)
            if value == uint16(value)
                obj.chan5_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan6_raw(obj,value)
            if value == uint16(value)
                obj.chan6_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan7_raw(obj,value)
            if value == uint16(value)
                obj.chan7_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan8_raw(obj,value)
            if value == uint16(value)
                obj.chan8_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan9_raw(obj,value)
            if value == uint16(value)
                obj.chan9_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan10_raw(obj,value)
            if value == uint16(value)
                obj.chan10_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan11_raw(obj,value)
            if value == uint16(value)
                obj.chan11_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.chan12_raw(obj,value)
            if value == uint16(value)
                obj.chan12_raw = uint16(value);
            else
                mavlink.throwTypeError('value','uint16');
            end
        end
                                    
        function set.rssi(obj,value)
            if value == uint8(value)
                obj.rssi = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end