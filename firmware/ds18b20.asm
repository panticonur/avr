; =================================================================


.def TERM = r22 ; регистр отвечающий за номер текущего термометра
.def TERM_hi = r21 ; хранит значение температуры, старший байт
.def TERM_low = r20 ; хранит значение температуры, младший байт ; используется для задания точности термометра

; проверяет номер на валидность
; на вход принимает TERM  с номером термометра
; устанавливаиет устанавливается флаг N если не найден номер
;I TERM
;O SREG_T
TERM_is_defined:
		cln
		cpi TERM, TERM0
		brne PC+2
		ret
		cpi TERM, TERM1
		brne PC+2
		ret
		cpi TERM, TERM2
		brne PC+2
		ret
		sen
		ret

; на вход принимает TERM  с номером термометра
;I TERM
TERM_set_output:
		cpi TERM, TERM0
		brne TERM_set_out_cp1
		TERM0_set_output
		ret
	TERM_set_out_cp1:
		cpi TERM, TERM1
		brne TERM_set_out_cp2
		TERM1_set_output
		ret
	TERM_set_out_cp2:
		cpi TERM, TERM2
		brne TERM_set_out_end
		TERM2_set_output
	TERM_set_out_end:
		ret

; на вход принимает TERM  с номером термометра
;I TERM
TERM_set_input:
		cpi TERM, TERM0
		brne TERM_set_in_cp1
		TERM0_set_input
		ret
	TERM_set_in_cp1:
		cpi TERM, TERM1
		brne TERM_set_in_cp2
		TERM1_set_input
		ret
	TERM_set_in_cp2:
		cpi TERM, TERM2
		brne TERM_set_in_end
		TERM2_set_input
	TERM_set_in_end:
		ret

; на вход принимает TERM  с номером термометра
; устанавливает состояние текущего термометра в T
;I TERM
;O SREG_T
TERM_set_state_to_T:
		clt
		cpi TERM, TERM0
		brne TERM_state_cp1
		TERM0_skip_if_0
			set
		ret
	TERM_state_cp1:
		cpi TERM, TERM1
		brne TERM_state_cp2
		TERM1_skip_if_0
			set
		ret
	TERM_state_cp2:
		cpi TERM, TERM2
		brne TERM_state_end
		TERM2_skip_if_0
			set
	TERM_state_end:
		ret


; задает разрешение термометра
; TERM текущий термометр
; принимает TERM_low как байт настройки термометра
;U TEMP TERM TERM_low DELAY16 W1_byte r0
; 9  бит - 0x1F - 93.75ms
; 10 бит - 0x3F - 187.5ms
; 11 бит - 0x5F - 375ms
; 12 бит - 0x7F - 750ms
set_term_resolution:
		;INITIALIZATION PROCEDURE
		rcall TERM_is_defined
		brpl PC+3
			rcall error_SET_TERM_RES_term_not_defined
			ret
		rcall w1_init
		brpl PC+3
			rcall error_SET_TERM_RES_w1_not_init
			ret
		;WRITE COMMAND skip rom (0xCC)
		ldi W1_byte, 0xCC
		rcall w1_write_byte
		;WRITE COMMAND WRITE SCRATCHPAD [4Eh]
		ldi W1_byte, 0x4E
		rcall w1_write_byte
		;WRITE TH register
		ldi W1_byte, 0x7F
		rcall w1_write_byte
		;WRITE TL register
		ldi W1_byte, 0x80
		rcall w1_write_byte
		;WRITE configuration register

		cpi TERM_low, 9
		brne str_next_res_10
			ldi W1_byte, 0x1F
			rjmp str_write

	str_next_res_10:
		cpi TERM_low, 10
		brne str_next_res_11
			ldi W1_byte, 0x3F
			rjmp str_write

	str_next_res_11:
		cpi TERM_low, 11
		brne str_next_res_12
			ldi W1_byte, 0x5F
			rjmp str_write

	str_next_res_12:
		cpi TERM_low, 12
		brne str_next_end
			ldi W1_byte, 0x7F
			rjmp str_write

	str_next_end:
		rcall error_SET_TERM_RES_invalid_res
		ret

	str_write:
		rcall w1_write_byte
		ret

; получает температуру с DS18B20 по шине 1w
; использует регистры DELAY16 r0 TERM TEMP W1_byte TERM_hi TERM_low SREG_T
; TERM_low - младший байт температуры, TERM_hi - старший
get_term:
		;INITIALIZATION PROCEDURE
		rcall TERM_is_defined
		brpl PC+3
			rcall error_GET_TERM_term_not_defined
			ret
		rcall w1_init
		brpl PC+3
			rcall error_GET_TERM_w1_not_init1
			ret
		;WRITE COMMAND skip rom (0xCC)
		ldi W1_byte, 0xCC
		rcall w1_write_byte
		;WRITE COMMAND convert t (0x44)
		ldi W1_byte, 0x44
		rcall w1_write_byte

		;wait
		grt_wait_convert:
			DELAY16 55
			rcall TERM_set_output
			DELAY16 6
			rcall TERM_set_input
			DELAY16 9
			rcall TERM_set_state_to_T
			brtc grt_wait_convert

		;get temp
		rcall w1_init
		brpl PC+3
			rcall error_GET_TERM_w1_not_init2
			ret
		;WRITE COMMAND skip rom (0xCC)
		ldi W1_byte, 0xCC
		rcall w1_write_byte
		;WRITE COMMAND read scratchpad (0xBE)
		ldi W1_byte, 0xBE
		rcall w1_write_byte

		;READ BYTE
		rcall W1_read_byte
		mov TERM_low, W1_byte

		rcall w1_read_byte
		mov TERM_hi, W1_byte
		ret

; отправляет два байта температуры  TERM_low + TERM_hi
; во время получение температуры горит синий
; возможны ошибки error_GET_TERM_term_not_defined error_GET_TERM_w1_not_init1 error_GET_TERM_w1_not_init2
;U UART_byte TEMP r0 TERM TERM_low TERM_hi DELAY16 W1_byte SREG_T SREG_N
get_term_and_send:
;		LED_BLUE_on
		rcall get_term
;		LED_BLUE_off
		brpl PC+2
			ret
		mov UART_byte, TERM_hi
		rcall UART_tx
		mov UART_byte, TERM_low
		rcall UART_tx
		ret

set_term_resolution_FLASH:
		LED_BLUE_on
		DELAY24 300000
		LED_BLUE_off
		LED_YELLOW_on
		DELAY24 400000
		rcall get_term_num_and_flash
		rcall set_term_resolution
		DELAY24 100000
		LED_YELLOW_off
		ret

; достает номер термометра из UART_byte в TERM и мигает
get_term_num:
		set
		rjmp PC+2
get_term_num_and_flash:
		clt
		mov TERM, UART_byte
		swap TERM
		ANDi TERM, COMMAND_MASK
		swap TERM
		mov TEMP, TERM
		brtc PC+2
			ret
; мигает TEMP+1 количество раз
index_flash:
			LED_BLUE_on
			DELAY24 50000
			LED_BLUE_off
			DELAY24 150000
			TST TEMP
			brne PC+2
				ret
			dec TEMP
			rjmp index_flash

key_trigger_flash:
;		rcall delay_1second
		DELAY24 500000
		rcall index_flash
		ret

key_on_trigger_flash:
		LED_RED_on
		rcall key_trigger_flash
		LED_RED_off
		ret

key_off_trigger_flash:
		;LED_RED_on
		LED_YELLOW_on
		rcall key_trigger_flash
		LED_YELLOW_off
		;LED_RED_off
		ret

;============================================================================================================================
;                                                          ERRORS

; младшие 4 бита кода ошибки равны количеству миганий красного
error_SET_TERM_RES_term_not_defined:
		ldi UART_byte, 0xE4
		rjmp send_error
error_SET_TERM_RES_w1_not_init:
		ldi UART_byte, 0xE1
		rjmp send_error
error_SET_TERM_RES_invalid_res:
		ldi UART_byte, 0xE6
		rjmp send_error
error_GET_TERM_term_not_defined:
		ldi UART_byte, 0xE2
		rjmp send_error
error_GET_TERM_w1_not_init1:
		ldi UART_byte, 0xE3
		rjmp send_error
error_GET_TERM_w1_not_init2:
		ldi UART_byte, 0xE5
		rjmp send_error
	send_error:
		LED_YELLOW_off
		LED_BLUE_off
		LED_RED_off
		rcall delay_1second
		rcall UART_tx
		clr TEMP
		andi UART_byte, 0x0F
	error_loop:
		cp TEMP, UART_byte
		breq error_end
			LED_RED_on
			rcall delay_1second
			LED_RED_off
			rcall delay_1second
			inc TEMP
			rjmp error_loop
	error_end:
		ret