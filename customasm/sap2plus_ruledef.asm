
#bankdef RAM {
  #bits 8
  #addr 0x0000
  #size 0x8000
}

#bankdef ROM {
  #bits 8
  #addr 0x8000
  #size 0x2000
  #outp 0
  #fill
}

#bank ROM


#ruledef {

;=====0x00-0x0F=====

; INI => 0x00
  NOP => 0x01
  CLC => 0x02
  CLF => 0x03
  CLI => 0x04
  SEI => 0x05
  RTS => 0x06
; JTI => 0x07
  RTI => 0x08
; empty
  PHA => 0x0A
  PLA => 0x0B
  TXS => 0x0C
  TSX => 0x0D
  PHP => 0x0E
  PLP => 0x0F

;=====0x10-0x1F=====

  TAG => 0x10
  TAX => 0x11
  TGA => 0x12
  TXA => 0x13
  TAD => 0x14
  TCL => 0x15
  TCH => 0x16
  INV => 0x17
; empty
; empty
  PHX => 0x1A
  PLX => 0x1B
  INX => 0x1C
  DEX => 0x1D
  ROL => 0x1E
  ROR => 0x1F

;=====0x20-0x2F=====

  LDA #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x20 @ value`8
  }
  LDX #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x21 @ value`8
  }
; empty
; empty
  AND #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x24 @ value`8
  }
  ORA #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x25 @ value`8
  }
  EOR #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x26 @ value`8
  }
; empty
  ADC #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x28 @ value`8
  }
  SBC #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x29 @ value`8
  }
  CMP #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x2A @ value`8
  }
  CPX #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x2B @ value`8
  }
; empty
; empty
; empty
; empty

;=====0x30-0x3F=====

  LDA {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x30 @ le(address`16)
  }
  LDX {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x31 @ le(address`16)
  }
  STA {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x32 @ le(address`16)
  }
  STX {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x33 @ le(address`16)
  }
  AND {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x34 @ le(address`16)
  }
  ORA {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x35 @ le(address`16)
  }
  EOR {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x36 @ le(address`16)
  }
  INV {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x37 @ le(address`16)
  }
  ADC {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x38 @ le(address`16)
  }
  SBC {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x39 @ le(address`16)
  }
  CMP {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x3A @ le(address`16)
  }
  CPX {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x3B @ le(address`16)
  }
  INC {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x3C @ le(address`16)
  }
  DEC {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x3D @ le(address`16)
  }
  ROL {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x3E @ le(address`16)
  }
  ROR {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x3F @ le(address`16)
  }

;=====0x40-0x4F=====

  JMP {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x40 @ le(address`16)
  }
  JSR {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x41 @ le(address`16)
  }
  BCS {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x42 @ le(address`16)
  }
  BCC {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x43 @ le(address`16)
  }
  BEQ {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x44 @ le(address`16)
  }
  BNE {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x45 @ le(address`16)
  }
  BMI {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x46 @ le(address`16)
  }
  BPL {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x47 @ le(address`16)
  }
  BVS {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x48 @ le(address`16)
  }
  BVC {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x49 @ le(address`16)
  }
; empty
; empty
; empty
; empty
; empty
; empty

;=====0x50-0x5F=====

  LDA {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x50 @ address`8
  }
  LDX {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x51 @ address`8
  }
  STA {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x52 @ address`8
  }
  STX {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x53 @ address`8
  }
  AND {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x54 @ address`8
  }
  ORA {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x55 @ address`8
  }
  EOR {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x56 @ address`8
  }
  INV {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x57 @ address`8
  }
  ADC {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x58 @ address`8
  }
  SBC {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x59 @ address`8
  }
  CMP {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x5A @ address`8
  }
  CPX {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x5B @ address`8
  }
  INC {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x5C @ address`8
  }
  DEC {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x5D @ address`8
  }
  ROL {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x5E @ address`8
  }
  ROR {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x5F @ address`8
  }

;=====0x60-0x6F=====

  LDA {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x60 @ le(address`16)
  }
; empty
  STA {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x62 @ le(address`16)
  }
; empty
  AND {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x64 @ le(address`16)
  }
  ORA {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x65 @ le(address`16)
  }
  EOR {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x66 @ le(address`16)
  }
  INV {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x67 @ le(address`16)
  }
  ADC {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x68 @ le(address`16)
  }
  SBC {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x69 @ le(address`16)
  }
  CMP {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x6A @ le(address`16)
  }
; empty
  INC {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x6C @ le(address`16)
  }
  DEC {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x6D @ le(address`16)
  }
  ROL {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x6E @ le(address`16)
  }
  ROR {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x6F @ le(address`16)
  }

;=====0x70-0x7F=====

  LDA {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x70 @ address`8
  }
; empty
  STA {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x72 @ address`8
  }
; empty
  AND {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x74 @ address`8
  }
  ORA {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x75 @ address`8
  }
  EOR {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x76 @ address`8
  }
  INV {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x77 @ address`8
  }
  ADC {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x78 @ address`8
  }
  SBC {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x79 @ address`8
  }
  CMP {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x7A @ address`8
  }
; empty
  INC {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x7C @ address`8
  }
  DEC {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x7D @ address`8
  }
  ROL {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x7E @ address`8
  }
  ROR {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x7F @ address`8
  }

}

;=====Example Code=====
;INTVEC = 0xFFFF
;RESETVEC = 0xFFFF
;
;#addr RESETVEC
;
;
;main:
;  JMP main
;
;#addr INTVEC
;interrupt:
;  RTI
