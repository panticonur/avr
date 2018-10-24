; это шаблон, файл копируется в проект для правок и добавления новых переменных
;***********************************************************  common.asm special registers summary
; здесь можно поменять регитры, используемые в common.asm

.equ MCU_MHZ = 20 ; частота кварца в MHz для вычисления задержек DELAY16 DELAY24
.def TEMP					= r25
.def UART_byte				= r24
.def DELAY_24_r				= r28
.def DELAY_16_r				= r27
.def DELAY_08_r				= r26

;***********************************************************  project specific registers summary
; здесь описывать регистры, используемые в проекте

.def VAR1_r				= r16

.def VAR2_H_r			= r31;ZH
.def VAR2_L_r			= r30;ZL

.equ DEF1				= 0x1

;***********************************************************  UART configuration

; http://wormfood.net/avrbaudcalc.php
.MACRO UART_conf_9600 ; at ~9600-8-odd-2 520=0x208 ( ODD = UPM1+UPM0 ) (2 stop-bit = USBS)
	OUT_ UBRRH, 0
	OUT_ UBRRL, 0x81
	OUT_ UCSRA, 0 							; Normal Speed
	OUT3 UCSRB, RXCIE, RXEN, TXEN			; rec_interrupt, rec_enable, tr_enable
	OUT5 UCSRC, UPM1, UPM0, USBS, UCSZ1, UCSZ0
.ENDMACRO

.MACRO UART_conf_500K ; ~500K-8-N-1  400clk/byte
	OUT_ UBRRH, 0
	OUT_ UBRRL, 0x4
	;OUT_ UCSRA, 0 							; Normal Speed
	OUT1 UCSRA, U2X 						; Double Speed Operation (U2X)
	OUT3 UCSRB, RXCIE, RXEN, TXEN			; rec_interrupt, rec_enable, tr_enable
	OUT2 UCSRC, UCSZ1, UCSZ0				; 1 stop bit, 8-bit data
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