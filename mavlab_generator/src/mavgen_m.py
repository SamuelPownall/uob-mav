'''
Created on 23 Jun 2017

@author: Samuel
'''

#Import the ElementTree XML module using the C implementation if available 
try:
    import xml.etree.cElementTree as ET
except ImportError:
    import xml.etree.ElementTree as ET
    
#Import the OS of the system
import os

def class_from_msg(msg_path, msg):
    
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
    
    #Create the message class file and generate MATLAB code
    with open('%s/mavlink_msg_%s.m' % (msg_path, name), 'w') as fo:
        
        #Get message description if available
        if msg.find('description') != None:
            desc = msg.find('description').text
        else:
            desc = "N/A"
            
        #Generate the class header and summary
        fo.write('\n'.join((
        'classdef mavlink_msg_%s < handle',
        '%%MAVLINK Message Class',
        '%%Name: %s\tID: %s',
        '%%Description: %s\n',
        )) % (name, name, msgid, desc))
            
        #Get message fields
        fields = []
        for field in msg.findall('field'):
            fields.append({'type' : str.lower(field.attrib.get('type')), 
                           'name' : str.lower(field.attrib.get('name')), 
                           'desc' : field.text})
            
        #Sort message fields
        sort_mapping = {'double' : 0, 'int64_t' : 0, 'uint64_t': 0, 'int32_t' : 1, 'uint32_t': 1,
                      'float' : 2, 'int16_t' : 3, 'uint16_t': 3, 'int8_t' : 4, 'uint8_t': 4,
                      'char' : 4, 'uint8_t_mavlink_version' : 4}
        fields.sort(key = lambda k: sort_mapping[k['type'].split('[')[0]])
        
        #Generate class properties
        fo.write('\tproperties\n')
        for field in fields:
            fo.write('\t\t%s\t%%%s\n' % (field['name'], field['desc']))
        fo.write('\tend\n\n')
        
        #Start of methods
        fo.write('\tmethods\n\n')
        
        #Generate class constructor without arguments
        fo.write('\n'.join((
        '\t\tfunction obj = mavlink_msg_%s()',
        '\t\t\tobj;',
        '\t\tend\n\n'
        )) % name)
        
        #Generate class constructor with arguments
        
        #Generate message pack function
        
        #End of class
        fo.write('end')
                
    
def generate(xml_path, mavlab_path):
    
    """
    Generate the full MATLAB implementation of the MAVLINK protocol from an XML source file
    
    Parameters
    ----------
    xml_path: string
        Path to the MAVLINK XML source file
    mavlab_path: string
        Path to the generation location for MAVLAB
    ----------
    
    """
    
    #Load the MAVLINK message definition XML document and get the root
    tree = ET.parse(xml_path)
    root = tree.getroot()
    
    #Create the folder system at the output path
    if not os.path.exists('%s/mavlab' % mavlab_path):
        os.makedirs('%s/mavlab' % mavlab_path)
        
    if not os.path.exists('%s/mavlab/msg_classes' % mavlab_path):
        os.makedirs('%s/mavlab/msg_classes' % mavlab_path)
    
    #Find the message list and generate a MATLAB class file for each message
    msg_list = root.find('messages')
    for msg in msg_list.findall('message'):
        class_from_msg('%s/mavlab/msg_classes' % mavlab_path, msg)
        
generate('../data/common.xml', '../')