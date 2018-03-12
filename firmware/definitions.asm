;***********************************************************  common.asm special registers summary
; здесь можно поменять регитры, используемые в common.asm

.equ MCU_MHZ = 20 ; частота кварца в MHz для вычисления задержек DELAY16 DELAY24
.def TEMP					= r25
.def UART_byte				= r24

;***********************************************************  project specific registers summary
; здесь описывать регистры, используемые в проекте

.def ADC_HIGH_r				= r16							;							старший байт сэмпла
.def ADC_LOW_r				= r17							;							младший байт сэмпла

.def ADC_INC_H_r			= r31;ZH						;							старший байт индекса
.def ADC_INC_L_r			= r30;ZL						;							младший байт индекса

.def PING_WAITING_HIGH_r	= r18							;							старший байт счетчика ожидания пинга
.def PING_WAITING_LOW_r		= r19							;							младший байт счетчика ожидания пинга
.def PING_INC_r				= r20							;							пинг-индекс

.def COMMAND_r				= r21							;							содержит принятую с хоста команду

.equ PING_WAITING_HIGH		= 0x14							;							количество сэмплов, в ходе которых ожидается пинг
.equ PING_WAITING_LOW		= 0x88							;							5000 iterations = половина секунды

.def NOP_L_r				= r26							;							счетчик простоя МК
.def NOP_H_r				= r27

;***********************************************************  UART configuration

; http://wormfood.net/avrbaudcalc.php
.MACRO UART_conf_9600 ; at ~9600-8-odd-2 520=0x208 ( ODD = UPM1+UPM0 ) (2 stop-bit = USBS)
	OUT_ UBRRH, 0
	OUT_ UBRRL, 0x81
	OUT_ UCSRA, 0
	OUT3 UCSRB, RXCIE, RXEN, TXEN // rec_int rec_enable, tr_enable
	OUT5 UCSRC, UPM1, UPM0, USBS, UCSZ1, UCSZ0
.ENDMACRO

.MACRO ya_UART_conf ; ~500K-8-N-1  400clk/byte
	OUT_ UBRRH, 0
	OUT_ UBRRL, 0x4
	;OUT_ UCSRA, 0 ; Normal Speed
	OUT1 UCSRA, U2X ; Double Speed Operation (U2X)
	OUT3 UCSRB, RXCIE, RXEN, TXEN	// rec_interrupt, rec_enable, tr_enable
	OUT2 UCSRC, UCSZ1, UCSZ0		// 1 stop bit, 8-bit data
.ENDMACRO

;*********************************************************** watch dog 8

.MACRO WDT8_on
cbi  STATUS, C
WDR ; Watchdog Reset
OUT2 WDTCSR, WDE, WDCE
OUT3 WDTCSR, WDIE, WDP3, WDP0
.ENDMACRO

.MACRO WDT_off
OUT_ WDTCSR, 0
OUT_ MCUSR, 0
.ENDMACRO

.MACRO TIMER_on
OUT_ OCR1AH, 0x98 ; 5000 0x9899
OUT_ OCR1AL, 0x99
OUT1 TIFR, OCF1A
OUT1 TIMSK, OCIE1A
out  TCNT1H, ZERO
out  TCNT1L, ZERO
out  TCCR1A, ZERO
OUT3 TCCR1B, CTC1, CS12, CS10
.ENDMACRO

;.equ PCMSK0 = PCMSK
;.equ PCIE0 = PCIE
;.equ PCIF0 = PCIF