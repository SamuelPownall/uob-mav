'''
Created on 23 Jun 2017

@author: Samuel
'''

#Import the ElementTree XML module using the C implementation if available 
try:
    import xml.etree.cElementTree as ET
except ImportError:
    import xml.etree.ElementTree as ET
    
#Import modules needed for file system
import os
import array
from os.path import basename
from shutil import copyfile

def accumulate(crc, buf):
    
    """
    Accumulate bytes into a CRC
    
    Parameters
    ----------
    crc: integer
        The CRC which bytes are being accumulated in to
    buf: byte buffer
        Buffer containing bytes to be accumulated
    ----------
    
    """        
    
    byte_array = array.array('B')
    if isinstance(buf, array.array):
        byte_array.extend(buf)
    else:
        byte_array.fromstring(buf)
        
    for byte in byte_array:
        tmp = byte ^ (crc & 0xff)
        tmp = (tmp ^ (tmp<<4)) & 0xff
        crc = ((crc>>8) & 0xff) ^ (tmp<<8) ^ (tmp<<3) ^ ((tmp>>4) & 0xf)
        
    return crc


def generate_class_from_msg(msg_path, msg):
    
    """
    Generate a MATLAB class from an XML message definition
    
    Parameters
    ----------
    msg_path: string
        Path to the generation location for the message class
    msg: XML Element
        Message element to be parsed and converted
    ----------
    
    """
    
    #Get top level message attributes
    msgid = msg.attrib.get('id')
    name = str.lower(msg.attrib.get('name'))
    class_name = 'msg_' + name
    
    #Create the message class file and generate MATLAB code
    with open('%s/%s.m' % (msg_path, class_name), 'w') as fo:
        
        #Get message description if available
        if msg.find('description') != None:
            desc = msg.find('description').text.replace('\n',' ')
        else:
            desc = "None"
            
        #Generate the class header and summary
        fo.write('''\
\
classdef %s < mavlink_message
    %%MAVLINK Message Class
    %%Name: %s\tID: %s
    %%Description: %s
\
        ''' % (class_name, name, msgid, desc))
        
        #Look-up dictionaries
        type_size = {'double' : 8, 'int64_t' : 8, 'uint64_t': 8, 'int32_t' : 4, 'uint32_t': 4,
                      'float' : 4, 'int16_t' : 2, 'uint16_t': 2, 'int8_t' : 1, 'uint8_t': 1,
                      'char' : 1, 'uint8_t_mavlink_version' : 1}
        
        sort_mapping = {'double' : 0, 'int64_t' : 0, 'uint64_t': 0, 'int32_t' : 1, 'uint32_t': 1,
                      'float' : 1, 'int16_t' : 3, 'uint16_t': 3, 'int8_t' : 4, 'uint8_t' : 4,
                      'char' : 4, 'uint8_t_mavlink_version' : 4}
            
        #Get message fields
        fields = []
        msglen = 0;
        
        for field in msg.findall('field'):
            
            field_type = field.attrib.get('type').split('[')[0]
            if '[' in field.attrib.get('type'):
                array_size = int(field.attrib.get('type').split('[')[1].split(']')[0])
            else:
                array_size = 1
                
            if field_type == 'uint8_t_mavlink_version':
                field_type = 'uint8_t'
                
            msglen += type_size[field_type]*array_size
            
            fields.append({'type' : field_type, 
                           'name' : field.attrib.get('name'), 
                           'desc' : field.text.replace('\n',' '),
                           'size' : array_size})
            
        #Sort message fields
        fields.sort(key = lambda k: sort_mapping[k['type']])
        
        #Calculate the XML checksum for this message using original XML
        crc = 0xffff
        crc = accumulate(crc,name.upper() + ' ')
        
        for field in fields:            
            crc = accumulate(crc,field['type'] + ' ')
            crc = accumulate(crc,field['name'] + ' ')
            if field['size'] > 1:
                crc = accumulate(crc,chr(field['size']))
              
        crc = (crc&0xFF) ^ (crc>>8)
        
        #Re-format field strings
        for field in fields:
            field['type'] = field['type'].split('_')[0]
            field['name'] = field['name'].lower()
        
            if field['type'] == 'char':
                field['type'] = 'uint8'
                
            if field['type'] == 'float':
                field['type'] = 'single'
        
        #Generate class properties
        fo.write('''\
    
    properties(Constant)
        ID = %s
        LEN = %s
    end
    
    properties\
    \
    ''' % (msgid, msglen))
        
        #Insert a variable per field
        for field in fields:
            if field['size'] == 1:
                fo.write('\n\t\t%s\t%%%s (%s)' % (field['name'], field['desc'], field['type']))
            else:
                fo.write('\n\t\t%s\t%%%s (%s[%s])' % (field['name'], field['desc'], field['type'], field['size']))
        fo.write('\n\tend\n')
        
        #Generate class constructors
        fo.write('''\
    
    methods
        
        %%Constructor: %s
        %%packet should be a fully constructed MAVLINK packet\
        \
        ''' % class_name)
        
        fo.write('\n\t\tfunction obj = %s(packet' % class_name)
        for field in fields:
            fo.write(',%s' % field['name'])
        fo.write(')')
        
        fo.write('''
        
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
                
            elseif nargin == %s
        \
        ''' % str(len(fields)+1))
        
        for field in fields:
            fo.write('\n\t\t\t\tobj.%s = %s;' % (field['name'],field['name']))
            
        fo.write('''
        
            elseif nargin ~= 0
                mavlink.throwCustomError('The number of constructor arguments is not valid');
            end
        
        end
        \
        ''')
        
        #Generate message pack function
        fo.write('''\
        
        %%Function: Packs this MAVLINK message into a packet for transmission
        function packet = pack(obj)
        
            errorField = obj.verify();
            if errorField == 0
        
                packet = mavlink_packet(%s.LEN);
                packet.sysid = mavlink.SYSID;
                packet.compid = mavlink.COMPID;
                packet.msgid = %s.ID;
        \
        ''' % (class_name, class_name))
        
        for field in fields:
            
            if field['size'] > 1:
                fo.write('''\
            
                for i = 1:%s
                    packet.payload.put%s(obj.%s(i));
                end
                \
                ''' % (field['size'], field['type'].upper(), field['name']))
            else:
                fo.write('\n\t\t\t\tpacket.payload.put%s(obj.%s);\n' % (field['type'].upper(), field['name']))
        
        fo.write('''\
        
            else
                packet = [];
                mavlink.throwPackingError(errorField);
            end
            
        end
        \
        ''')
        
        #Generate message unpack function
        fo.write('''\
        
        %Function: Unpacks a MAVLINK payload and stores the data in this message
        function unpack(obj, payload)
        
            payload.resetIndex();
        ''')
        
        for field in fields:
            
            if field['size'] > 1:
                fo.write('''\
            
            for i = 1:%s
                obj.%s(i) = payload.get%s();
            end
            \
                ''' % (field['size'], field['name'], field['type'].upper()))
            else:
                fo.write('\n\t\t\tobj.%s = payload.get%s();\n' % (field['name'], field['type'].upper()))
                
        fo.write('\n\t\tend\n')
        
        #Generate verification function
        fo.write('''\
        
        %Function: Returns either 0 or the name of the first encountered empty field.
        function result = verify(obj)
        \
        ''')
        
        for i in range(0,len(fields)):
            field = fields[i]
            if i == 0:
                fo.write('''\
            
            if size(obj.%s,2) ~= %s
                result = '%s';\
            \
                ''' % (field['name'], field['size'], field['name']))
            else:
                fo.write('''\
            
            elseif size(obj.%s,2) ~= %s
                result = '%s';\
            \
                '''% (field['name'], field['size'], field['name']))
                
        fo.write('''
            else
                result = 0;
            end
            
        end
            \
        ''')
        
        #Generate setters for integer message fields
        for field in fields:
            
            if field['type'] == 'double' or field['type'] == 'single':
                fo.write('''\
        
        function set.%s(obj,value)
            obj.%s = %s(value);
        end
        \
                ''' % (field['name'], field['name'], field['type']))        
            
            else:
                
                fo.write('''\
            
        function set.%s(obj,value)
            if value == %s(value)
                obj.%s = %s(value);
            else
                mavlink.throwTypeError('value','%s');
            end
        end
        \
                ''' % (field['name'], field['type'], field['name'], field['type'], field['type']))
        
        #End of class
        fo.write('\n\tend\nend')
        
        #Return a parsed message
        parsed_msg = {'name' : name, 'msgid' : msgid, 'crc' : crc}
        return parsed_msg
    

def generate_enum_class(message_path, xml_name, enum_list):
    
    """
    Generate a class to store all enumerators in the current XML file
    
    Parameters
    ----------
    message_path: string
        Path to the generation location for the enumerator class
    xml_name: string
        Name of the current MAVLINK XML being parsed
    enum_list: XML elements
        List of enumerators from the XML file
    ----------
    
    """
    
    with open('%s/%s.m' % (message_path, xml_name), 'w') as fo:
        
        fo.write('''\
\
classdef %s < uint16
    %%MAVLINK Enumeration Class
    %%Contains enumerators for the %s MAVLINK XML file
            
    enumeration\
\
        ''' % (xml_name, xml_name))
        
        for enum in enum_list.findall('enum'):
            enum_counter = 0
            for entry in enum.findall('entry'):
            
                name = entry.attrib.get('name').upper()
                value = entry.attrib.get('value')
                
                if value == None:
                    value = enum_counter
                    enum_counter += 1
            
                if entry.find('description') != None:
                    desc = entry.find('description').text
                else:
                    desc = "None"
                    
                fo.write('\n\t\t%s (%s) %%%s' % (name, value, desc))
            
        fo.write('\n\tend\n\nend')
        
        
def generate_packet_class(main_path, parsed_msg_list):
    
    """
    Generate the MAVLINK packet class
    
    Parameters
    ----------
    main_path: string
        Path to the generation location for main classes
    parsed_msg_list: dictionary list
        List of parsed MAVLINK messages
    """
    
    with open('%s/mavlink_packet.m' % main_path, 'w') as fo:
        
        fo.write('''\
\
classdef mavlink_packet < handle
    %%MAVLINK_PACKET Class
    %%Used to encode and decode MAVLINK packets
    
    %%Constant public variables
    properties(Constant)
        STX = 254;  %The 'magic' byte
    end
    
    %%Private variables
    properties
        len;        %%Length of the packet payload
        seq;        %%Sequence number of the current packet
        sysid;      %%ID of the sending system
        compid;     %%ID of the sending component
        msgid;      %%ID of the message type contained in the payload
        payload;    %%The packet payload
        crc;        %%The crc object for this packet
    end
    
    %%Publically accessible object variables
    methods
        
        %%Constructor: mavlink_packet
        %%payloadLength should be an integer between 0 and MAX_PAYLOAD_SIZE
        function obj = mavlink_packet(payloadLength)
            obj.len = payloadLength;
            obj.payload = mavlink_payload(payloadLength);
        end
        
        %%Function: Generate the CRC checksum for the packet
        function generateCRC(obj)   
            if isempty(obj.crc)
                obj.crc = mavlink_crc();
            else
                obj.crc.start_checksum();
            end
            
            obj.crc.updateChecksum(uint8(obj.len));
            obj.crc.updateChecksum(uint8(obj.seq));
            obj.crc.updateChecksum(uint8(obj.sysid));
            obj.crc.updateChecksum(uint8(obj.compid));
            obj.crc.updateChecksum(uint8(obj.msgid));
            
            obj.payload.resetIndex();
            for i = 1:1:obj.payload.getLength()
                obj.crc.updateChecksum(obj.payload.getUINT8());
            end
            obj.crc.finishChecksum(uint8(obj.msgid));
        end
        
        %%Function: Encode the packet into a byte buffer for transmission
        function byteBuffer = encode(obj)
            obj.seq = 1;
            obj.generateCRC();
            byteBuffer = cat(1,uint8(obj.STX),uint8(obj.len),uint8(obj.seq),uint8(obj.sysid),...
                uint8(obj.compid),uint8(obj.msgid),obj.payload.getByteBuffer(),obj.crc.getLSB(), obj.crc.getMSB());
        end
        
        %%Getter: isPayloadFull
        function fillStatus = isPayloadFull(obj)
            fillStatus = obj.payload.isPayloadFull();
        end
        
        %%Function: Unpack the payload and return the correct message type
        function message = unpack(obj)
            message = [];
            switch obj.msgid\
\
        ''')
        
        for parsed_msg in parsed_msg_list:
            fo.write('''
                
                case %s
                    message = msg_%s(obj);\
                \
            ''' % (parsed_msg['msgid'], parsed_msg['name']))
            
        fo.write('''

                otherwise
                    mavlink.throwUnsupportedMessageError(obj.msgid);
                    
            end
            
        end
        
    end
    
end
\
        ''')
        

def copy_fixed_classes(main_path):
    
    """
    Copy the fixed classes that do not generation into the main folder of MAVLAB
    
    Parameters
    ----------
    main_path: string
        Path to the generation location for main classes
    ----------
    
    """
    
    #Copy fixed classes
    copyfile('../master/mavlink_message_master.m','%s/mavlink_message.m' % main_path)
    copyfile('../master/mavlink_payload_master.m','%s/mavlink_payload.m' % main_path)
    copyfile('../master/mavlink_parser_master.m','%s/mavlink_parser.m' % main_path)
    copyfile('../master/mavlink_stats_master.m','%s/mavlink_stats.m' % main_path)
    copyfile('../master/mavlink_master.m','%s/mavlink.m' % main_path)
    
    
def generate_message_classes(message_path, msg_list):
    
    """
    Generate a MATLAB class for each message in the current XML file
    
    Parameters
    ----------
    message_path: string
        Path to the generation location for message classes
    msg_list: XML element list
        List of message elements from the current XML file
    ----------
    
    """
    
    #Create an empty list for parsed messages
    parsed_msg_list = []
    
    #Generate a class for each message entry
    for msg in msg_list.findall('message'):
        parsed_msg = generate_class_from_msg(message_path, msg)
        parsed_msg_list.insert(int(parsed_msg['msgid']), parsed_msg)
        
    return parsed_msg_list


def generate_crc_class(main_path, parsed_msg_list):
    
    """
    Generate a MATLAB class to handle the checksum process
    
    Parameters
    ----------
    main_path: string
        Path to the generation location for main classes
    parsed_msg_list: dictionary list
        List of parsed MAVLINK messages
    ----------
    
    """
    
    #Sort parsed message list by message ID and initialise the CRC list
    parsed_msg_list.sort(key = lambda k: int(k['msgid']))
    crc_list = [0] * 255
    
    for parsed_msg in parsed_msg_list:
        crc_list.insert(int(parsed_msg['msgid']), parsed_msg['crc'])
    
    #Write the MAVLINK CRC class
    with open('%s/mavlink_crc.m' % main_path, 'w') as fo:
        
        #Write class definition and start of properties
        fo.write('''\
\
classdef mavlink_crc < handle
    %%MAVLINK CRC Class
    %%Handles the crc x.25 checksum system used by MAVLINK
    
    properties(Constant)\
\
        ''')
        
        #Write the MAVLINK CRC array
        fo.write('\n\t\tMAVLINK_MESSAGE_CRCS = uint8([...\n\t\t\t')
        char_count = 0
        for crc in crc_list:
            char_count += len(str(crc)) + 1
            if char_count > 80:
                fo.write('...\n\t\t\t')
                char_count = 0
            fo.write('%d,' % crc)  
        fo.write('0]);\n')
        
        #Write the rest of the MAVLINK CRC class
        fo.write('''\
\
        CRC_INIT_VALUE = uint16(hex2dec('ffff'));
    end
    
    properties
        crcValue;
    end
    
    methods
        
        %%Constructor: mavlink_crc
        function obj = mavlink_crc()
            obj.startChecksum();
        end
        
        function updateChecksum(obj, char)
            if char == uint8(char)
                char = uint8(char);
                crcBytes = typecast(uint16(obj.crcValue),'uint8');
                temp = bitxor(char,crcBytes(1));
                temp = bitxor(temp,bitshift(temp,4));
                crcAccum = bitxor(uint16(crcBytes(2)),bitshift(uint16(temp),8));
                crcAccum = bitxor(crcAccum,bitshift(uint16(temp),3));
                crcAccum = bitxor(crcAccum,bitshift(uint16(temp),-4));
                obj.crcValue = crcAccum;
            else
                fprintf(2,'MAVLAB-ERROR | mavlink_crc.updateChecksum()\\n\\t Input "char" is not of type "uint8"\\n');
            end
        end
        
        %%Function: Initialises the checksum value
        function startChecksum(obj)
            obj.crcValue = obj.CRC_INIT_VALUE;
        end
        
        %%Function: Hash the checksum with the mavlink message CRC
        function finishChecksum(obj, msgid)
           obj.updateChecksum(obj.MAVLINK_MESSAGE_CRCS(msgid + 1)) 
        end
        
        %%Getter: MSB
        function msb = getMSB(obj)
            crcBytes = typecast(uint16(obj.crcValue),'uint8');
            msb = crcBytes(2);
        end
        
        %%Getter: LSB
        function lsb = getLSB(obj)
            crcBytes = typecast(uint16(obj.crcValue),'uint8');
            lsb = crcBytes(1);
        end
        
    end
    
end\
        
        ''')
                
    
def generate(xml_path, output_path):
    
    """
    Generate the full MATLAB implementation of the MAVLINK protocol from an XML source file
    
    Parameters
    ----------
    xml_path: string
        Path to the folder containing the MAVLINK XML dialect files
    output_path: string
        Path to the generation location for MAVLAB
    ----------
    
    """
    
    full_parsed_msg_list = []
    
    #Create the folder system at the output path
    mavlab_path = '%s/mavlab' % output_path
    if not os.path.exists(mavlab_path):
        os.makedirs(mavlab_path)
            
    main_path = '%s/main' % mavlab_path    
    if not os.path.exists(main_path):
        os.makedirs(main_path)
    
    for filename in os.listdir(xml_path):
        if not filename.endswith('.xml'):
            continue
        fullname = os.path.join(xml_path, filename)
    
        #Load the MAVLINK message definition XML document and get the root
        tree = ET.parse(fullname)
        root = tree.getroot()
        xml_name = basename(fullname).split('.')[0]
    
        #Create a folder for this dialect
        message_path = '%s/%s' % (mavlab_path, xml_name)
        if not os.path.exists(message_path):
            os.makedirs(message_path)
    
        #Find the message list and generate a MATLAB class file for each message
        msg_list = root.find('messages')
        parsed_msg_list = generate_message_classes(message_path, msg_list)
        
        #Generate the enumeration class for this XML file
        enum_list = root.find('enums')
        generate_enum_class(message_path, xml_name, enum_list)
        
        full_parsed_msg_list += parsed_msg_list
    
    #Generate the MAVLINK packet class
    generate_packet_class(main_path, full_parsed_msg_list)
    
    #Generate the MAVLINK CRC class
    generate_crc_class(main_path, full_parsed_msg_list)
        
    #Copy fixed classes into the main folder
    copy_fixed_classes(main_path)
        
generate('../data', '../')