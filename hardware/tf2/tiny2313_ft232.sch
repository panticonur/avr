EESchema Schematic File Version 4
EELAYER 26 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "AVRtiny2313 FT232RL"
Date "2017-03-13"
Rev "1"
Comp "TF2"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L power:GND #PWR01
U 1 1 57FBBB0E
P 6750 3850
F 0 "#PWR01" H 6750 3600 50  0001 C CNN
F 1 "GND" H 6755 3677 50  0001 C CNN
F 2 "" H 6750 3850 50  0000 C CNN
F 3 "" H 6750 3850 50  0000 C CNN
	1    6750 3850
	1    0    0    -1  
$EndComp
$Comp
L Device:R ledR_portD2
U 1 1 57FBD3AC
P 10900 3700
F 0 "ledR_portD2" V 11000 3650 50  0001 L CNN
F 1 "2K" V 10900 3700 50  0000 C CIN
F 2 "Discret:R1" V 10830 3700 50  0001 C CNN
F 3 "" H 10900 3700 50  0000 C CNN
F 4 "R" H 10900 3700 60  0001 C CNN "Spice_Primitive"
F 5 "1k" H 10900 3700 60  0001 C CNN "Spice_Model"
F 6 "Y" H 10900 3700 60  0001 C CNN "Spice_Netlist_Enabled"
	1    10900 3700
	0    1    1    0   
$EndComp
$Comp
L Device:C vbusC2
U 1 1 57FC0E46
P 2050 5200
F 0 "vbusC2" V 1900 5150 50  0000 L CNN
F 1 "100n" V 1950 4950 50  0000 L CIN
F 2 "Capacitors_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 2088 5050 50  0001 C CNN
F 3 "" H 2050 5200 50  0000 C CNN
F 4 "C" H 2050 5200 60  0001 C CNN "Spice_Primitive"
F 5 "22u" H 2050 5200 60  0001 C CNN "Spice_Model"
F 6 "Y" H 2050 5200 60  0001 C CNN "Spice_Netlist_Enabled"
	1    2050 5200
	0    1    1    0   
$EndComp
$Comp
L Device:C quartzC1
U 1 1 57FC1690
P 6750 3500
F 0 "quartzC1" H 6800 3400 50  0000 L CNN
F 1 "22n" H 6800 3600 50  0000 L CIN
F 2 "Capacitors_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 6788 3350 50  0001 C CNN
F 3 "" H 6750 3500 50  0000 C CNN
F 4 "C" H 6750 3500 60  0001 C CNN "Spice_Primitive"
F 5 "22u" H 6750 3500 60  0001 C CNN "Spice_Model"
F 6 "Y" H 6750 3500 60  0001 C CNN "Spice_Netlist_Enabled"
	1    6750 3500
	1    0    0    -1  
$EndComp
$Comp
L Device:C quartzC2
U 1 1 57FC1D1A
P 7250 3500
F 0 "quartzC2" H 7300 3400 50  0000 L CNN
F 1 "22n" H 7300 3600 50  0000 L CIN
F 2 "Capacitors_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 7288 3350 50  0001 C CNN
F 3 "" H 7250 3500 50  0000 C CNN
F 4 "C" H 7250 3500 60  0001 C CNN "Spice_Primitive"
F 5 "22u" H 7250 3500 60  0001 C CNN "Spice_Model"
F 6 "Y" H 7250 3500 60  0001 C CNN "Spice_Netlist_Enabled"
	1    7250 3500
	1    0    0    -1  
$EndComp
$Comp
L Device:R ledR_portD4
U 1 1 57FC3E1C
P 10850 4050
F 0 "ledR_portD4" V 10950 4050 50  0001 C CNN
F 1 "1.5k" V 10850 4050 50  0000 C CIN
F 2 "Discret:R1" V 10780 4050 50  0001 C CNN
F 3 "" H 10850 4050 50  0000 C CNN
F 4 "R" H 10850 4050 60  0001 C CNN "Spice_Primitive"
F 5 "68k" H 10850 4050 60  0001 C CNN "Spice_Model"
F 6 "Y" H 10850 4050 60  0001 C CNN "Spice_Netlist_Enabled"
	1    10850 4050
	-1   0    0    1   
$EndComp
$Comp
L Device:R ledR_portD3
U 1 1 57FC3F48
P 10800 3800
F 0 "ledR_portD3" V 10900 3800 50  0001 C CNN
F 1 "3k" V 10800 3800 50  0000 C CIN
F 2 "Discret:R1" V 10730 3800 50  0001 C CNN
F 3 "" H 10800 3800 50  0000 C CNN
F 4 "R" H 10800 3800 60  0001 C CNN "Spice_Primitive"
F 5 "120k" H 10800 3800 60  0001 C CNN "Spice_Model"
F 6 "Y" H 10800 3800 60  0001 C CNN "Spice_Netlist_Enabled"
	1    10800 3800
	0    1    1    0   
$EndComp
$Comp
L Device:R avrR_reset1
U 1 1 57FD5CE8
P 7300 2000
F 0 "avrR_reset1" H 7350 1850 50  0000 L CNN
F 1 "10k" V 7300 2000 50  0000 C CIN
F 2 "Discret:R3" V 7230 2000 50  0001 C CNN
F 3 "" H 7300 2000 50  0000 C CNN
	1    7300 2000
	-1   0    0    1   
$EndComp
$Comp
L Device:C vbusC1
U 1 1 5876B804
P 2050 4700
F 0 "vbusC1" V 2200 4550 50  0000 L CNN
F 1 "15n" V 1950 4500 50  0000 L CIN
F 2 "Capacitors_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 2088 4550 50  0001 C CNN
F 3 "" H 2050 4700 50  0000 C CNN
F 4 "C" H 2050 4700 60  0001 C CNN "Spice_Primitive"
F 5 "22u" H 2050 4700 60  0001 C CNN "Spice_Model"
F 6 "Y" H 2050 4700 60  0001 C CNN "Spice_Netlist_Enabled"
	1    2050 4700
	0    1    1    0   
$EndComp
$Comp
L Device:C ftC1_33
U 1 1 5876B8A4
P 4000 4450
F 0 "ftC1_33" V 4150 4350 50  0000 L CNN
F 1 "100n" V 3850 4350 50  0000 L CIN
F 2 "Capacitors_THT:C_Disc_D3.4mm_W2.1mm_P2.50mm" H 4038 4300 50  0001 C CNN
F 3 "" H 4000 4450 50  0000 C CNN
F 4 "C" H 4000 4450 60  0001 C CNN "Spice_Primitive"
F 5 "100n" H 4000 4450 60  0001 C CNN "Spice_Model"
F 6 "Y" H 4000 4450 60  0001 C CNN "Spice_Netlist_Enabled"
	1    4000 4450
	0    1    1    0   
$EndComp
$Comp
L Device:C avrC_reset1
U 1 1 5876B94D
P 7600 2000
F 0 "avrC_reset1" H 7750 2000 50  0000 L CNN
F 1 "100n" H 7750 1900 50  0000 L CIN
F 2 "Capacitors_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 7638 1850 50  0001 C CNN
F 3 "" H 7600 2000 50  0000 C CNN
F 4 "C" H 7600 2000 60  0001 C CNN "Spice_Primitive"
F 5 "22u" H 7600 2000 60  0001 C CNN "Spice_Model"
F 6 "Y" H 7600 2000 60  0001 C CNN "Spice_Netlist_Enabled"
	1    7600 2000
	1    0    0    -1  
$EndComp
$Comp
L MCU_Microchip_ATtiny:ATtiny2313-20PU AVR1
U 1 1 5876B326
P 8450 3400
F 0 "AVR1" H 8450 3350 50  0000 C CNN
F 1 "ATTINY2313-20PU" H 8450 3250 50  0000 C CNN
F 2 "Housings_DIP:DIP-20_W7.62mm_Socket" H 8450 3900 50  0001 C CIN
F 3 "" H 8450 3400 50  0000 C CNN
	1    8450 3400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR03
U 1 1 5878083D
P 1750 2950
F 0 "#PWR03" H 1750 2700 50  0001 C CNN
F 1 "GND" H 1755 2777 50  0001 C CNN
F 2 "" H 1750 2950 50  0000 C CNN
F 3 "" H 1750 2950 50  0000 C CNN
	1    1750 2950
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR04
U 1 1 58780A14
P 8450 4400
F 0 "#PWR04" H 8450 4150 50  0001 C CNN
F 1 "GND" H 8455 4227 50  0001 C CNN
F 2 "" H 8450 4400 50  0000 C CNN
F 3 "" H 8450 4400 50  0000 C CNN
	1    8450 4400
	1    0    0    -1  
$EndComp
$Comp
L Device:Crystal quartzAVR1
U 1 1 587812E2
P 7000 3100
F 0 "quartzAVR1" H 7000 2900 50  0001 C CNN
F 1 "Crystal" H 7000 3277 50  0001 C CNN
F 2 "Crystals:Resonator-2pin_w8.0mm_h3.5mm" H 7000 3100 50  0001 C CNN
F 3 "" H 7000 3100 50  0000 C CNN
	1    7000 3100
	1    0    0    -1  
$EndComp
$Comp
L Device:Ferrite_Bead vbusBead1
U 1 1 587813B0
P 2350 4950
F 0 "vbusBead1" H 2400 5050 50  0001 L CNN
F 1 "Ferrite_Bead" H 2487 4905 50  0001 L CNN
F 2 "Diodes_THT:D_DO-15_P2.54mm_Vertical_AnodeUp" V 2280 4950 50  0001 C CNN
F 3 "" H 2350 4950 50  0000 C CNN
	1    2350 4950
	1    0    0    -1  
$EndComp
$Comp
L Device:LED led_portD2
U 1 1 58781630
P 11050 4400
F 0 "led_portD2" H 11050 4300 50  0001 C CNN
F 1 "white" H 10000 4400 50  0000 L CNN
F 2 "LEDs:LED_D5.0mm" H 11050 4400 50  0001 C CNN
F 3 "" H 11050 4400 50  0000 C CNN
	1    11050 4400
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED led_portD3
U 1 1 587816D8
P 10950 4550
F 0 "led_portD3" H 10950 4450 50  0001 C CNN
F 1 "blue" H 10050 4550 50  0000 L CNN
F 2 "LEDs:LED_D5.0mm" H 10950 4550 50  0001 C CNN
F 3 "" H 10950 4550 50  0000 C CNN
	1    10950 4550
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED led_portD4
U 1 1 58781798
P 10850 4700
F 0 "led_portD4" H 10850 4600 50  0001 C CNN
F 1 "red" H 10100 4700 50  0000 L CNN
F 2 "LEDs:LED_D5.0mm" H 10850 4700 50  0001 C CNN
F 3 "" H 10850 4700 50  0000 C CNN
	1    10850 4700
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR05
U 1 1 5878499E
P 4550 4450
F 0 "#PWR05" H 4550 4200 50  0001 C CNN
F 1 "GND" H 4555 4277 50  0001 C CNN
F 2 "" H 4550 4450 50  0000 C CNN
F 3 "" H 4550 4450 50  0000 C CNN
	1    4550 4450
	1    0    0    -1  
$EndComp
$Comp
L Device:C vbusC3
U 1 1 587B79D4
P 2050 5500
F 0 "vbusC3" V 2200 5400 50  0000 L CNN
F 1 "47u" V 2000 5300 50  0000 L CIN
F 2 "Capacitors_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 2088 5350 50  0001 C CNN
F 3 "" H 2050 5500 50  0000 C CNN
F 4 "C" H 2050 5500 60  0001 C CNN "Spice_Primitive"
F 5 "22u" H 2050 5500 60  0001 C CNN "Spice_Model"
F 6 "Y" H 2050 5500 60  0001 C CNN "Spice_Netlist_Enabled"
	1    2050 5500
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR06
U 1 1 587BDCEA
P 3150 4750
F 0 "#PWR06" H 3150 4500 50  0001 C CNN
F 1 "GND" H 3155 4577 50  0001 C CNN
F 2 "" H 3150 4750 50  0000 C CNN
F 3 "" H 3150 4750 50  0000 C CNN
	1    3150 4750
	1    0    0    -1  
$EndComp
Text Label 5300 4100 1    60   ~ 0
PWREN
Text Label 10500 3000 0    60   ~ 0
resumePC
$Comp
L Connector_Generic:Conn_01x07 avrP_portD1
U 1 1 587C0CEB
P 9900 3800
F 0 "avrP_portD1" V 10115 3795 50  0001 C CNN
F 1 "CONN_01X07" V 10024 3795 50  0001 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x07_Pitch2.54mm" H 9900 3800 50  0001 C CNN
F 3 "" H 9900 3800 50  0000 C CNN
F 4 "N" H 9900 3800 60  0001 C CNN "Spice_Netlist_Enabled"
	1    9900 3800
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x07 avrP_portD2
U 1 1 587C0E18
P 10050 3800
F 0 "avrP_portD2" V 10265 3795 50  0001 C CNN
F 1 "CONN_01X07" V 10174 3795 50  0001 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x07_Pitch2.54mm" H 10050 3800 50  0001 C CNN
F 3 "" H 10050 3800 50  0000 C CNN
F 4 "N" H 10050 3800 60  0001 C CNN "Spice_Netlist_Enabled"
	1    10050 3800
	-1   0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x08 avrP_portB1
U 1 1 587C3AC6
P 10150 2900
F 0 "avrP_portB1" V 10365 2895 50  0001 C CNN
F 1 "CONN_01X08" V 10274 2895 50  0001 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x08_Pitch2.54mm" H 10150 2900 50  0001 C CNN
F 3 "" H 10150 2900 50  0000 C CNN
F 4 "N" H 10150 2900 60  0001 C CNN "Spice_Netlist_Enabled"
	1    10150 2900
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x06 avrP_portB2
U 1 1 587C4332
P 10300 3000
F 0 "avrP_portB2" V 10515 2995 50  0001 C CNN
F 1 "CONN_01X06" V 10424 2995 50  0001 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x06_Pitch2.54mm" H 10300 3000 50  0001 C CNN
F 3 "" H 10300 3000 50  0000 C CNN
F 4 "N" H 10300 3000 60  0001 C CNN "Spice_Netlist_Enabled"
	1    10300 3000
	-1   0    0    -1  
$EndComp
$Comp
L Device:LED led_portD5
U 1 1 587C4C3F
P 10650 5000
F 0 "led_portD5" H 10650 4900 50  0001 C CNN
F 1 "yellow" H 10200 5000 50  0000 L CNN
F 2 "LEDs:LED_D5.0mm" H 10650 5000 50  0001 C CNN
F 3 "" H 10650 5000 50  0000 C CNN
	1    10650 5000
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED led_portD6
U 1 1 587C4C74
P 10750 4850
F 0 "led_portD6" H 10750 4750 50  0001 C CNN
F 1 "green" H 10150 4850 50  0000 L CNN
F 2 "LEDs:LED_D5.0mm" H 10750 4850 50  0001 C CNN
F 3 "" H 10750 4850 50  0000 C CNN
	1    10750 4850
	0    -1   -1   0   
$EndComp
$Comp
L Device:R ledR_portD5
U 1 1 587C4D64
P 10650 4550
F 0 "ledR_portD5" V 10750 4550 50  0001 C CNN
F 1 "1k" V 10650 4550 50  0000 C CIN
F 2 "Discret:R1" V 10580 4550 50  0001 C CNN
F 3 "" H 10650 4550 50  0000 C CNN
F 4 "R" H 10650 4550 60  0001 C CNN "Spice_Primitive"
F 5 "68k" H 10650 4550 60  0001 C CNN "Spice_Model"
F 6 "Y" H 10650 4550 60  0001 C CNN "Spice_Netlist_Enabled"
	1    10650 4550
	-1   0    0    1   
$EndComp
$Comp
L Device:R ledR_portD6
U 1 1 587C4DAD
P 10750 4250
F 0 "ledR_portD6" V 10850 4250 50  0001 C CNN
F 1 "180" V 10750 4250 50  0000 C CIN
F 2 "Discret:R1" V 10680 4250 50  0001 C CNN
F 3 "" H 10750 4250 50  0000 C CNN
F 4 "R" H 10750 4250 60  0001 C CNN "Spice_Primitive"
F 5 "68k" H 10750 4250 60  0001 C CNN "Spice_Model"
F 6 "Y" H 10750 4250 60  0001 C CNN "Spice_Netlist_Enabled"
	1    10750 4250
	-1   0    0    1   
$EndComp
$Comp
L Switch:SW_Push avrBT_reset1
U 1 1 587C8C96
P 7000 2300
F 0 "avrBT_reset1" H 6950 2450 50  0000 C CNN
F 1 "Button" H 7000 2421 50  0001 C CNN
F 2 "pnt:push_button" H 7000 2300 50  0001 C CNN
F 3 "" H 7000 2300 50  0000 C CNN
	1    7000 2300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07
U 1 1 587C8F10
P 6800 2300
F 0 "#PWR07" H 6800 2050 50  0001 C CNN
F 1 "GND" H 6805 2127 50  0001 C CNN
F 2 "" H 6800 2300 50  0000 C CNN
F 3 "" H 6800 2300 50  0000 C CNN
	1    6800 2300
	1    0    0    -1  
$EndComp
Text Label 10250 3600 0    60   ~ 0
TXD
Text Label 10250 3500 0    60   ~ 0
RXD
Text Label 10500 3200 0    60   ~ 0
MOSI
Text Label 10500 3300 0    60   ~ 0
MISO
Text Label 10500 3100 0    60   ~ 0
SCK
Text Label 7050 2600 0    60   ~ 0
reset
Text Label 3450 4250 1    60   ~ 0
VCCIO
Text Label 3350 3550 3    60   ~ 0
VCC_FT
$Comp
L pnt:FT232RL_pnt FT1
U 1 1 58807094
P 4450 3350
F 0 "FT1" H 4450 4237 60  0000 C CNN
F 1 "FT232RL_pnt" H 4450 4131 60  0000 C CNN
F 2 "Housings_DIP:DIP-28_W15.24mm_Socket" H 4400 4150 60  0001 C CNN
F 3 "" H 4450 3350 60  0001 C CNN
	1    4450 3350
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR08
U 1 1 5881D83F
P 3800 4550
F 0 "#PWR08" H 3800 4400 50  0001 C CNN
F 1 "+3.3V" H 3815 4723 50  0000 C CNN
F 2 "" H 3800 4550 50  0000 C CNN
F 3 "" H 3800 4550 50  0000 C CNN
	1    3800 4550
	-1   0    0    1   
$EndComp
$Comp
L power:+5V #PWR09
U 1 1 5881D8B3
P 3200 3250
F 0 "#PWR09" H 3200 3100 50  0001 C CNN
F 1 "+5V" H 3215 3423 50  0000 C CNN
F 2 "" H 3200 3250 50  0000 C CNN
F 3 "" H 3200 3250 50  0000 C CNN
	1    3200 3250
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG010
U 1 1 5885072C
P 3200 5500
F 0 "#FLG010" H 3200 5575 50  0001 C CNN
F 1 "PWR_FLAG" H 3200 5674 50  0001 C CNN
F 2 "" H 3200 5500 50  0000 C CNN
F 3 "" H 3200 5500 50  0000 C CNN
	1    3200 5500
	-1   0    0    1   
$EndComp
Text Notes 2650 3750 0    30   ~ 0
VCC filter
Text Notes 2650 3950 0    30   ~ 0
FT pwr
Text Notes 2650 4250 0    30   ~ 0
FT io
$Comp
L power:PWR_FLAG #FLG011
U 1 1 588520CB
P 3450 2750
F 0 "#FLG011" H 3450 2825 50  0001 C CNN
F 1 "PWR_FLAG" H 3650 2900 50  0001 C CNN
F 2 "" H 3450 2750 50  0000 C CNN
F 3 "" H 3450 2750 50  0000 C CNN
	1    3450 2750
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG012
U 1 1 588520E5
P 3350 2850
F 0 "#FLG012" H 3350 2925 50  0001 C CNN
F 1 "PWR_FLAG" H 3350 3024 50  0001 C CNN
F 2 "" H 3350 2850 50  0000 C CNN
F 3 "" H 3350 2850 50  0000 C CNN
	1    3350 2850
	1    0    0    -1  
$EndComp
Text Label 3800 5500 0    60   ~ 0
VCC
$Comp
L Connector_Generic:Conn_01x08 ftP_usb1
U 1 1 58B3F7E8
P 1000 3350
F 0 "ftP_usb1" V 1215 3345 50  0001 C CNN
F 1 "CONN_01X08" V 1124 3345 50  0001 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x08_Pitch2.54mm" H 1000 3350 50  0001 C CNN
F 3 "" H 1000 3350 50  0000 C CNN
F 4 "N" H 1000 3350 60  0001 C CNN "Spice_Netlist_Enabled"
	1    1000 3350
	-1   0    0    1   
$EndComp
$Comp
L power:PWR_FLAG #FLG013
U 1 1 58B41A43
P 1750 2950
F 0 "#FLG013" H 1750 3025 50  0001 C CNN
F 1 "PWR_FLAG" H 1750 3124 50  0001 C CNN
F 2 "" H 1750 2950 50  0000 C CNN
F 3 "" H 1750 2950 50  0000 C CNN
	1    1750 2950
	0    1    1    0   
$EndComp
Text Notes 3650 3200 0    39   ~ 0
+ 3
Text Notes 3650 3050 0    39   ~ 0
- 2
Text Notes 650  3250 0    39   ~ 0
1 vcc
Text Notes 650  3150 0    39   ~ 0
2 D-
Text Notes 650  3050 0    39   ~ 0
3 D+
Text Notes 650  2950 0    39   ~ 0
4 gnd
$Comp
L Connector_Generic:Conn_01x05 ftP_cbus1
U 1 1 58C6F5B6
P 5400 4350
F 0 "ftP_cbus1" V 5615 4345 50  0001 C CNN
F 1 "CONN_01X05" V 5524 4345 50  0001 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x05_Pitch2.54mm" H 5400 4350 50  0001 C CNN
F 3 "" H 5400 4350 50  0000 C CNN
F 4 "N" H 5400 4350 60  0001 C CNN "Spice_Netlist_Enabled"
	1    5400 4350
	0    1    1    0   
$EndComp
$Comp
L Connector_Generic:Conn_01x03 avrP_reset1
U 1 1 58CEA62B
P 6900 2800
F 0 "avrP_reset1" V 7115 2795 50  0001 C CNN
F 1 "CONN_01X05" V 7024 2795 50  0001 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 6900 2800 50  0001 C CNN
F 3 "" H 6900 2800 50  0000 C CNN
F 4 "N" H 6900 2800 60  0001 C CNN "Spice_Netlist_Enabled"
	1    6900 2800
	0    1    1    0   
$EndComp
$Comp
L Connector_Generic:Conn_01x03 ftP_quartz1
U 1 1 58D05C4E
P 3600 3600
F 0 "ftP_quartz1" V 3815 3595 50  0001 C CNN
F 1 "CONN_01X03" V 3724 3595 50  0001 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 3600 3600 50  0001 C CNN
F 3 "" H 3600 3600 50  0000 C CNN
F 4 "N" H 3600 3600 60  0001 C CNN "Spice_Netlist_Enabled"
	1    3600 3600
	-1   0    0    -1  
$EndComp
Text Notes 2650 4350 0    30   ~ 0
3V3
Text Notes 2650 3650 0    30   ~ 0
USB 5V
Text Label 10500 2900 0    60   ~ 0
RTS
Text Label 10500 2800 0    60   ~ 0
DTR
$Comp
L Device:R ftR_reset1
U 1 1 59012447
P 1400 3450
F 0 "ftR_reset1" V 1500 3300 50  0000 L CNN
F 1 "4.7k" V 1400 3350 50  0000 L CIN
F 2 "Discret:R1" V 1330 3450 50  0001 C CNN
F 3 "" H 1400 3450 50  0000 C CNN
	1    1400 3450
	0    1    1    0   
$EndComp
$Comp
L Device:C ftC_reset1
U 1 1 590129A2
P 2000 3650
F 0 "ftC_reset1" V 2150 3550 50  0000 L CNN
F 1 "100n" V 1950 3700 50  0000 L CIN
F 2 "Capacitors_THT:C_Disc_D3.4mm_W2.1mm_P2.50mm" H 2038 3500 50  0001 C CNN
F 3 "" H 2000 3650 50  0000 C CNN
F 4 "C" H 2000 3650 60  0001 C CNN "Spice_Primitive"
F 5 "100n" H 2000 3650 60  0001 C CNN "Spice_Model"
F 6 "Y" H 2000 3650 60  0001 C CNN "Spice_Netlist_Enabled"
	1    2000 3650
	0    1    1    0   
$EndComp
$Comp
L Device:R ftR_reset2
U 1 1 59012B04
P 2000 3950
F 0 "ftR_reset2" V 2100 3750 50  0000 L CNN
F 1 "10k" V 2000 3850 50  0000 L CIN
F 2 "Discret:R3" V 1930 3950 50  0001 C CNN
F 3 "" H 2000 3950 50  0000 C CNN
	1    2000 3950
	0    1    1    0   
$EndComp
$Comp
L Connector_Generic:Conn_01x13 ftP_common1
U 1 1 587B80DC
P 2950 4150
F 0 "ftP_common1" V 3165 4145 50  0001 C CNN
F 1 "CONN_01X13" V 3074 4145 50  0001 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x13_Pitch2.54mm" H 2950 4150 50  0001 C CNN
F 3 "" H 2950 4150 50  0000 C CNN
F 4 "N" H 2950 4150 60  0001 C CNN "Spice_Netlist_Enabled"
	1    2950 4150
	-1   0    0    1   
$EndComp
Text Notes 2650 3850 0    30   ~ 0
USB 5V
Text Notes 2650 3550 0    30   ~ 0
USB 5V
Text Notes 2650 4050 0    30   ~ 0
VCC
Text Notes 2650 4150 0    30   ~ 0
VCC
Text Notes 2650 4450 0    30   ~ 0
3V3
Text Notes 2650 4650 0    30   ~ 0
VCC
Text Notes 2650 4550 0    30   ~ 0
3V3
Text Notes 2650 4750 0    30   ~ 0
GND
$Comp
L power:PWR_FLAG #FLG014
U 1 1 58B4217C
P 3200 3250
F 0 "#FLG014" H 3200 3325 50  0001 C CNN
F 1 "PWR_FLAG" H 3200 3424 50  0001 C CNN
F 2 "" H 3200 3250 50  0000 C CNN
F 3 "" H 3200 3250 50  0000 C CNN
	1    3200 3250
	0    1    1    0   
$EndComp
Text Notes 600  3350 0    39   ~ 0
USB 5V
Text Notes 650  3650 0    39   ~ 0
reset
Text Notes 800  3550 2    39   ~ 0
reset by USB\n(self-powered config)
Text Label 1300 2950 0    60   ~ 0
GND
Text Label 1950 3050 0    60   ~ 0
usb+
Text Label 1950 3150 0    60   ~ 0
usb-
Text Label 2450 3350 0    60   ~ 0
ft_reset
Text Label 2350 4500 1    60   ~ 0
VCC_filter
Text Label 5500 4100 1    60   ~ 0
RXLED
Text Label 5600 4100 1    60   ~ 0
TXLED
Text Label 5200 4100 1    60   ~ 0
SLEEP
Text Label 5400 4100 1    60   ~ 0
TXDEN
Text Notes 2900 3850 0    39   ~ 0
y
Text Notes 2900 3650 0    39   ~ 0
y
Text Notes 2900 3550 0    39   ~ 0
y
Text Notes 2900 4050 0    39   ~ 0
r
Text Notes 2900 4150 0    39   ~ 0
r
Text Notes 2900 3750 0    39   ~ 0
g
Text Notes 2900 4250 0    39   ~ 0
b
Text Notes 2900 4650 0    39   ~ 0
r
Text Notes 2900 4750 0    39   ~ 0
B
Text Notes 2900 3950 0    39   ~ 0
b
Text Notes 2900 4350 0    39   ~ 0
w
Text Notes 2900 4450 0    39   ~ 0
w
Text Notes 2900 4550 0    39   ~ 0
w
Text Notes 950  2950 0    39   ~ 0
B
Text Notes 950  3250 0    39   ~ 0
y
Text Notes 950  3350 0    39   ~ 0
y
Text Notes 950  3450 0    39   ~ 0
w
Text Notes 950  3550 0    39   ~ 0
w
Text Notes 950  3050 0    39   ~ 0
b
Text Notes 950  3150 0    39   ~ 0
b
Text Notes 950  3650 0    39   ~ 0
g
Text Notes 9850 3500 0    39   ~ 0
g
Text Notes 9850 3600 0    39   ~ 0
b
Text Notes 10100 3100 0    39   ~ 0
g
Text Notes 10100 3200 0    39   ~ 0
y
Text Notes 10100 3300 0    39   ~ 0
b
Text Notes 6800 2850 0    39   ~ 0
w
Text Notes 6900 2850 0    39   ~ 0
w
Text Notes 7000 2850 0    39   ~ 0
g
Text Label 7100 2950 0    60   ~ 0
PA1
Text Label 7150 3100 0    60   ~ 0
PA0
Text Label 10500 3700 0    60   ~ 0
white
Text Label 10400 3800 0    60   ~ 0
blue
Text Label 10300 3900 0    60   ~ 0
red
Text Label 10400 4000 0    60   ~ 0
green
Text Label 10300 4100 0    60   ~ 0
yellow
Text Label 9650 3500 0    60   ~ 0
PD0
Text Label 9650 3600 0    60   ~ 0
PD1
Text Label 9650 3700 0    60   ~ 0
PD2
Text Label 9650 3800 0    60   ~ 0
PD3
Text Label 9650 3900 0    60   ~ 0
PD4
Text Label 9650 4000 0    60   ~ 0
PD5
Text Label 9650 4100 0    60   ~ 0
PD6
Text Label 9600 2600 0    60   ~ 0
PB0
Text Label 9600 2700 0    60   ~ 0
PB1
Text Label 9600 2800 0    60   ~ 0
PB2
Text Label 9600 2900 0    60   ~ 0
PB3
Text Label 9600 3000 0    60   ~ 0
PB4
Text Label 9600 3100 0    60   ~ 0
PB5-MOSI
Text Label 9600 3200 0    60   ~ 0
PB6-MISO
Text Label 9600 3300 0    60   ~ 0
PB7-SCK
Wire Wire Line
	5100 3650 5500 3650
Wire Wire Line
	5100 3550 5600 3550
Wire Wire Line
	2200 5500 2350 5500
Wire Wire Line
	1200 3250 1550 3250
Wire Wire Line
	4150 4450 4250 4450
Connection ~ 4250 4450
Wire Wire Line
	2200 5200 2350 5200
Connection ~ 2350 5200
Wire Wire Line
	2200 4700 2350 4700
Connection ~ 2350 4700
Wire Wire Line
	1750 4700 1900 4700
Wire Wire Line
	1750 2950 1750 3650
Wire Wire Line
	1750 5200 1900 5200
Connection ~ 1750 4700
Wire Wire Line
	7150 3100 7250 3100
Wire Wire Line
	7250 3350 7250 3100
Connection ~ 7250 3100
Wire Wire Line
	6750 2950 6750 3100
Wire Wire Line
	6850 3100 6750 3100
Connection ~ 6750 3100
Wire Wire Line
	6750 3650 6750 3850
Wire Wire Line
	6750 3850 7250 3850
Wire Wire Line
	7250 3850 7250 3650
Wire Wire Line
	2350 5100 2350 5200
Wire Wire Line
	8450 1700 8450 2300
Wire Wire Line
	6550 1700 7300 1700
Wire Wire Line
	5750 2750 5750 5250
Wire Wire Line
	5750 5250 10450 5250
Wire Wire Line
	5850 5150 10350 5150
Wire Wire Line
	3450 2750 3800 2750
Connection ~ 2350 5500
Wire Wire Line
	1750 5500 1900 5500
Connection ~ 1750 5200
Wire Wire Line
	3450 2750 3450 4250
Connection ~ 3200 5500
Wire Wire Line
	2350 3700 2350 4700
Wire Wire Line
	3200 4050 3200 4150
Wire Wire Line
	6550 5500 6550 1700
Wire Wire Line
	10250 3900 10850 3900
Wire Wire Line
	10250 3800 10650 3800
Wire Wire Line
	10250 3700 10750 3700
Wire Wire Line
	10250 3600 10350 3600
Wire Wire Line
	10350 3600 10350 5150
Wire Wire Line
	10250 3500 10450 3500
Wire Wire Line
	10450 3500 10450 5250
Wire Wire Line
	5100 3250 6450 3250
Wire Wire Line
	6450 3250 6450 1600
Wire Wire Line
	6450 1600 11050 1600
Wire Wire Line
	5100 3050 6350 3050
Wire Wire Line
	6350 3050 6350 1500
Wire Wire Line
	6350 1500 10950 1500
Wire Wire Line
	10950 1500 10950 3300
Wire Wire Line
	5100 3350 6250 3350
Wire Wire Line
	6250 3350 6250 1400
Wire Wire Line
	6250 1400 10850 1400
Wire Wire Line
	10850 1400 10850 3200
Wire Wire Line
	7300 1850 7300 1700
Connection ~ 7300 1700
Wire Wire Line
	7200 2300 7300 2300
Connection ~ 7300 2300
Wire Wire Line
	7300 2600 7300 2300
Wire Wire Line
	6650 3450 6650 2600
Wire Wire Line
	10500 3000 10750 3000
Wire Wire Line
	5100 3150 6050 3150
Wire Wire Line
	5100 2950 5950 2950
Wire Notes Line
	2600 3950 2550 3950
Wire Notes Line
	2550 3950 2550 4050
Wire Notes Line
	2550 4050 2600 4050
Wire Notes Line
	2600 4150 2550 4150
Wire Notes Line
	2550 4250 2600 4250
Wire Wire Line
	1200 3150 2550 3150
Wire Wire Line
	2550 3150 2550 3050
Wire Wire Line
	2550 3050 3800 3050
Wire Wire Line
	3800 3150 2600 3150
Wire Wire Line
	2600 3150 2600 3100
Wire Wire Line
	2600 3100 2500 3100
Wire Wire Line
	2500 3100 2500 3050
Wire Wire Line
	2500 3050 1200 3050
Wire Wire Line
	5750 2750 5100 2750
Wire Wire Line
	5100 2850 5850 2850
Wire Wire Line
	5850 2850 5850 5150
Wire Wire Line
	5100 3950 5200 3950
Wire Wire Line
	5100 3750 5400 3750
Wire Wire Line
	1650 3350 2250 3350
Wire Wire Line
	6650 2600 6800 2600
Wire Wire Line
	4550 4450 4550 4150
Connection ~ 4350 4450
Wire Wire Line
	4350 4150 4350 4450
Wire Wire Line
	4450 4450 4450 4150
Wire Notes Line
	900  3450 850  3450
Wire Notes Line
	850  3450 850  3550
Wire Notes Line
	850  3550 900  3550
Wire Notes Line
	900  3650 850  3650
Wire Notes Line
	900  3350 850  3350
Wire Wire Line
	5500 3650 5500 4150
Wire Wire Line
	5600 3550 5600 4150
Wire Wire Line
	5400 3750 5400 4150
Wire Wire Line
	5300 3850 5300 4150
Wire Wire Line
	5100 3850 5300 3850
Wire Wire Line
	3350 2850 3800 2850
Wire Notes Line
	2550 4150 2550 4250
Wire Wire Line
	5100 3450 6150 3450
Wire Wire Line
	6150 3450 6150 1300
Wire Wire Line
	6150 1300 10750 1300
Connection ~ 6150 3450
Wire Wire Line
	10750 1300 10750 3000
Wire Wire Line
	6050 3150 6050 1200
Wire Wire Line
	6050 1200 10650 1200
Wire Wire Line
	5950 2950 5950 1100
Wire Wire Line
	5950 1100 10550 1100
Wire Wire Line
	10550 1100 10550 2900
Wire Wire Line
	10250 4000 10750 4000
Wire Wire Line
	10250 4100 10650 4100
Wire Wire Line
	4150 3600 3800 3600
Wire Wire Line
	3800 3850 3800 4350
Connection ~ 3800 4350
Wire Wire Line
	3150 3550 3200 3550
Connection ~ 3200 3550
Wire Wire Line
	3150 4050 3200 4050
Wire Wire Line
	3450 4250 3150 4250
Wire Wire Line
	1250 3450 1200 3450
Wire Wire Line
	1550 3250 1550 3350
Wire Wire Line
	1550 3350 1200 3350
Connection ~ 1550 3250
Connection ~ 1550 3350
Wire Wire Line
	1750 3950 1850 3950
Wire Wire Line
	3200 3250 3200 3550
Wire Wire Line
	2350 3700 3150 3700
Wire Wire Line
	3150 3700 3150 3750
Wire Wire Line
	3350 3950 3150 3950
Wire Wire Line
	3200 3850 3150 3850
Wire Wire Line
	3200 3650 3150 3650
Connection ~ 3200 3650
Wire Wire Line
	3800 4350 3150 4350
Wire Wire Line
	3150 4150 3200 4150
Connection ~ 3200 4150
Wire Wire Line
	3150 4450 3800 4450
Wire Wire Line
	3800 4550 3150 4550
Wire Wire Line
	3150 4650 3200 4650
Connection ~ 3200 4650
Connection ~ 3800 4450
Wire Wire Line
	4650 4150 4650 4250
Wire Wire Line
	4650 4250 4150 4250
Wire Wire Line
	4150 4250 4150 3600
Wire Wire Line
	3350 2850 3350 3950
Wire Wire Line
	3800 3550 3800 3500
Wire Wire Line
	3800 3650 3800 3700
Wire Notes Line
	2500 3750 2450 3750
Wire Notes Line
	2450 3750 2450 3650
Wire Notes Line
	2450 3650 2500 3650
Wire Notes Line
	2600 3750 2550 3750
Wire Notes Line
	2550 3750 2550 3850
Wire Notes Line
	2550 3850 2600 3850
Wire Notes Line
	2500 3850 2450 3850
Wire Notes Line
	2450 3850 2450 3950
Wire Notes Line
	2450 3950 2500 3950
Wire Notes Line
	2500 4250 2450 4250
Wire Notes Line
	2450 4250 2450 4350
Wire Notes Line
	2450 4350 2500 4350
Wire Notes Line
	2850 4250 2900 4250
Wire Notes Line
	2850 3950 2900 3950
Wire Notes Line
	2850 3750 2900 3750
Connection ~ 4450 4450
Wire Wire Line
	4250 4450 4250 4150
Wire Wire Line
	10650 5150 10750 5150
Wire Wire Line
	11050 5150 11050 4550
Wire Wire Line
	10950 4700 10950 5150
Connection ~ 10950 5150
Wire Wire Line
	10850 4850 10850 5150
Connection ~ 10850 5150
Wire Wire Line
	10750 5000 10750 5150
Connection ~ 10750 5150
Wire Wire Line
	11050 3700 11050 4250
Wire Wire Line
	10950 3800 10950 4400
Wire Wire Line
	10850 4200 10850 4550
Wire Wire Line
	10750 4000 10750 4100
Wire Wire Line
	10650 4850 10650 4700
Wire Wire Line
	10750 4700 10750 4400
Wire Wire Line
	10650 4100 10650 4400
Wire Wire Line
	7600 1850 7600 1700
Connection ~ 7600 1700
Wire Wire Line
	7600 2300 7600 2150
Wire Wire Line
	5200 3950 5200 4150
Connection ~ 1750 3950
Wire Wire Line
	1750 3650 1850 3650
Connection ~ 1750 3650
Wire Wire Line
	1750 2950 1200 2950
Wire Wire Line
	2250 3950 2150 3950
Wire Wire Line
	2250 3350 2250 3650
Wire Wire Line
	2250 3650 2150 3650
Connection ~ 2250 3350
Connection ~ 2250 3650
Wire Wire Line
	1650 3350 1650 3650
Wire Wire Line
	1650 3650 1200 3650
Wire Notes Line
	900  3250 900  2950
Wire Notes Line
	900  2950 950  2950
Wire Notes Line
	900  3250 950  3250
Wire Wire Line
	6750 2950 7300 2950
Wire Wire Line
	7300 2950 7300 2900
Wire Notes Line
	6800 2850 6800 2900
Wire Notes Line
	6800 2900 6900 2900
Wire Notes Line
	6900 2900 6900 2850
Wire Wire Line
	11050 1600 11050 3100
Wire Wire Line
	11050 3100 10500 3100
Wire Wire Line
	10850 3200 10500 3200
Wire Wire Line
	10950 3300 10500 3300
Wire Wire Line
	10550 2900 10500 2900
Wire Wire Line
	10650 2800 10500 2800
Wire Wire Line
	10650 1200 10650 2800
Text Notes 10250 3200 0    39   ~ 0
g
Text Notes 10250 3100 0    39   ~ 0
b
Text Notes 10250 3300 0    39   ~ 0
y
Text Notes 5550 4400 0    60   ~ 0
b
Text Notes 5450 4400 0    60   ~ 0
g
Text Notes 5350 4400 0    60   ~ 0
y
Text Notes 5250 4400 0    60   ~ 0
r
Text Notes 5150 4400 0    60   ~ 0
B
Text Notes 10000 3500 0    39   ~ 0
g
Text Notes 10000 3600 0    39   ~ 0
b
Wire Wire Line
	4250 4450 4350 4450
Wire Wire Line
	2350 5200 2350 5500
Wire Wire Line
	2350 4700 2350 4800
Wire Wire Line
	1750 4700 1750 5200
Wire Wire Line
	6750 3100 6750 3350
Wire Wire Line
	2350 5500 3200 5500
Wire Wire Line
	1750 5200 1750 5500
Wire Wire Line
	3200 5500 6550 5500
Wire Wire Line
	7300 1700 7600 1700
Wire Wire Line
	7300 2300 7600 2300
Wire Wire Line
	7300 2300 7300 2150
Wire Wire Line
	4350 4450 4450 4450
Wire Wire Line
	6150 3450 6650 3450
Wire Wire Line
	3800 4350 3800 4450
Wire Wire Line
	3200 3550 3200 3650
Wire Wire Line
	1550 3250 3200 3250
Wire Wire Line
	1550 3350 1550 3450
Wire Wire Line
	3200 3650 3200 3850
Wire Wire Line
	3200 4150 3200 4650
Wire Wire Line
	3200 4650 3200 5500
Wire Wire Line
	3800 4450 3850 4450
Wire Wire Line
	3800 4450 3800 4550
Wire Wire Line
	4450 4450 4550 4450
Wire Wire Line
	10950 5150 11050 5150
Wire Wire Line
	10850 5150 10950 5150
Wire Wire Line
	10750 5150 10850 5150
Wire Wire Line
	7600 1700 8450 1700
Wire Wire Line
	1750 3950 1750 4700
Wire Wire Line
	1750 3650 1750 3950
Wire Wire Line
	2250 3350 3800 3350
Wire Wire Line
	2250 3650 2250 3950
Wire Wire Line
	6900 2600 7000 2600
Wire Wire Line
	1200 3550 1200 3650
Connection ~ 1200 3650
Connection ~ 3800 4550
Connection ~ 6750 3850
Connection ~ 3200 3250
Connection ~ 3450 2750
Connection ~ 3350 2850
Connection ~ 1750 2950
Wire Wire Line
	7000 2600 7300 2600
Connection ~ 7000 2600
$Comp
L power:GND #PWR02
U 1 1 57FBCCB8
P 11050 5150
F 0 "#PWR02" H 11050 4900 50  0001 C CNN
F 1 "GND" H 11055 4977 50  0001 C CNN
F 2 "" H 11050 5150 50  0000 C CNN
F 3 "" H 11050 5150 50  0000 C CNN
	1    11050 5150
	1    0    0    -1  
$EndComp
Connection ~ 11050 5150
Connection ~ 4550 4450
Wire Wire Line
	7300 2600 7350 2600
Connection ~ 7300 2600
Wire Wire Line
	7350 2900 7300 2900
Wire Wire Line
	7250 3100 7350 3100
Wire Wire Line
	9550 2600 9950 2600
Wire Wire Line
	9550 2700 9950 2700
Wire Wire Line
	9550 2800 9950 2800
Wire Wire Line
	9550 2900 9950 2900
Wire Wire Line
	9550 3000 9950 3000
Wire Wire Line
	9550 3100 9950 3100
Wire Wire Line
	9550 3200 9950 3200
Wire Wire Line
	9550 3300 9950 3300
Wire Wire Line
	9550 3500 9700 3500
Wire Wire Line
	9550 3600 9700 3600
Wire Wire Line
	9550 3700 9700 3700
Wire Wire Line
	9550 3800 9700 3800
Wire Wire Line
	9550 3900 9700 3900
Wire Wire Line
	9550 4000 9700 4000
Wire Wire Line
	9550 4100 9700 4100
$EndSCHEMATC
