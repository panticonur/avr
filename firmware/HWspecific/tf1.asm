;макросы, характерные для PCB "tf1"

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

;-----------------------------------------------------------	YELLOW led

.MACRO LED_YELLOW_init
SBI  DDRD, DDD5
.ENDMACRO

.MACRO LED_YELLOW_on
sbi   PORTD, PORTD5
.ENDMACRO

.MACRO LED_YELLOW_off
cbi   PORTD, PORTD5
.ENDMACRO

;-----------------------------------------------------------	GREEN led

.MACRO LED_GREEN_init
SBI  DDRD, DDD6
.ENDMACRO

.MACRO LED_GREEN_on
sbi   PORTD, PORTD6
.ENDMACRO

.MACRO LED_GREEN_off
cbi   PORTD, PORTD6
.ENDMACRO

;===========================================================	KEYs

;-----------------------------------------------------------	KEY0

.equ KEY0 = 0

.MACRO KEY0_init
SBI  DDRD, DDD5
.ENDMACRO

.MACRO KEY0_on
sbi   PORTD, PORTD5
.ENDMACRO

.MACRO KEY0_off
cbi   PORTD, PORTD5
.ENDMACRO

;-----------------------------------------------------------	KEY1

.equ KEY1 = 1

.MACRO KEY1_init
SBI  DDRD, DDD6
.ENDMACRO

.MACRO KEY1_on
sbi   PORTD, PORTD6
.ENDMACRO

.MACRO KEY1_off
cbi   PORTD, PORTD6
.ENDMACRO
