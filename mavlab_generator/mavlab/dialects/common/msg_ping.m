classdef msg_ping < MAVLinkMessage
	%MSG_PING: MAVLink Message ID = 4
    %Description:
    %    A ping message either requesting or responding to a ping. This allows to measure the system latencies, including serial port, radio modem and UDP connections.
    %    Can also be constructed by using a MAVLinkPacket as the only argument
	%Arguments:
    %    time_usec(MAVLinkPacket): Alternative way to construct a message using a MAVLinkPacket
    %    time_usec(uint64): Unix timestamp in microseconds or since system boot if smaller than MAVLink epoch (1.1.2009)
    %    seq(uint32): PING sequence
    %    target_system(uint8): 0: request ping from all receiving systems, if greater than 0: message is a ping response and number is the system id of the requesting system
    %    target_component(uint8): 0: request ping from all receiving components, if greater than 0: message is a ping response and number is the system id of the requesting system
	
	properties(Constant)
		ID = 4
		LEN = 14
	end
	
	properties
        time_usec	%Unix timestamp in microseconds or since system boot if smaller than MAVLink epoch (1.1.2009)	|	(uint64)
        seq	%PING sequence	|	(uint32)
        target_system	%0: request ping from all receiving systems, if greater than 0: message is a ping response and number is the system id of the requesting system	|	(uint8)
        target_component	%0: request ping from all receiving components, if greater than 0: message is a ping response and number is the system id of the requesting system	|	(uint8)
    end

    methods(Static)

        function send(out,time_usec,seq,target_system,target_component,varargin)

            if nargin == 4 + 1
                msg = msg_ping(time_usec,seq,target_system,target_component,varargin);
            elseif nargin == 2
                msg = msg_ping(time_usec);
            else
                MAVLink.throwCustomError('The number of function arguments is not valid');
                return;
            end

            packet = msg.pack();
            if ~isempty(packet)
                buffer = packet.encode();
                write(out,buffer);
            else
                MAVLink.throwCustomError('The packet could not be verified');
            end
        
        end

    end

    methods

        function obj = msg_ping(time_usec,seq,target_system,target_component,varargin)
        %MSG_PING: Create a new ping message object
        
            obj.msgid = obj.ID;
            obj.sysid = MAVLink.SYSID;
            obj.compid = MAVLink.COMPID;

            if nargin == 1 
                if isa(time_usec,'MAVLinkPacket')
                    packet = time_usec;
                    obj.sysid = packet.sysid;
                    obj.compid = packet.compid;
                    obj.unpack(packet.payload);
                else
                    MAVLink.throwTypeError('time_usec','MAVLinkPacket');
                end
            elseif nargin >= 4 && isempty(varargin{1})
                obj.time_usec = time_usec;
                obj.seq = seq;
                obj.target_system = target_system;
                obj.target_component = target_component;
            elseif nargin ~= 0
                MAVLink.throwCustomError('The number of constructer arguments is not valid');
            end

        end

        function packet = pack(obj)
        %PACK: Packs this MAVLink message into a MAVLinkPacket
        %Description:
        %    Packs the fields of a message into a MAVLinkPacket which can be encoded
        %    for transmission.

            errorField = obj.verify();
            if errorField == 0

                packet = MAVLinkPacket(msg_ping.LEN);
                packet.sysid = MAVLink.SYSID;
                packet.compid = MAVLink.COMPID;
                packet.msgid = msg_ping.ID;
                
                packet.payload.putUINT64(obj.time_usec);
                packet.payload.putUINT32(obj.seq);
                packet.payload.putUINT8(obj.target_system);
                packet.payload.putUINT8(obj.target_component);

            else
                packet = [];
                MAVLink.throwPackingError(errorField);
            end

        end

        function unpack(obj, payload)
        %UNPACK: Unpacks a MAVLinkPayload into this MAVLink message
        %Description:
        %    Extracts the data from a MAVLinkPayload and attempts to store it in the fields
        %    of this message.
        %Arguments:
        %    payload(MAVLinkPayload): The payload to be unpacked into this MAVLink message

            payload.resetIndex();
            
            obj.time_usec = payload.getUINT64();
            obj.seq = payload.getUINT32();
            obj.target_system = payload.getUINT8();
            obj.target_component = payload.getUINT8();

        end
        
        function result = verify(obj)
        %VERIFY: Determine whether all fields of this message are full
        %Description:
        %    Finds the first empty field in this message and returns its name. If there are no
        %    empty fields return 0.

            if 1==0
            elseif size(obj.time_usec,2) ~= 1
                result = 'time_usec';
            elseif size(obj.seq,2) ~= 1
                result = 'seq';
            elseif size(obj.target_system,2) ~= 1
                result = 'target_system';
            elseif size(obj.target_component,2) ~= 1
                result = 'target_component';

            else
                result = 0;
            end
        end

        function set.time_usec(obj,value)
            if value == uint64(value)
                obj.time_usec = uint64(value);
            else
                MAVLink.throwTypeError('value','uint64');
            end
        end
        
        function set.seq(obj,value)
            if value == uint32(value)
                obj.seq = uint32(value);
            else
                MAVLink.throwTypeError('value','uint32');
            end
        end
        
        function set.target_system(obj,value)
            if value == uint8(value)
                obj.target_system = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
        function set.target_component(obj,value)
            if value == uint8(value)
                obj.target_component = uint8(value);
            else
                MAVLink.throwTypeError('value','uint8');
            end
        end
        
    end

end