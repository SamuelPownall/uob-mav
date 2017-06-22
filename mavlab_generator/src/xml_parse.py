'''
Created on 22 Jun 2017

@author: Samuel
'''

try:
    import xml.etree.cElementTree as ET
except ImportError:
    import xml.etree.ElementTree as ET
    
tree = ET.parse("../data/common.xml")
root = tree.getroot()

for elem in root:
    if elem.tag == "messages":
        for msg in elem:
            print("Message ID: %s | Function: %s" % (msg.attrib.get("id"),msg.attrib.get("name")))
            desc = msg.find("description")
            
            string = "../output/mavlink_message_" + str.lower(msg.attrib.get("name")) + ".m"
            fo = open(string, "w")
            
            if desc != None:
                fo.write("Description: %s\n" % desc.text)
                
            fo.write("    --------------\n")
            
            fields = msg.findall("field")
            
            for field in fields:
                fo.write("    Field: %s\n" % field.attrib.get("name"))
                fo.write("    Data Type: %s\n" % field.attrib.get("type"))
                fo.write("    Description: %s\n" % field.text)
                fo.write("    --------------\n")
                
            fo.close()