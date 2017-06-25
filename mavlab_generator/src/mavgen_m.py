'''
Created on 23 Jun 2017

@author: Samuel
'''

#Import the ElementTree XML module using the C implementation if available 
try:
    import xml.etree.cElementTree as etree
except ImportError:
    import xml.etree.ElementTree as etree
    
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
    id = msg.attrib.get('id')
    name = str.lower(msg.attrib.get('name'))
    
    #Create the message class file and generate MATLAB code
    with open('%s/mavlink_msg_%s.m' % (msg_path, name), 'w') as fo:
        
        #Get message description if available
        if msg.find('description') != None:
            desc = msg.find('description').text
        else:
            desc = "N/A"
            
        #Generate the class header and summary
        fo.write('classdef mavlink_msg_%s\n' % name)
        fo.write('    %%MAVLINK Message Class\n    %%Name: %s    ID: %s\n    %%Description: %s\n\n' % (name, id, desc))
            
        #Get message fields
        fields = []
        for field in msg.findall('field'):
            fields.append({'type' : str.lower(field.attrib.get('type')), 
                           'name' : str.lower(field.attrib.get('name')), 
                           'desc' : field.text})
        
        #Generate the class properties
        fo.write('    properties\n')
        for field in fields:
            fo.write('        %s    %%%s\n' % (field['name'], field['desc']))
        fo.write('    end\n\n')
        
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
    tree = etree.parse(xml_path)
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