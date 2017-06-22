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
            
            if desc != None:
                print("Description: %s" % desc.text)
            
            fields = msg.findall("field")
            