classdef msg_mount_status < mavlink_message
    %MAVLINK Message Class
    %Name: mount_status	ID: 158
    %Description: Message with some status from APM to GCS about camera or antenna mount
            
    properties(Constant)
        ID = 158
        LEN = 14
    end
    
    properties        
		pointing_a	%pitch(deg*100) (int32)
		pointing_b	%roll(deg*100) (int32)
		pointing_c	%yaw(deg*100) (int32)
		target_system	%System ID (uint8)
		target_component	%Component ID (uint8)
	end
    
    methods
        
        %Constructor: msg_mount_status
        %packet should be a fully constructed MAVLINK packet                
		function obj = msg_mount_status(packet,pointing_a,pointing_b,pointing_c,target_system,target_component)
        
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
                
            elseif nargin == 6
                
				obj.pointing_a = pointing_a;
				obj.pointing_b = pointing_b;
				obj.pointing_c = pointing_c;
				obj.target_system = target_system;
				obj.target_component = target_component;
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
                        
        %Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(msg_mount_status.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = msg_mount_status.ID;
                
				packet.payload.putINT32(obj.pointing_a);

				packet.payload.putINT32(obj.pointing_b);

				packet.payload.putINT32(obj.pointing_c);

				packet.payload.putUINT8(obj.target_system);

				packet.payload.putUINT8(obj.target_component);
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
                        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        
			obj.pointing_a = payload.getINT32();

			obj.pointing_b = payload.getINT32();

			obj.pointing_c = payload.getINT32();

			obj.target_system = payload.getUINT8();

			obj.target_component = payload.getUINT8();

		end
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
                            
            if size(obj.pointing_a,2) ~= 1
                result = 'pointing_a';                                        
            elseif size(obj.pointing_b,2) ~= 1
                result = 'pointing_b';                                        
            elseif size(obj.pointing_c,2) ~= 1
                result = 'pointing_c';                                        
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';                                        
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';                            
            else
                result = 0;
            end
            
        end
                                
        function set.pointing_a(obj,value)
            if value == int32(value)
                obj.pointing_a = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                                    
        function set.pointing_b(obj,value)
            if value == int32(value)
                obj.pointing_b = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                                    
        function set.pointing_c(obj,value)
            if value == int32(value)
                obj.pointing_c = int32(value);
            else
                mavlink.throwTypeError('value','int32');
            end
        end
                                    
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                                    
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                mavlink.throwTypeError('value','uint8');
            end
        end
                        
	end
end