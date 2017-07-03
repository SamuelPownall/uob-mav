classdef msg_gps_status < mavlink_message
    %MAVLINK Message Class
    %Name: gps_status	ID: 25
    %Description: The positioning status, as reported by GPS. This message is intended to display status information about each satellite visible to the receiver. See message GLOBAL_POSITION for the global position estimate. This message can contain information for up to 20 satellites.
            
    properties(Constant)
        ID = 25
        LEN = 101
    end
    
    properties        
		satellites_visible	%Number of satellites visible (uint8)
		satellite_prn	%Global satellite ID (uint8[20])
		satellite_used	%0: Satellite not used, 1: used for localization (uint8[20])
		satellite_elevation	%Elevation (0: right on top of receiver, 90: on the horizon) of satellite (uint8[20])
		satellite_azimuth	%Direction of satellite, 0: 0 deg, 255: 360 deg. (uint8[20])
		satellite_snr	%Signal to noise ratio of satellite (uint8[20])
	end
    
    methods
        
        %Constructor: msg_gps_status
        %packet should be a fully constructed MAVLINK packet
        function obj = msg_gps_status(packet)
        
            obj.msgid = obj.ID;
            if nargin == 1
                obj.sysid = packet.sysid;
                obj.compid = packet.compid;
                obj.unpack(packet.payload)
            end
            
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            emptyField = obj.verify();
            if emptyField == 0
        
                packet = mavlink_packet(msg_gps_status.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_gps_status.ID;
                
				packet.payload.putUINT8(obj.satellites_visible);
            
                for i = 1:20
                    packet.payload.putUINT8(obj.satellite_prn(i));
                end
                                            
                for i = 1:20
                    packet.payload.putUINT8(obj.satellite_used(i));
                end
                                            
                for i = 1:20
                    packet.payload.putUINT8(obj.satellite_elevation(i));
                end
                                            
                for i = 1:20
                    packet.payload.putUINT8(obj.satellite_azimuth(i));
                end
                                            
                for i = 1:20
                    packet.payload.putUINT8(obj.satellite_snr(i));
                end
                                        
            else
                packet = [];
                fprintf(2,'MAVLAB-ERROR | msg_gps_status.pack()\n\t Message data in "%s" is not valid\n',emptyField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.satellites_visible = payload.getUINT8();
            
            for i = 1:20
                obj.satellite_prn(i) = payload.getUINT8();
            end
                                        
            for i = 1:20
                obj.satellite_used(i) = payload.getUINT8();
            end
                                        
            for i = 1:20
                obj.satellite_elevation(i) = payload.getUINT8();
            end
                                        
            for i = 1:20
                obj.satellite_azimuth(i) = payload.getUINT8();
            end
                                        
            for i = 1:20
                obj.satellite_snr(i) = payload.getUINT8();
            end
                            
		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.satellites_visible,2) ~= 1
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
                fprintf(2,'MAVLAB-ERROR | gps_status.set.satellites_visible()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.satellite_prn(obj,value)
            if value == uint8(value)
                obj.satellite_prn = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps_status.set.satellite_prn()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.satellite_used(obj,value)
            if value == uint8(value)
                obj.satellite_used = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps_status.set.satellite_used()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.satellite_elevation(obj,value)
            if value == uint8(value)
                obj.satellite_elevation = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps_status.set.satellite_elevation()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.satellite_azimuth(obj,value)
            if value == uint8(value)
                obj.satellite_azimuth = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps_status.set.satellite_azimuth()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                                    
        function set.satellite_snr(obj,value)
            if value == uint8(value)
                obj.satellite_snr = uint8(value);
            else
                fprintf(2,'MAVLAB-ERROR | gps_status.set.satellite_snr()\n\t Input "value" is not of type "uint8"\n');
            end
        end
                        
	end
end