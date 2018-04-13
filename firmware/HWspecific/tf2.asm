;макросы характерные для PCB "tf2"
;нужно копировать в проект так как есть возможность переназначить порты.
;SBI 2 cycles
;CBI 2 cycles
;===========================================================	LEDs

;-----------------------------------------------------------	WHITE led

.MACRO LED_WHITE_init
SBI  DDRD, DDD2
.ENDMACRO

.MACRO LED_WHITE_on
sbi   PORTD, PORTD2
.ENDMACRO

.MACRO LED_WHITE_off
cbi   PORTD, PORTD2
.ENDMACRO

;-----------------------------------------------------------	BLUE led

.MACRO LED_BLUE_init
SBI  DDRD, DDD3
.ENDMACRO

.MACRO LED_BLUE_on
sbi   PORTD, PORTD3
.ENDMACRO

.MACRO LED_BLUE_off
cbi   PORTD, PORTD3
.ENDMACRO

;-----------------------------------------------------------	RED led

.MACRO LED_RED_init
SBI  DDRD, DDD4
.ENDMACRO

.MACRO LED_RED_on
sbi   PORTD, PORTD4
.ENDMACRO

.MACRO LED_RED_off
cbi   PORTD, PORTD4
.ENDMACRO

;-----------------------------------------------------------	GREEN led

.MACRO LED_GREEN_init
SBI  DDRD, DDD5
.ENDMACRO

.MACRO LED_GREEN_on
sbi   PORTD, PORTD5
.ENDMACRO

.MACRO LED_GREEN_off
cbi   PORTD, PORTD5
.ENDMACRO

;-----------------------------------------------------------	YELLOW led

.MACRO LED_YELLOW_init
SBI  DDRD, DDD6
.ENDMACRO

.MACRO LED_YELLOW_on
sbi   PORTD, PORTD6
.ENDMACRO

.MACRO LED_YELLOW_off
cbi   PORTD, PORTD6
.ENDMACRO

;===========================================================	TEST0

.MACRO TEST0_init
SBI  DDRB, DDB0
.ENDMACRO

.MACRO TEST0_on
sbi   PORTB, PORTB0
.ENDMACRO

.MACRO TEST0_off
cbi   PORTB, PORTB0
.ENDMACRO
