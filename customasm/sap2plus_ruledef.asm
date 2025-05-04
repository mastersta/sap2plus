#ruledef {
  INI => 0x00

  ;==================================================================================================
  ;                                            LDA
  ;==================================================================================================

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

  ;==================================================================================================
  ;                                            LDX
  ;==================================================================================================

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

  ;==================================================================================================
  ;                                            STA
  ;==================================================================================================

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


  ;==================================================================================================
  ;                                            STX
  ;==================================================================================================

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


