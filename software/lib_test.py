#!/usr/bin/env python

import subprocess
import time
import array
import numpy as np

#subprocess.call(['gnome-terminal', '-x', 'some_app', 'param1', 'param2'])

from ctypes import *
# https://docs.python.org/2/library/ctypes.html

lib = CDLL("libtemplate.so")


ArrayType = c_ushort * 123
buf = ArrayType()

FTUTIL_MAX_DEVICES = 128
FTUTIL_EEPROM_SIZE = 64
CharBuffer = c_char * (FTUTIL_MAX_DEVICES * FTUTIL_EEPROM_SIZE)
devices_count = c_int()
serials = CharBuffer()
descriptions = CharBuffer()
lib.list_devices(byref(devices_count), serials, descriptions)

for i in range(devices_count.value):
	serial = ''
	for c in range(FTUTIL_EEPROM_SIZE):
		char = serials[i*FTUTIL_EEPROM_SIZE+c]
		serial = serial + char
	print serial,
	description = ''
	for c in range(FTUTIL_EEPROM_SIZE):
		char = descriptions[i*FTUTIL_EEPROM_SIZE+c]
		description = description + char
	print description

print ''

lib.open_device(0)
lib.purge()
lib.yattor_start()
time.sleep(10)
lib.stop_work();
lib.close_device()
