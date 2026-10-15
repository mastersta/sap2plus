[rom] {
  2048x8x3
}

[address] {
  cycle:  4
  opcode: 7
}

[signals] {
  LM
  LC
  L0
  L1
  L2
  L3
  JU
  FI

  F1
  F2
  FV
  CE
  TD
  TC
  PD
  PI

  D0B0
  D0B1
  D0B2
  D0B3
  D1B0
  D1B1
  D1B2
  D1B3
}

[macros] {
#decoders
  XO =                    D0B0
  LO =              D0B1
  EO =              D0B1, D0BO
  AR =        D0B2
  RO =        D0B2,       D0B0
  COL =       D0B2, D0B1
  COH =       D0B2, D0B1, D0B0
  FO =  D0B3
  PO =  D0B3,             D0B0
  GO =  D0B3,       D0B1
  HO =  D0B3,       D0B1, D0B0
  OO =  D0B3, D0B2

  AI =                    D1B0
  BI =              D1B1
  XI =              D1B1, D1B0
  MI =        D1B2
  RI =        D1B2,       D1B0
  CI =        D1B2, D1B1
  II =        D1B2, D1B1, D1B0
  FL =  D1B3
  GI =  D1B3,             D1B0
  DI =  D1B3,       D1B1

#ALU operations
  LNOT =                      LM
  LNOR =              L0,     LM
  LZRO =          L1, L0,     LM
  LNND =      L2,             LM
  LXOR =      L2, L1,         LM
  LADD =  L3,         L0
  LXNR =  L3,         L0,     LM
  BO   =  L3,     L1,         LM
  LAND =  L3,     L1, L0,     LM
  LSUB =  L3, L2
  LNEG =  L3, L2,             LM
  LSHL =  L3, L2,     LC
  LORA =  L3, L2, L1,         LM
  AO   =  L3, L2, L1, L0,     LM
  LDEC =  L3, L2, L1, L0, LC
}

[opcodes] {
  INI = 0x00
  NOP = 0x01
  CLC = 0x02
  CLF = 0x03
  CLI = 0x04
  SEI = 0x05
  RTS = 0x06
  JTI = 0x07
  RTI = 0x08
# empty
  PHA = 0x0A
  PLA = 0x0B
  TXS = 0x0C
  TSX = 0x0D
  PHP = 0x0E
  PLP = 0x0F


  TAG = 0x10
  TAX = 0x11
  TGA = 0x12
  TXA = 0x13
  TAD = 0x14
  TCL = 0x15
  TCH = 0x16
  INV = 0x17
# empty
# empty
  PHX = 0x1A
  PLX = 0x1B
  INX = 0x1C
  DEX = 0x1D
  ROL = 0x1E
  ROR = 0x1F
  

  LDAi = 0x20
  LDXi = 0x21
#empty
#empty
  ANDi = 0x24
  ORAi = 0x25
  EORi = 0x26
#empty
  ADCi = 0x28
  SBCi = 0x29
  CMPi = 0x2A
  CPXi = 0x2B
#empty
#empty
#empty
#empty


  LDAabs = 0x30
  LDXabs = 0x31
  STAabs = 0x32
  STXabs = 0x33
  ANDabs = 0x34
  ORAabs = 0x35
  EORabs = 0x36
  INVabs = 0x37
  ADCabs = 0x38
  SBCabs = 0x39
  CMPabs = 0x3A
  CPXabs = 0x3B
  INCabs = 0x3C
  DECabs = 0x3D
  ROLabs = 0x3E
  RORabs = 0x3F


  JMPabs = 0x40
  JSRabs = 0x41
  BCSabs = 0x42
  BCCabs = 0x43
  BEQabs = 0x44
  BNEabs = 0x45
  BMIabs = 0x46
  BPLabs = 0x47
  BVSabs = 0x48
  BVCabs = 0x49
#empty
#empty
#empty
#empty
#empty
#empty


  LDAzp = 0x50
  LDXzp = 0x51
  STAzp = 0x52
  STXzp = 0x53
  ANDzp = 0x54
  ORAzp = 0x55
  EORzp = 0x56
  INVzp = 0x57
  ADCzp = 0x58
  SBCzp = 0x59
  CMPzp = 0x5A
  CPXzp = 0x5B
  INCzp = 0x5C
  DECzp = 0x5D
  ROLzp = 0x5E
  RORzp = 0x5F


  LDAabsx = 0x60
#empty
  STAabsx = 0x62
#empty
  ANDabsx = 0x64
  ORAabsx = 0x65
  EORabsx = 0x66
  INVabsx = 0x67
  ADCabsx = 0x68
  SBCabsx = 0x69
  CMPabsx = 0x6A
#empty
  INCabsx = 0x6C
  DECabsx = 0x6D
  ROLabsx = 0x6E
  RORabsx = 0x6F


  LDAzpx = 0x70
#empty
  STAzpx = 0x72
#empty
  ANDzpx = 0x74
  ORAzpx = 0x75
  EORzpx = 0x76
  INVzpx = 0x77
  ADCzpx = 0x78
  SBCzpx = 0x79
  CMPzpx = 0x7A
#empty
  INCzpx = 0x7C
  DECzpx = 0x7D
  ROLzpx = 0x7E
  RORzpx = 0x7F
}
