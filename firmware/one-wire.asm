;******************************** one-wire ******************************

.def W1_byte = r23

;*** initialization sequence of 1-wire bus
;U r26 r27 TERM
; инициализирует 1w, в TERM номер текущего термометра
; использует регистры DELAY16 TERM
; возвращает SREG_N=1 если не удачно
w1_init:
		rcall TERM_set_output
		DELAY16 480
		rcall TERM_set_input
		DELAY16 100
		rcall TERM_set_state_to_T
		DELAY16 380
		cln
		brtc PC+2 ; if t==0 return n=0
			sen
		ret


; передает байт на шину 1w
; текущий термометр в TERM
; использует TEMP r0 DELAY16
; входящий байт в W1_byte
w1_write_byte:
		ldi TEMP, 1
	w1wbl:
		rcall TERM_set_output
		mov r0, W1_byte
		and r0, TEMP
		breq w1wb0;if 0 then branch
			DELAY16 6
			rcall TERM_set_input
			DELAY16 64
			rjmp w1wbe
		w1wb0:
			DELAY16 60
			rcall TERM_set_input
			DELAY16 10
  	w1wbe:
		lsl TEMP
		brcc w1wbl
		ret

; принимает байт с шины 1w
; использует r0 TEMP DELAY16
; возвращает байт в W1_byte
w1_read_byte:; r2
		clr W1_byte
		ldi TEMP, 1
	w1rbl:
		rcall TERM_set_output
		DELAY16 6
		rcall TERM_set_input
		DELAY16 9
		rcall TERM_set_state_to_T
		brtc PC+2 ; if T==0 then skip
			or W1_byte, TEMP
		DELAY16 55
		lsl TEMP
		brcc w1rbl
		ret
