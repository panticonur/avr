;*** eload function copy eeprom to memory
;I memory target adress set to X
;I eeprom source adress set to Y
;I size set to Z
;U r26-r31 TEMP
eload:
    add ZL, XL
	adc ZH, XH
    eload_loop:
      cp   ZL, XL
	  brne PC+3
	  cpc  ZH, XH
	  breq eload_ret
	  OUT  EEARL, YL
      .IFDEF EEARH
	  OUT  EEARH, YH
      .ENDIF
	  SBI  EECR, EERE
	  IN   TEMP, EEDR
	  ST   X+, TEMP
	  SUBI	YL,(-1) ; add  YL, ONE
	  SBCI	YH,(-1) ; adc  YH, ZERO
	  rjmp eload_loop
    eload_ret:
	ret

;*** eload1 function copy byte from eeprom to memory
;I memory target adress set to X
;I eeprom source adress set to Y
;U r26-r29 TEMP
eload1:
    OUT  EEARL, YL
    .IFDEF EEARH
    OUT  EEARH, YH
    .ENDIF
    SBI  EECR, EERE ; read enable
    IN   TEMP, EEDR
    ST   X+, TEMP
    ret

;*** estore function copy memory to eeprom
;I eeprom target adress set to X
;I memory source adress set to Y
;I size set to Z
;U r26-r31 TEMP
estore:
    add  ZL, XL
	adc  ZH, XH
    estore_loop:
      cp   ZL, XL
	  brne PC+3
	  cpc  ZH, XH
	  breq estore_ret
	  estore_wait:
        SBIC EECR, EEPE
        RJMP estore_wait
	  OUT  EEARL, XL
      .IFDEF EEARH
	  OUT  EEARH, XH
      .ENDIF
    ld   TEMP, Y+
	  OUT  EEDR, TEMP
      SBI  EECR, EEMPE
      SBI  EECR, EEPE
	  SUBI	YL,(-1) ; add  YL, ONE
	  SBCI	YH,(-1) ; adc  YH, ZERO
	  estore_wait2:
        SBIC EECR, EEPE
        RJMP estore_wait2
	  rjmp estore_loop
    estore_ret:
	ret

;*** estore1 function copy byte from memory to eeprom
;I eeprom target adress set to X
;I memory source adress set to Y
;U r26-r29 TEMP
estore1:
    estore1_wait:
        SBIC EECR, EEPE
        RJMP estore1_wait
    OUT  EEARL, XL
    .IFDEF EEARH
    OUT  EEARH, XH
    .ENDIF
    ld   TEMP, Y+
    OUT  EEDR, TEMP
    SBI  EECR, EEMPE
    SBI  EECR, EEPE
    estore1_wait2:
        SBIC EECR, EEPE
            RJMP estore1_wait2
    ret
