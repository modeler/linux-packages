#!/bin/env python

import os
import sys
import binascii

directory = sys.argv[1]
roms = []

if directory[-1] == '/':
   directory_line = directory[:-1]
else:
   directory_line = directory

db_name = directory.split('/')

for rom in os.listdir(directory):
  roms.append(str(rom))

roms = sorted(roms)
total = len(roms)

header = """{
  "version": "1.4",
  "default_core_path": "",
  "default_core_name": "",
  "label_display_mode": 0,
  "right_thumbnail_mode": 0,
  "left_thumbnail_mode": 0,
  "sort_mode": 0,
  "items": ["""

footer = """  ]
}"""

item_count = 0

print header
for rom in roms:
  label = rom.split('.')
  crc32 = '%08X' % (binascii.crc32(rom) & 0xffffffff)
  print '    {'
  print '      "path": "' + directory_line + '/' + rom + '",'
  print '      "label": "' + label[0] + '",' 
  print '      "core_path": "DETECT",'
  print '      "core_name": "DETECT",'
  print '      "crc32": "' + crc32 + '|crc",'
  print '      "db_name": "' + db_name[-2] + '.lpl"'
  item_count += 1
  if item_count != total:
    print '    },'  
  else:
    print '    }'
print footer
