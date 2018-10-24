; используемые дефиниции, должны быть указаны в definitions.inc
;.equ MCU_MHZ = 20 ; частота кварца в MHz для вычисления задержек DELAY16 DELAY24
;.def TEMP						= r25
;.def UART_byte					= r24
;.def DELAY_24_r				= r28
;.def DELAY_16_r				= r27
;.def DELAY_08_r				= r26

;-----------------------------------------------------------

; legend
;I - input parameters
;O - output parameters
;U - in-use registers


;*** initAPI function must be called in initial code section
;U TEMP
.MACRO INIT_STACK
	ldi TEMP, LOW(RAMEND)
	OUT SPL, TEMP
	.IFDEF SPH
		ldi TEMP, HIGH(RAMEND)
		OUT SPH, TEMP
	.ENDIF
.ENDMACRO

;*** copy SRAM memory function
;I target adress set to X
;I source adress set to Y
;I size set to Z
;U r26-r31 TEMP
SRAM_copy:
    add ZL, XL
	adc ZH, XH
    copy_loop:
      cp   ZL, XL
	  brne PC+3
	  cpc  ZH, XH
	  breq copy_ret
	  ld   TEMP, Y+
	  st   X+, TEMP
	  rjmp copy_loop
    copy_ret:
	ret

.MACRO SetAddress ; первый параметр - буква X Y Z парного регистра; второй - label переменной в SRAM в .dsec
ldi    @0H, HIGH(@1)
ldi    @0L, LOW(@1)
.ENDMACRO

.MACRO LoadInt ; записать число 0xFfFfFfFf в SRAM по адресу, указанному в регистре X
ldi    TEMP, LOW(@0)
st     X+, TEMP
ldi    TEMP, BYTE2(@0)
st     X+, TEMP
ldi    TEMP, BYTE3(@0)
st     X+, TEMP
ldi    TEMP, BYTE4(@0)
st     X+, TEMP
.ENDMACRO

;***************************   UART   **************************************

;*** Receives byte from UART
;O UART_byte
;U UART_byte
UART_rx:
	SBIS UCSRA, RXC
	RJMP UART_rx
	IN UART_byte, UDR
	RET

;*** Sends byte to UART
;I UART_byte
;U UART_byte
UART_tx:
	SBIS UCSRA, UDRE
	RJMP UART_tx
	OUT UDR, UART_byte
	RET

;*** Skip incoming bytes
;U UART_byte
UART_flush:
	sbis UCSRA, RXC
		ret
	in UART_byte, UDR
	rjmp UART_flush

;***************************** DELAY *********************************

;*** delay up to 0xFFFF, 4 cycles iteration
;I delay time in microseconds >=1   ; max 13107us
;I MCU_MHZ equ
;U DELAY_08_r DELAY_16_r
.MACRO DELAY16 ; зависит от частоты MCU и от тактов в цикле
	ldi    DELAY_16_r, HIGH(@0*MCU_MHZ/4-3)
	ldi    DELAY_08_r, LOW(@0*MCU_MHZ/4-3)
	rcall delay_loop_16
.ENDMACRO

delay_loop_16:
	subi DELAY_08_r, 1
	sbci DELAY_16_r, 0
	brcc delay_loop_16
	ret

;*** delay up to 0xFFFFFF, 5 cycles iteration
;I delay time in microseconds >=1  ; max 4194304us
;I MCU_MHZ equ
;U DELAY_08_r DELAY_16_r DELAY_24_r
.MACRO DELAY24 ; зависит от частоты MCU и от тактов в цикле
	ldi    DELAY_24_r, BYTE3(@0*MCU_MHZ/5-3)
	ldi    DELAY_16_r, BYTE2(@0*MCU_MHZ/5-3)
	ldi    DELAY_08_r,   LOW(@0*MCU_MHZ/5-3)
	rcall delay_loop_24
	nop
.ENDMACRO

;.MACRO DELAY24_reset  ; зачем?
;	clc
;	ldi DELAY_24_r, 1
;	ldi DELAY_16_r, 1
;	ldi DELAY_08_r, 1
;.ENDMACRO

;delay_1second: ; популярные задержки выгодно выносить, но не в этом файле.
;	ldi DELAY_08_r, 0xFC
;	ldi DELAY_16_r, 0x08
;	ldi DELAY_24_r, 0x3d
delay_loop_24:
	subi DELAY_08_r, 1
	sbci DELAY_16_r, 0
	sbci DELAY_24_r, 0
	brcc delay_loop_24
	ret

;delay_24_push: ; сохраняет состояние счетчика задержки
.MACRO DELAY24_push
	push DELAY_08_r
	push DELAY_16_r
	push DELAY_24_r
.ENDMACRO
	;ret

;delay_24_pop:
.MACRO DELAY24_pop
	pop DELAY_24_r
	pop DELAY_16_r
	pop DELAY_08_r
	CLC
.ENDMACRO
	;ret

;******************************************************************************************

.MACRO LDI_ ; сохраняет байт в регистры 0-15 так как для них нет прямой операции LDI
LDI TEMP, @1
mov @0, TEMP
.ENDMACRO

.MACRO OUT_   ; записывает целый байт в I/O
LDI TEMP, @1
OUT @0, TEMP
.ENDMACRO

.MACRO LDI1 ; первый параметр - имя регистра, второй - номер бита от 0 до 7 для установки
ldi    @0, (1<<@1)
.ENDMACRO

.MACRO LDI2 ; два бита
ldi    @0, (1<<@1) | (1<<@2)
.ENDMACRO

.MACRO LDI3
ldi    @0, (1<<@1) | (1<<@2) | (1<<@3)
.ENDMACRO

.MACRO LDI4
ldi    @0, (1<<@1) | (1<<@2) | (1<<@3) | (1<<@4)
.ENDMACRO

.MACRO LDI5
ldi    @0, (1<<@1) | (1<<@2) | (1<<@3) | (1<<@4) | (1<<@5)
.ENDMACRO

.MACRO LDI6
ldi    @0, (1<<@1) | (1<<@2) | (1<<@3) | (1<<@4) | (1<<@5) | (1<<@6)
.ENDMACRO

.MACRO LDI7
ldi    @0, (1<<@1) | (1<<@2) | (1<<@3) | (1<<@4) | (1<<@5) | (1<<@6) | (1<<@7)
.ENDMACRO

.MACRO LDI8
ldi    @0, (1<<@1) | (1<<@2) | (1<<@3) | (1<<@4) | (1<<@5) | (1<<@6) | (1<<@7) | (1<<@8)
.ENDMACRO


.MACRO OUT1 ; записывает биты в I/O
LDI1 TEMP, @1
OUT @0, TEMP
.ENDMACRO

.MACRO OUT2
LDI2 TEMP, @1, @2
OUT @0, TEMP
.ENDMACRO

.MACRO OUT3
LDI3 TEMP, @1, @2, @3
OUT @0, TEMP
.ENDMACRO

.MACRO OUT4
LDI4 TEMP, @1, @2, @3, @4
OUT @0, TEMP
.ENDMACRO

.MACRO OUT5
LDI5 TEMP, @1, @2, @3, @4, @5
OUT @0, TEMP
.ENDMACRO

.MACRO OUT6
LDI6 TEMP, @1, @2, @3, @4, @5, @6
OUT @0, TEMP
.ENDMACRO

.MACRO OUT7
LDI7 TEMP, @1, @2, @3, @4, @5, @6, @7
OUT @0, TEMP
.ENDMACRO

.MACRO OUT8
LDI8 TEMP, @1, @2, @3, @4, @5, @6, @7, @8
OUT @0, TEMP
.ENDMACRO
