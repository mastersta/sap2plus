
#bankdef RAM {
  #addr 0x0000
  #size 0x8000
}

#bankdef ROM {
  #addr 0x8000
  #size 0x0200
  #outp 8 * 0x2
}

#ruledef {

  ;==================================================================================================
  ;                                          LOAD/STORE
  ;==================================================================================================

;====================LDA====================

  LDA #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x20 @ value`8
  }

  LDA {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x30 @ address`16
  }

  LDA {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x50 @ address`8
  }

  LDA {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x60 @ address`16
  }

  LDA {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x70 @ address`8
  }


;====================LDX====================

  LDX #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x21 @ value`8
  }

  LDX {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x31 @ address`16
  }

  LDX {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x51 @ address`8
  }


;====================STA====================

  STA {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x32 @ address`16
  }

  STA {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x52 @ address`8
  }

  STA {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x62 @ address`16
  }

  STA {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x72 @ address`8
  }


;====================STX====================

  STX {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x33 @ address`16
  }

  STX {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x53 @ address`8
  }


  ;==================================================================================================
  ;                                     REGISTER TRANSFERS
  ;==================================================================================================

  TAX => 0x11
  TXA => 0x13


  ;==================================================================================================
  ;                                      STACK OPERATIONS
  ;==================================================================================================

  TXS => 0x0C
  TSX => 0x0D
  PHA => 0x0A
  PHP => 0x0E
  PLA => 0x0B
  PLP => 0x0F


  ;==================================================================================================
  ;                                       LOGICAL OPERATIONS
  ;==================================================================================================


;====================AND====================

  AND #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x24 @ value`8
  }

  AND {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x34 @ address`16
  }

  AND {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x54 @ address`8
  }

  AND {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x64 @ address`16
  }

  AND {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x74 @ address`8
  }




;====================ORA====================

  ORA #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x25 @ value`8
  }

  ORA {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x35 @ address`16
  }

  ORA {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x55 @ address`8
  }

  ORA {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x65 @ address`16
  }

  ORA {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x75 @ address`8
  }



;====================EOR====================

  EOR #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x26 @ value`8
  }

  EOR {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x36 @ address`16
  }

  EOR {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x56 @ address`8
  }

  EOR {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x66 @ address`16
  }

  EOR {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x76 @ address`8
  }




;====================INV====================

  INV => 0x16




  ;==================================================================================================
  ;                                    ARITHMETIC OPERATIONS
  ;==================================================================================================

;====================ADC====================

  ADC #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x28 @ value`8
  }

  ADC {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x38 @ address`16
  }

  ADC {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x58 @ address`8
  }

  ADC {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x68 @ address`16
  }

  ADC {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x78 @ address`8
  }




;====================SBC====================

  SBC #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x29 @ value`8
  }

  SBC {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x39 @ address`16
  }

  SBC {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x59 @ address`8
  }

  SBC {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x69 @ address`16
  }

  SBC {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x79 @ address`8
  }




;====================CMP====================

  CMP #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x2A @ value`8
  }

  CMP {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x3A @ address`16
  }

  CMP {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x5A @ address`8
  }

  CMP {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x6A @ address`16
  }

  CMP {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x7A @ address`8
  }




;====================CPX====================

  CPX #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x2B @ value`8
  }

  CPX {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x3B @ address`16
  }

  CPX {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x5B @ address`8
  }

  
  ;==================================================================================================
  ;                                      INCREMENT/DECREMENT
  ;==================================================================================================

;====================INC====================

  INC {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x3C @ address`16
  }

  INC {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x5C @ address`8
  }

  INC {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x6C @ address`16
  }

  INC {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x7C @ address`8
  }

  INX => 0x1C


;====================DEC====================

  DEC {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x3D @ address`16
  }

  DEC {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x5D @ address`8
  }

  DEC {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x6D @ address`16
  }

  DEC {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x7D @ address`8
  }

  DEX => 0x1D
  



  ;==================================================================================================
  ;                                      ROLL LEFT/ROLL RIGHT
  ;==================================================================================================

;====================ROL====================

  ROL => 0x1E

  ROL {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x3E @ address`16
  }

  ROL {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x5E @ address`8
  }

  ROL {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x6E @ address`16
  }

  ROL {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x7E @ address`8
  }




;====================ROR====================

  ROR => 0x1F

  ROR {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x3F @ address`16
  }

  ROR {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x5F @ address`8
  }

  ROR {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x6F @ address`16
  }

  ROR {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x7F @ address`8
  }




  ;==================================================================================================
  ;                                        JUMPS/BRANCHES
  ;==================================================================================================

  JMP {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x40 @ address`16
  }

  JSR {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x41 @ address`16
  }

  BCS {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x42 @ address`16
  }

  BCC {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x43 @ address`16
  }

  BEZ {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x44 @ address`16
  }

  BNZ {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x45 @ address`16
  }

  BEQ {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x46 @ address`16
  }

  BNE {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x47 @ address`16
  }

  BMI {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x48 @ address`16
  }

  BPL {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x49 @ address`16
  }




;==================RETURNS==================

  RTS => 0x06

  RTI => 0x08




  ;==================================================================================================
  ;                                       FLAG OPERATIONS
  ;==================================================================================================

  CLC => 0x02

  CLF => 0x03




  ;==================================================================================================
  ;                                        INTERRUPT OPS  
  ;==================================================================================================

  CLI => 0x04

  SEI => 0x05




  ;==================================================================================================
  ;                                        MISCELLANEOUS 
  ;==================================================================================================

  NOP => 0x01

}


load_a:
  LDA #$aa
  LDA $aaaa
  LDA $aa
  LDA $aaaa,X
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
  JMP jumps
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

