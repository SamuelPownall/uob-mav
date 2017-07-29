classdef mavlink_parser < mavlink_handle
    %MAVLINK_PARSER: Used to parse an input stream for MAVLINK packets
    %Description:
    %    Parses a stream of chars for MAVLINK packets and returns them so that they can be
    %    decoded and unpacked.
    
    %Private constant properties
    properties(Constant, Access = private)
        STATE_UNINIT = 0;
        STATE_IDLE = 1;
        STATE_GOT_STX = 2;
        STATE_GOT_LEN = 3;
        STATE_GOT_SEQ = 4;
        STATE_GOT_SYSID = 5;
        STATE_GOT_COMPID = 6;
        STATE_GOT_MSGID = 7;
        STATE_GOT_PAYLOAD = 8;
        STATE_GOT_CRC1 = 9;
    end
    
    %Private properties
    properties(Access = private)
        msg_received;
        packet;
        state;
        last_seq;
    end
    
    %Public object methods
    methods
        
        function obj = mavlink_parser()
            %Create a new mavlink_parser object
            obj.state = obj.STATE_UNINIT;
        end
        
        function packet = parseChar(obj,char)
            %PARSECHAR(char): Parse a stream of chars and return a packet if found
            %Description:
            %    Parses chars one at a time and returns any packets that are found. If a packet
            %    is not found this function returns [].
            %Arguments:
            %    char(char): The next char in the stream to be parsed
            
            %Check that the input if of type uint8
            if isa(char,'uint8')
                obj.msg_received = 0;
                switch (obj.state)

                    %Wait until the start byte is received
                    case {obj.STATE_UNINIT, obj.STATE_IDLE}
                        if char == mavlink_packet.STX
                            obj.state = obj.STATE_GOT_STX;
                        end

                    %Get the payload length
                    case obj.STATE_GOT_STX
                        obj.packet = mavlink_packet(char);
                        obj.state = obj.STATE_GOT_LEN;

                    %Get the packet sequence
                    case obj.STATE_GOT_LEN
                        obj.packet.seq = char;
                        obj.state = obj.STATE_GOT_SEQ;

                    %Get the sending system ID
                    case obj.STATE_GOT_SEQ
                        obj.packet.sysid = char;
                        obj.state = obj.STATE_GOT_SYSID;

                    %Get the sending component ID
                    case obj.STATE_GOT_SYSID
                        obj.packet.compid = char;
                        obj.state = obj.STATE_GOT_COMPID;

                    %Get the message ID 
                    case obj.STATE_GOT_COMPID
                        obj.packet.msgid = char;
                        if obj.packet.len == 0
                            obj.state = obj.STATE_GOT_PAYLOAD;
                        else
                            obj.state = obj.STATE_GOT_MSGID;
                        end

                    %Get the payload bytes 
                    case obj.STATE_GOT_MSGID
                        obj.packet.payload.putUINT8(char);
                        if obj.packet.isPayloadFull()
                            obj.state = obj.STATE_GOT_PAYLOAD;
                        end

                    %Get and check the first CRC checksum byte
                    case obj.STATE_GOT_PAYLOAD
                        obj.packet.generateCRC();
                        if char ~= obj.packet.crc.getLSB()
                            obj.state = obj.STATE_IDLE;
                            mavlink.stats.incrementFailedCRC();
                            if char == mavlink_packet.STX
                                obj.state = obj.STATE_GOT_STX;
                            end
                        else
                            obj.state = obj.STATE_GOT_CRC1;
                        end

                    %Get and check the second CRC checksum byte
                    case obj.STATE_GOT_CRC1
                        if char ~= obj.packet.crc.getMSB()
                            obj.state = obj.STATE_IDLE;
                            mavlink.stats.incrementFailedCRC();
                            if char == mavlink_packet.STX
                                obj.state = obj.STATE_GOT_STX;
                            end
                        else
                            obj.msg_received = true;
                            obj.state = obj.STATE_IDLE;
                        end
                end

                %If the packet is complete return it
                if obj.msg_received
                    packet = obj.packet;
                    
                    %Check whether any packets have been dropped
                    if ~isempty(obj.last_seq)
                        seq_diff = double(packet.seq) - double(obj.last_seq);
                        if seq_diff < 0
                            seq_diff = seq_diff + 256;
                        end
                        mavlink.stats.incrementPacketsDropped(seq_diff - 1);
                    end
                    
                    obj.last_seq = packet.seq;
                    mavlink.stats.incrementPacketsReceived()
                else
                    packet = [];
                end
                
            else
                mavlink.throwCustomError('Input "char" must be cast to type "uint8" before being passed into this function')
                packet = [];
            end
        end
    end
end

