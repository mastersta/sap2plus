#include "../sap2plus_ruledef.asm"

intvec = 0xff00
resetvec = 0x8100

#d16 $le(intvec), $le(resetvec)

#addr resetvec

STArt:
  LDA #1 ;0000 0001 in A reg
  NOP    ;do nothing except load next instruction
  LDX #2 ;0000 0010 in X reg

stores:
  STA 0x0200      ;stores 0000 0001 in addr 0200
  STX 0x0201      ;stores 0000 0010 in addr 0201
  STA 0x00        ;stores 0000 0001 in zp 00
  STX 0x01        ;stores 0000 0010 in zp 01
  STA 0x0200,x    ;stores 0000 0001 in addr 0202
  STA 0x00,x      ;stores 0000 0001 in zp 02

loads:
  LDA #0          ;0000 0000 in A reg
  LDA 0x0200      ;0000 0001 in A reg
  LDA 0x0201      ;0000 0010 in A reg
  LDA 0x00        ;0000 0001 in A reg
  LDA 0x01        ;0000 0010 in A reg
  LDA 0x0200,x    ;0000 0001 in A reg (comes from addr 0202)
  LDA #0          ;0000 0000 in A reg
  LDA 0x00,x      ;0000 0001 in A reg (comes from addr 0002)
  LDX 0x0200      ;0000 0001 in X reg
  LDX 0x02        ;0000 0010 in X reg

register_xfrs:
  TAX             ;0000 0001 in X reg
  LDX #2          ;0000 0010 in X reg
  TXA             ;0000 0010 in A reg
  TAG             ;0000 0010 in GPIO output
  TAD             ;0000 0010 in DDR

math:
  sec             ;carry flag set
  adc #1          ;0000 0011 in A reg, carry flag should clear
  sec             ;carry flag set again
  clc             ;carry flag clear
  adc 0x0200      ;adds 1 from 0200, 0000 0100 in A reg after
  adc 0x00        ;adds 1 from 0000, 0000 0101 in A reg after
  ldx #1
  adc 0x00,x      ;adds 2 from 0001, 0000 0111 in A reg after
  sec
  sbc #1          ;0000 0110 in A reg after
  clc
  sbc #1          ;0000 0011 in A reg after
  sec
  sbc 0x0200      ;0000 0010 in A reg after
  sec
  sbc 0x00        ;subs 1 from 0000, 0000 0001 in A reg after
  
