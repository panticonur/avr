rem http://www.ladyada.net/learn/avr/avrdude.html
rem http://easyelectronics.ru/skorostnoj-avr-usb-programmator-na-ft232rl-bez-vspomogatelnogo-kontrollera.html
rem avrdude Version 5.3
rem -P ft0 - index of FTDI232RL, должен быть один в компе во время прошивки
avrdude.exe -v -p t2313 -c tf1 -P ft0 -B 2400 -U hfuse:w:223:m -U lfuse:w:255:m -U lock:w:3:m
avrdude.exe -v -p t2313 -c tf1 -P ft0 -B 2400 -U flash:w:firmware.hex:a
