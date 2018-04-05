; tn2313 2kB 128B 20Mgz
.include "tn2313def.inc"
;**************************************************************
;************************   IVECTOR   *************************
;**************************************************************
.cseg
; Reset
  .org 0
  RJMP ENTRY_POINT
; External Interrupt Request 0
  .org	INT0addr
  reti
; External Interrupt Request 1
  .org	INT1addr
  reti
; Timer/Counter1 Capture Event
  .org	ICP1addr
  reti
; Timer/Counter1 Compare Match A
  .org	OC1Aaddr
  reti
; Timer/Counter1 Overflow
  .org	OVF1addr
  reti
; Timer/Counter0 Overflow
  .org	OVF0addr
  reti
; USART, Rx Complete
  .org	URXCaddr
  rjmp UART_RXC
; USART Data Register Empty
  .org	UDREaddr
  reti
; USART, Tx Complete
  .org	UTXCaddr
  reti
; Analog Comparator
  .org	ACIaddr
  reti
; Pin Change Interrupt
  .org	PCIaddr
  reti
; Timer/Counter1 Compare Match B
  .org	OC1Baddr
  reti
; Timer/Counter0 Compare Match A
  .org	OC0Aaddr
  reti
; Timer/Counter0 Compare Match B
  .org	OC0Baddr
  reti
; USI Start Condition
  .org	USI_STARTaddr
  reti
; USI Overflow
  .org	USI_OVFaddr
  reti
; EEPROM Ready
  .org	ERDYaddr
  reti
; Watchdog Timer Overflow
  .org	WDTaddr
  reti

.dseg
.org SRAM_START
temp_v:         .byte 16 ; пример выделения переменной в SRAM

;**************************************************************
;************************   INCLUDES   ************************
;**************************************************************

.cseg
.org 32 ; page align , сдвиг 32 - код пишется после вектора прирываний (см. выше)

rjmp ENTRY_POINT
.include "pcb_specific_macros.inc"
.include "common.asm"
.include "definitions.asm"
.include "utils.asm"
.include "mcp3204.asm"
.include "one-wire.inc"
.include "eeprom.inc"

;**************************************************************
;*************************   ENTRY   **************************
;**************************************************************
ENTRY_POINT:
		INIT_STACK
		UART_conf_9600										;							стандартные настройки 9600
		rcall UART_flush
		sei													;							включить прерывания

	main_loop:
		DELAY24  1000000
		rjmp main_loop


;/////////////////////////////////////////////////////////// global interrupt : UART receive
UART_RXC:
		IN UART_byte, UDR
		reti
