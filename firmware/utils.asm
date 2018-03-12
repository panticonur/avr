; примеры часто используемых функций

; мигает определенное количество раз (TEMP)
flashing:
		TST TEMP
		brne PC+2
			ret
		LED_BLUE_on
		DELAY24  50000
		LED_RED_on
		DELAY24  50000
		LED_YELLOW_on
		DELAY24  50000
		LED_BLUE_off
		DELAY24  50000
		LED_RED_off
		DELAY24  50000
		LED_YELLOW_off
		DELAY24 500000
		dec TEMP
		rjmp flashing