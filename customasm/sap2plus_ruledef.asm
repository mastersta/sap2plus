
#ruledef {
  INI => 0x00


  ;==================================================================================================
  ;                                          LOAD/STORE
  ;==================================================================================================

;====================LDA====================

  LDA #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x03 @ value`8
  }

  LDA {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x05 @ address`16
  }

  LDA {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x08 @ address`8
  }

  LDA {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x0a @ address`16
  }

  LDA {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x0c @ address`8
  }

  LDA ({address: u8},X) => {     ;pre-indexed indirect addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x0e @ address`8
  }

  LDA ({address: u8}),X => {     ;post-indexed indirect addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x0f @ address`8
  }


;====================LDX====================

  LDX #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x13 @ value`8
  }

  LDX {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x15 @ address`16
  }

  LDX {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x18 @ address`8
  }


;====================STA====================

  STA {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x25 @ address`16
  }

  STA {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x28 @ address`8
  }

  STA {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x1a @ address`16
  }

  STA {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x1c @ address`8
  }

  STA ({address: u8},X) => {     ;pre-indexed indirect addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x1e @ address`8
  }

  STA ({address: u8}),X => {     ;post-indexed indirect addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x1f @ address`8
  }


;====================STX====================

  STX {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x35 @ address`16
  }

  STX {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x38 @ address`8
  }


  ;==================================================================================================
  ;                                     REGISTER TRANSFERS
  ;==================================================================================================

  TAX => 0x01
  TXA => 0x11


  ;==================================================================================================
  ;                                      STACK OPERATIONS
  ;==================================================================================================

  TSX => 0x21
  TXS => 0x31
  PSA => 0x41
  PHP => 0x51
  PLA => 0x61
  PLP => 0x71


  ;==================================================================================================
  ;                                       LOGICAL OPERATIONS
  ;==================================================================================================


;====================AND====================

  AND #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x23 @ value`8
  }

  AND {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x04 @ address`16
  }

  AND {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x48 @ address`8
  }

  AND {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x2a @ address`16
  }

  AND {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x2c @ address`8
  }

  AND ({address: u8},X) => {     ;pre-indexed indirect addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x2e @ address`8
  }

  AND ({address: u8}),X => {     ;post-indexed indirect addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x2f @ address`8
  }


;====================EOR====================

  EOR #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x33 @ value`8
  }

  EOR {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x14 @ address`16
  }

  EOR {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x58 @ address`8
  }

  EOR {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x3a @ address`16
  }

  EOR {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x3c @ address`8
  }

  EOR ({address: u8},X) => {     ;pre-indexed indirect addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x3e @ address`8
  }

  EOR ({address: u8}),X => {     ;post-indexed indirect addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x3f @ address`8
  }


;====================ORA====================

  ORA #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x43 @ value`8
  }

  ORA {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x24 @ address`16
  }

  ORA {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x68 @ address`8
  }

  ORA {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x4a @ address`16
  }

  ORA {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x4c @ address`8
  }

  ORA ({address: u8},X) => {     ;pre-indexed indirect addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x4e @ address`8
  }

  ORA ({address: u8}),X => {     ;post-indexed indirect addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x4f @ address`8
  }


;====================INV====================

  INV => 0x60

  ;==================================================================================================
  ;                                    ARITHMETIC OPERATIONS
  ;==================================================================================================

;====================ADC====================

  ADC #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x53 @ value`8
  }

  ADC {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x45 @ address`16
  }

  ADC {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x09 @ address`8
  }

  ADC {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x5a @ address`16
  }

  ADC {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x5c @ address`8
  }

  ADC ({address: u8},X) => {     ;pre-indexed indirect addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x5e @ address`8
  }

  ADC ({address: u8}),X => {     ;post-indexed indirect addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x5f @ address`8
  }


;====================SBC====================

  SBC #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x63 @ value`8
  }

  SBC {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x55 @ address`16
  }

  SBC {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x19 @ address`8
  }

  SBC {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x6a @ address`16
  }

  SBC {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x6c @ address`8
  }

  SBC ({address: u8},X) => {     ;pre-indexed indirect addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x6e @ address`8
  }

  SBC ({address: u8}),X => {     ;post-indexed indirect addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x6f @ address`8
  }


;====================CMP====================

  CMP #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x73 @ value`8
  }

  CMP {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x65 @ address`16
  }

  CMP {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x69 @ address`8
  }

  CMP {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x7a @ address`16
  }

  CMP {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x7c @ address`8
  }

  CMP ({address: u8},X) => {     ;pre-indexed indirect addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x7e @ address`8
  }

  CMP ({address: u8}),X => {     ;post-indexed indirect addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x7f @ address`8
  }


;====================CPX====================

  CPX #{value: u8} => {        ;immediate addressing mode
    assert(value >= 0x00)
    assert(value <= 0xff)
    0x74 @ value`8
  }

  CPX {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x75 @ address`16
  }

  CPX {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x79 @ address`8
  }

  
  ;==================================================================================================
  ;                                      INCREMENT/DECREMENT
  ;==================================================================================================

;====================INC====================

  INC {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x06 @ address`16
  }

  INC {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x49 @ address`8
  }

  INC {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x0b @ address`16
  }

  INC {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x0d @ address`8
  }

  INX => 0x02


;====================DEC====================

  DEC {address: u16} => {      ;absolute addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x16 @ address`16
  }

  DEC {address: u8} => {      ;zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x59 @ address`8
  }

  DEC {address: u16},X => {     ;indexed addressing mode
    assert(address >= 0x0000)
    assert(address <= 0xffff)
    0x1b @ address`16
  }

  DEC {address: u8},X => {      ;indexed zero page addressing mode
    assert(address >= 0x00)
    assert(address <= 0xff)
    0x1d @ address`8
  }

  DEX => 0x12
  


}

load_a:
  LDA #$aa
  LDA $aaaa
  LDA $aa
  LDA $aaaa,X
  LDA $aa,X
  LDA ($aa,X)
  LDA ($aa),X

load_x:
  LDX #$aa
  LDX $aaaa
  LDX $aa

store_a:
  STA $aaaa
  STA $aa
  STA $aaaa,X
  STA $aa,X
  STA ($aa,X)
  STA ($aa),X

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
  PSA
  PHP
  PLA
  PLP

logical_and:
  AND #$aa
  AND $aaaa
  AND $aa
  AND $aaaa,X
  AND ($aa,X)
  AND ($aa),X

logical_eor:
  EOR #$aa
  EOR $aaaa
  EOR $aa
  EOR $aaaa,X
  EOR ($aa,X)
  EOR ($aa),X

logical_or:
  ORA #$aa
  ORA $aaaa
  ORA $aa
  ORA $aaaa,X
  ORA ($aa,X)
  ORA ($aa),X

logical_invert:
  INV

arithmetic_add:
  ADC #$aa
  ADC $aaaa
  ADC $aa
  ADC $aaaa,X
  ADC ($aa,X)
  ADC ($aa),X

arithmetic_subtract:
  SBC #$aa
  SBC $aaaa
  SBC $aa
  SBC $aaaa,X
  SBC ($aa,X)
  SBC ($aa),X

arithmetic_compare:
  CMP #$aa
  CMP $aaaa
  CMP $aa
  CMP $aaaa,X
  CMP ($aa,X)
  CMP ($aa),X

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


