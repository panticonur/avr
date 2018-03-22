#!/bin/sh
#http://www.ladyada.net/learn/avr/avrdude.html
#http://easyelectronics.ru/skorostnoj-avr-usb-programmator-na-ft232rl-bez-vspomogatelnogo-kontrollera.html
#avrdude Version 6.3
# -P ft0 - index of FTDI232RL, должен быть один в компе во время прошивки
sudo avrdude -v -p t2313 -c tf1 -P ft0 -B 2400 -U hfuse:w:223:m -U lfuse:w:255:m -U lock:w:3:m
sudo avrdude -v -p t2313 -c tf1 -P ft0 -B 2400 -U flash:w:yattor.hex:a
