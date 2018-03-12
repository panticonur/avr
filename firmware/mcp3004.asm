;//////////////////////////////////////// ADC MCP3004 pins binding


;---------------------------------------- Serial Clock | pin=12
.MACRO ADC_CLK_init
sbi		DDRB, DDB0 ; set as output
ADC_CLK_1
.ENDMACRO

.MACRO ADC_CLK_0
cbi		PORTB, PORTB0
.ENDMACRO

.MACRO ADC_CLK_1
sbi		PORTB, PORTB0
.ENDMACRO

;---------------------------------------- Serial Data Out | pin=13
.MACRO ADC_R_init ; receive from ADC
cbi		DDRB, DDB1 ; set as input
cbi		PORTB, PORTB1
.ENDMACRO

.MACRO ADC_R_skip_if_0
sbic PINB, PINB1
.ENDMACRO

.MACRO ADC_R_init_out
sbi		DDRB, DDB1
ADC_R_1
.ENDMACRO

.MACRO ADC_R_0
cbi		PORTB, PORTB1
.ENDMACRO

.MACRO ADC_R_1
sbi		PORTB, PORTB1
.ENDMACRO

;---------------------------------------- Serial Data In | pin=14
.MACRO ADC_T_init	; transmit to ADC
sbi		DDRB, DDB2
;ADC_T_1 ; было закоменчено ; можно закомментировать - 1 по умолчанию
.ENDMACRO

.MACRO ADC_T_0
cbi		PORTB, PORTB2
.ENDMACRO

.MACRO ADC_T_1
sbi		PORTB, PORTB2
.ENDMACRO

;---------------------------------------- Chip Select/Shutdown Input | pin=15
.MACRO ADC_CS_init
sbi		DDRB, DDB3
ADC_CS_1
.ENDMACRO

.MACRO ADC_CS_0
cbi		PORTB, PORTB3
.ENDMACRO

.MACRO ADC_CS_1
sbi		PORTB, PORTB3
.ENDMACRO


;***********************************************************

.def ADC_HIGH_r = r16										; сэмпл
.def ADC_LOW_r = r17

.MACRO DELAY_CLK
DELAY16 2
.ENDMACRO

ADC_get:
  ;0
    ADC_CLK_0
    DELAY_CLK
    nop nop
    ADC_CLK_1
    DELAY_CLK
ADC_get_loop:
  ;1  +2        START
    ADC_CS_0
    ADC_T_1
    ADC_CLK_0
    DELAY_CLK
    nop nop
    ADC_CLK_1
    DELAY_CLK
  ;2  +1        Single-ended
    nop
    ADC_T_1
    ADC_CLK_0
    DELAY_CLK
    nop nop
    ADC_CLK_1
    DELAY_CLK
  ;3  +1        D2
    nop
    ADC_T_0
    ADC_CLK_0
    DELAY_CLK
    nop nop
    ADC_CLK_1
    DELAY_CLK
  ;4  +1        D1
    nop
    ADC_T_0
    ADC_CLK_0
    DELAY_CLK
    nop nop
    ADC_CLK_1
    DELAY_CLK
  ;5  +1        D0
    nop
    ADC_T_1
    ADC_CLK_0
    DELAY_CLK
    nop nop
    ADC_CLK_1
    DELAY_CLK
  ;6  +1        HI-Z pause
    nop
    ADC_T_0
    ADC_CLK_0
    DELAY_CLK
    nop nop
    ADC_CLK_1
    DELAY_CLK
  ;7  +1        null bit
    clr    ADC_HIGH_r
    clr    ADC_LOW_r
    ADC_CLK_0
    DELAY_CLK
    ADC_R_skip_if_0
    sbr    ADC_HIGH_r, 0x10
    ADC_CLK_1
    DELAY_CLK
  ;8  +2        Most Significant Bit 11
    nop nop
    ADC_CLK_0
    DELAY_CLK
    ADC_R_skip_if_0
    sbr    ADC_HIGH_r, 0x08
    ADC_CLK_1
    DELAY_CLK
  ;9  +2        10 bit
    nop nop
    ADC_CLK_0
    DELAY_CLK
    ADC_R_skip_if_0
    sbr    ADC_HIGH_r, 0x04
    ADC_CLK_1
    DELAY_CLK
  ;10  +2        9 bit
    nop nop
    ADC_CLK_0
    DELAY_CLK
    ADC_R_skip_if_0
    sbr    ADC_HIGH_r, 0x02
    ADC_CLK_1
    DELAY_CLK
  ;11  +2        8 bit
    nop nop
    ADC_CLK_0
    DELAY_CLK
    ADC_R_skip_if_0
    sbr    ADC_HIGH_r, 0x01
    ADC_CLK_1
    DELAY_CLK
  ;12  +2        7 bit
    nop nop
    ADC_CLK_0
    DELAY_CLK
    ADC_R_skip_if_0
    sbr    ADC_LOW_r, 0x80
    ADC_CLK_1
    DELAY_CLK
  ;13  +2        6 bit
    nop nop
    ADC_CLK_0
    DELAY_CLK
    ADC_R_skip_if_0
    sbr    ADC_LOW_r, 0x40
    ADC_CLK_1
    DELAY_CLK
  ;14  +2        5 bit
    nop nop
    ADC_CLK_0
    DELAY_CLK
    ADC_R_skip_if_0
    sbr    ADC_LOW_r, 0x20
    ADC_CLK_1
    DELAY_CLK
  ;15  +2        4 bit
    nop nop
    ADC_CLK_0
    DELAY_CLK
    ADC_R_skip_if_0
    sbr    ADC_LOW_r, 0x10
    ADC_CLK_1
    DELAY_CLK
  ;16  +2        3 bit
    nop nop
    ADC_CLK_0
    DELAY_CLK
    ADC_R_skip_if_0
    sbr    ADC_LOW_r, 0x08
    ADC_CLK_1
    DELAY_CLK
  ;17  +2        2 bit
    nop nop
    ADC_CLK_0
    DELAY_CLK
    ADC_R_skip_if_0
    sbr    ADC_LOW_r, 0x04
    ADC_CLK_1
    DELAY_CLK
  ;18  +2        1 bit
    nop nop
    ADC_CLK_0
    DELAY_CLK
    ADC_R_skip_if_0
    sbr    ADC_LOW_r, 0x02
    ADC_CLK_1
    DELAY_CLK
  ;19  +2        0 bit
    nop nop
    ADC_CLK_0
    DELAY_CLK
    ADC_R_skip_if_0
    sbr    ADC_LOW_r, 0x01
    ADC_CLK_1
    DELAY_CLK
  ;20  +1
    nop
    ADC_CS_1
    ADC_CLK_0
    DELAY_CLK
    nop nop
    ADC_CLK_1
    DELAY_CLK
  ;----------
    ;nop nop
    ;ADC_CLK_0
    ret
