
;First operand in ZP 00(LB) and 01(HB)
;Second operand in ZP 02(LB) and 03(HB)
;Result stored in ZP 04(LB) and 05(HB)
;Modifies A, Flags
WORD_ADD:
    PHA
    CLC
    LDA 0x00
    ADC 0x02
    STA 0x04
    LDA 0x01
    ADC 0x03
    STA 0x05
    PLA

;First operand 00(LB) 01(HB)
;Second operand 02(LB) 03(HB)
;Result stored in 04(LB) 05(HB)
;Modifies A, Flags
WORD_SUB:  ;First - Second
    PHA
    SEC
    LDA 0x00
    SBC 0x02
    STA 0x04
    LDA 0x01
    SBC 0x03
    STA 0x05

