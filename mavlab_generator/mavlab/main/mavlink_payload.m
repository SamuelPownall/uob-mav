classdef mavlink_payload < mavlink_handle
%MAVLINK_PAYLOAD: Represents the payload of a MAVLINK packet
%Description:
%    Handles the storage and retrieval of data from a MAVLINK packet. Provides functions for getting
%    and setting different data types and handles cases where data is of the incorrect type.
    
    properties(Constant, Access = private)
        MAX_PAYLOAD_SIZE = 255; %Maximum length of payload in bytes
    end
    
    properties(Access = private)
        index = 1;
        isFull = 0;
        byteBuffer;
        length;
    end
    
    methods(Access = private)
        
        function add(obj, byte)
        %ADD: Add a byte to the payload
        %Description:
        %    Adds a single byte to the payload buffer and increases the value of the index.
        %Arguments:
        %    byte(uint8): The single byte of data to be added
            
            %Check that the index is within bounds
            if obj.index <= obj.length
                %If the byte is of type 'uint8' add it to the payload unless full
                if isa(byte,'uint8')
                    obj.byteBuffer(obj.index) = byte;
                    if obj.index == obj.length
                        obj.isFull = 1;
                        obj.setIndex(obj.length)
                    else
                        obj.incrementIndex(1);
                    end
                %Otherwise throw a type error
                else
                    mavlink.throwTypeError('byte','uint8');
                end
            %Otherwise throw an index error
            else
                mavlink.throwIndexError();
            end
        end
        
    end
    
    methods
        
        function obj = mavlink_payload(payloadLength)
        %MAVLINK_PAYLOAD: Create a new mavlink_payload object
        %Arguments:
        %    payloadLength(int): The size of payload buffer to be created
            
            %If the payload length requested is greater than the maximum, cap to 255 and throw an error
            if payloadLength > obj.MAX_PAYLOAD_SIZE
                mavlink.throwCustomError('Payload length has been capped to 255 bytes');
                obj.byteBuffer = zeros(obj.MAX_PAYLOAD_SIZE, 'uint8');
                obj.length = obj.MAX_PAYLOAD_SIZE;
            %Otherwise set the buffer size to payload length
            else
                obj.byteBuffer = zeros(payloadLength,1, 'uint8');
                obj.length = payloadLength;
            end
        end
        
        function resetIndex(obj)
        %RESETINDEX: Reset the buffer index
            obj.index = 1;
        end
        
        function incrementIndex(obj, incr)
        %INCREMENTINDEX: Increment the bytebuffer index
        %Arguments:
        %    incr(int): Amount to increment
            obj.index = obj.index + incr;
        end
        
        function byteBuffer = getByteBuffer(obj)
        %GETBYTEBUFFER: Returns the contents of the bytebuffer
            byteBuffer = obj.byteBuffer;
        end
        
        function length = getLength(obj)
        %GETLENGTH: Returns the length of the bytebuffer
            length = obj.length;
        end
        
        function fillState = isPayloadFull(obj)
        %ISPAYLOADFULL: Returns whether the payload bytebuffer is full
            fillState = obj.isFull;
        end
        
        %Getter: index
        function index = getIndex(obj)
        %GETINDEX: Returns the current bytebuffer index
            index = obj.index;
        end
        
        function value = getINT8(obj)
        %GETINT8: Returns the data in the next byte as type 'int8'
            if obj.index <= obj.length
                value = typecast(obj.byteBuffer(obj.index),'int8');
                obj.incrementIndex(1);
            else
                mavlink.throwIndexError();
            end
        end
        
        function value = getUINT8(obj)
        %GETUINT8: Returns the data in the next byte as type 'uint8'
            if obj.index <= obj.length
                value = typecast(obj.byteBuffer(obj.index),'uint8');
                obj.incrementIndex(1);
            else
                mavlink.throwIndexError();
            end
        end
        
        function value = getINT16(obj)
        %GETINT16: Returns the data in the next 2 bytes as type 'int16'
            if obj.index + 1 <= obj.length
                value = typecast(obj.byteBuffer(obj.index:obj.index+1),'int16');
                obj.incrementIndex(2);
            else
                mavlink.throwIndexError();
            end
        end
        
        function value = getUINT16(obj)
        %GETUINT16: Returns the data in the next 2 bytes as type 'uint16'
            if obj.index + 1 <= obj.length
                value = typecast(obj.byteBuffer(obj.index:obj.index+1),'uint16');
                obj.incrementIndex(2);
            else
                mavlink.throwIndexError();
            end
        end
        
        function value = getINT32(obj)
        %GETINT32: Returns the data in the next 4 bytes as type 'int32'
            if obj.index + 3 <= obj.length
                value = typecast(obj.byteBuffer(obj.index:obj.index+3),'int32');
                obj.incrementIndex(4);
            else
                mavlink.throwIndexError();
            end
        end
        
        function value = getUINT32(obj)
        %GETUINT32: Returns the data in the next 4 bytes as type 'uint32'
            if obj.index + 3 <= obj.length
                value = typecast(obj.byteBuffer(obj.index:obj.index+3),'uint32');
                obj.incrementIndex(4);
            else
                mavlink.throwIndexError();
            end
        end
        
        function value = getINT64(obj)
        %GETINT64: Returns the data in the next 8 bytes as type 'int64'
            if obj.index + 7 <= obj.length
                value = typecast(obj.byteBuffer(obj.index:obj.index+7),'int64');
                obj.incrementIndex(8);
            else
                mavlink.throwIndexError();
            end
        end
        
        function value = getUINT64(obj)
        %GETUINT64: Returns the data in the next 8 bytes as type 'uint64'
            if obj.index + 7 <= obj.length
                value = typecast(obj.byteBuffer(obj.index:obj.index+7),'uint64');
                obj.incrementIndex(8);
            else
                mavlink.throwIndexError();
            end
        end
        
        function value = getSINGLE(obj)
        %GETSINGLE: Returns the data in the next 4 bytes as type 'single'
            if obj.index + 3 <= obj.length
                value = typecast(obj.byteBuffer(obj.index:obj.index+3),'single');
                obj.incrementIndex(4);
            else
                mavlink.throwIndexError();
            end
        end
        
        function value = getDOUBLE(obj)
        %GETDOUBLE: Returns the data in the next 8 bytes as type 'double'
            if obj.index + 7 <= obj.length
                value = typecast(obj.byteBuffer(obj.index:obj.index+7),'double');
                obj.incrementIndex(8);
            else
                mavlink.throwIndexError();
            end
        end
        
        function putINT8(obj, value)
        %PUTINT8: Place data of type 'int8' into the next byte
        %Arguments:
        %    value(int8): Data to be placed into the payload
            if obj.index <= obj.length
                if value == int8(value)
                    obj.add(typecast(int8(value),'uint8'));
                else
                    mavlink.throwTypeError('value','int8');
                end
            else
                mavlink.throwIndexError();
            end
        end
        
        function putUINT8(obj, value)
        %PUTUINT8: Place data of type 'uint8' into the next byte
        %Arguments:
        %    value(uint8): Data to be placed into the payload
            if obj.index <= obj.length
                if value == uint8(value)
                    obj.add(uint8(value));
                else
                    mavlink.throwTypeError('value','uint8');
                end
            else
                mavlink.throwIndexError();
            end
        end
        
        function putINT16(obj, value)
        %PUTINT16: Place data of type 'int16' into the next 2 bytes
        %Arguments:
        %    value(int16): Data to be placed into the payload
            if obj.index + 1 <= obj.length
                if value == int16(value)
                    data = typecast(int16(value), 'uint8');
                    obj.add(data(1));
                    obj.add(data(2));
                else
                    mavlink.throwTypeError('value','int16');
                end
            else
                mavlink.throwIndexError();
            end
        end
        
        function putUINT16(obj, value)
        %PUTUINT16: Place data of type 'uint16' into the next 2 bytes
        %Arguments:
        %    value(uint16): Data to be placed into the payload
            if obj.index + 1 <= obj.length
                if value == uint16(value)
                    data = typecast(uint16(value), 'uint8');
                    obj.add(data(1));
                    obj.add(data(2));
                else
                    mavlink.throwTypeError('value','uint16');
                end
            else
                mavlink.throwIndexError();
            end
        end
        
        function putINT32(obj, value)
        %PUTINT32: Place data of type 'int32' into the next 4 bytes
        %Arguments:
        %    value(int32): Data to be placed into the payload
            if obj.index + 3 <= obj.length
                if value == int32(value)
                    data = typecast(int32(value), 'uint8');
                    obj.add(data(1));
                    obj.add(data(2));
                    obj.add(data(3));
                    obj.add(data(4));
                else
                    mavlink.throwTypeError('value','int32');
                end
            else
                mavlink.throwIndexError();
            end
        end
        
        function putUINT32(obj, value)
        %PUTUINT32: Place data of type 'uint32' into the next 4 bytes
        %Arguments:
        %    value(uint32): Data to be placed into the payload
            if obj.index + 3 <= obj.length
                if value == uint32(value)
                    data = typecast(uint32(value), 'uint8');
                    obj.add(data(1));
                    obj.add(data(2));
                    obj.add(data(3));
                    obj.add(data(4));
                else
                    mavlink.throwTypeError('value','uint32');
                end
            else
                mavlink.throwIndexError();
            end
        end
        
        function putINT64(obj, value)
        %PUTINT64: Place data of type 'int64' into the next 8 bytes
        %Arguments:
        %    value(int64): Data to be placed into the payload
            if obj.index + 7 <= obj.length
                if value == int64(value)
                    data = typecast(int64(value), 'uint8');
                    obj.add(data(1));
                    obj.add(data(2));
                    obj.add(data(3));
                    obj.add(data(4));
                    obj.add(data(5));
                    obj.add(data(6));
                    obj.add(data(7));
                    obj.add(data(8));
                else
                    mavlink.throwTypeError('value','int64');
                end
            else
                mavlink.throwIndexError();
            end
        end
        
        function putUINT64(obj, value)
        %PUTUINT64: Place data of type 'uint64' into the next 8 bytes
        %Arguments:
        %    value(uint64): Data to be placed into the payload
            if obj.index + 7 <= obj.length
                if value == uint64(value)
                    data = typecast(uint64(value), 'uint8');
                    obj.add(data(1));
                    obj.add(data(2));
                    obj.add(data(3));
                    obj.add(data(4));
                    obj.add(data(5));
                    obj.add(data(6));
                    obj.add(data(7));
                    obj.add(data(8));
                else
                    mavlink.throwTypeError('value','uint64');
                end
            else
                mavlink.throwIndexError();
            end
        end
        
        function putSINGLE(obj, value)
        %PUTSINGLE: Place data of type 'single' into the next 4 bytes
        %Arguments:
        %    value(single): Data to be placed into the payload
            if obj.index + 3 <= obj.length
                data = typecast(single(value), 'uint8');
                obj.add(data(1));
                obj.add(data(2));
                obj.add(data(3));
                obj.add(data(4));
            else
                mavlink.throwIndexError();
            end
        end
        
        function putDOUBLE(obj, value)
        %PUTDOUBLE: Place data of type 'double' into the next 8 bytes
        %Arguments:
        %    value(double): Data to be placed into the payload
            if obj.index + 7 <= obj.length
                data = typecast(double(value), 'uint8');
                obj.add(data(1));
                obj.add(data(2));
                obj.add(data(3));
                obj.add(data(4));
                obj.add(data(5));
                obj.add(data(6));
                obj.add(data(7));
                obj.add(data(8));
            else
                mavlink.throwIndexError();
            end
        end
        
        function setIndex(obj, index)
        %SETINDEX: Set the bytebuffer index to a new value
        %Arguments:
        %    index: New value for the index
            if index >= 1 && index <= obj.length
                if index == uint64(index)
                    obj.index = index;
                else
                    mavlink.throwTypeError('index','uint64');
                end
            else
                mavlink.throwIndexError();
            end
        end
        
    end
    
end

