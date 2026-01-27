INTVEC = 0x9F00
RESETVEC = 0x80FF

#addr RESETVEC ;testing reset vector placement


load_a:
  LDA #$aa
  LDA $aaff
  LDA $aa
  LDA $aaff,X
  LDA $aa,X

load_x:
  LDX #$aa
  LDX $aaaa
  LDX $aa

store_a:
  STA $aaaa
  STA $aa
  STA $aaaa,X
  STA $aa,X

; test comment

store_x:
  STX $aaaa
  STX $aa

register_xfers:
  TAX
  TXA

stack_ops:
  TSX
  TXS
  PHA
  PHP
  PLA
  PLP

logical_and:
  AND #$aa
  AND $aaaa
  AND $aa
  AND $aaaa,X

logical_or:
  ORA #$aa
  ORA $aaaa
  ORA $aa
  ORA $aaaa,X

logical_eor:
  EOR #$aa
  EOR $aaaa
  EOR $aa
  EOR $aaaa,X

logical_invert:
  INV

arithmetic_add:
  ADC #$aa
  ADC $aaaa
  ADC $aa
  ADC $aaaa,X

arithmetic_subtract:
  SBC #$aa
  SBC $aaaa
  SBC $aa
  SBC $aaaa,X

arithmetic_compare:
  CMP #$aa
  CMP $aaaa
  CMP $aa
  CMP $aaaa,X

arithmetic_compare_x:
  CPX #$aa
  CPX $aaaa
  CPX $aa

increment:
  INC $aaaa
  INC $aa
  INC $aaaa,X
  INC $aa,X

  INX

decrement:
  DEC $aaaa
  DEC $aa
  DEC $aaaa,X
  DEC $aa,X

  DEX

rolls:
  ROL
  ROL $aaaa
  ROL $aa
  ROL $aaaa,X
  ROL $aa,X

  ROR
  ROR $aaaa
  ROR $aa
  ROR $aaaa,X
  ROR $aa,X

returns:
  RTI
  RTS

jumps:
  JMP load_a
  JSR jumps
  BCS jumps
  BCC jumps
  BEZ jumps
  BNZ jumps
  BEQ jumps
  BNE jumps
  BMI jumps
  BPL jumps

flagops:
  CLC
  CLF

interrupts:
  CLI
  SEI

misc:
  NOP

#addr INTVEC
int:        ;testing interrupt placement
  LDA #05
  RTI