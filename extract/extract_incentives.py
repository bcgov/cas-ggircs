import tika
from tika import parser
import xml.etree.ElementTree as ET
from io import StringIO
import pandas as pd
parsed = parser.from_file('data/test_incentive_appl.xls', xmlContent=True)
it = ET.iterparse(StringIO('<root>' + parsed['content'] + '</root>'))
for _, el in it:
    if '}' in el.tag:
        el.tag = el.tag.split('}', 1)[1]  # strip all namespaces
root = it.root
sheets = {}
for page in root.iterfind('.//div[@class="page"]',):
    sheets[page.find('h1').text] = pd.read_html(ET.tostring(page.find('table')))[0]

