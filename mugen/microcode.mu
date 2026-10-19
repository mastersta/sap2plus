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
  EO =              D0B1, D0B0
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
  LNOT =                      LM,   LO
  LNOR =              L0,     LM,   LO
  LZRO =          L1, L0,     LM,   LO
  LNND =      L2,             LM,   LO
  LNTB =      L2,     L0,     LM,   LO  #TODO: Incorporate into invert memory value instructions
  LXOR =      L2, L1,         LM,   LO
  LADD =  L3,         L0,           LO
  LXNR =  L3,         L0,     LM,   LO
  BO   =  L3,     L1,         LM,   LO
  LAND =  L3,     L1, L0,     LM,   LO
  LSUB =  L3, L2,                   LO
  LNEG =  L3, L2,             LM,   LO
  LSHL =  L3, L2,     LC,           LO
  LORA =  L3, L2, L1,         LM,   LO
  AO   =  L3, L2, L1, L0,     LM,   LO
  LDEC =  L3, L2, L1, L0, LC,       LO

#TODO: Temp Fix to get it to compile
  ES = EO
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

[microcode] {

#0x00
INI:0  		-> TD, CI, JU
INI:1  		-> LZRO, CI, JU
INI:2  		-> RO, CE
INI:3  		-> RO, CE
INI:4  		-> COH, MI
INI:5  		-> COL, MI, CE
INI:6  		-> RO, BI
INI:7  		-> COH, MI
INI:8  		-> COL, MI
INI:9  		-> RO, CI, JU
INI:10 		-> BO, CI, JU, TC
INI:11 		-> COH, MI
INI:12 		-> COL, MI
INI:13 		-> RO, II, CE

#0x01
NOP:0  		-> COH, MI
NOP:1  		-> COL, MI
NOP:2  		-> RO, II, CE

#0x02
CLC:0  		-> MI
CLC:1  		-> PO, MI, PD
CLC:2  		-> AO, RI
CLC:3  		-> FO, AI
CLC:4  		-> LZRO, BI
CLC:5  		-> LAND, FL
CLC:6  		-> MI, PI
CLC:7  		-> PO, MI
CLC:8  		-> RO, AI
CLC:9  		-> COH, MI
CLC:10 		-> COL, MI
CLC:11 		-> RO, II, CE

#0x03
CLF:0  		-> LZRO, FI
CLF:1  		-> COH, MI
CLF:2  		-> COL, MI
CLF:3  		-> RO, II, CE

#0x04
CLI:0  		-> TC
CLI:1  		-> COH, MI
CLI:2  		-> COL, MI
CLI:3  		-> RO, II, CE

#0x05
SEI:0  		-> TD
SEI:1  		-> COH, MI
SEI:2  		-> COL, MI
SEI:3  		-> RO, II, CE

#0x06
RTS:0  		-> MI, PI
RTS:1  		-> PO, MI
RTS:2  		-> RO, CI, JU
RTS:3  		-> MI, CE, PI
RTS:4  		-> PO, MI
RTS:5  		-> RO, CI, JU
RTS:6  		-> RO, CE
RTS:7  		-> RO, CE
RTS:8  		-> COH, MI
RTS:9  		-> COL, MI
RTS:10 		-> RO, II, CE

#0x07
JTI:0  		-> HO, MI, TD
JTI:1  		-> PO, MI, PD
JTI:2  		-> COL, RI
JTI:3  		-> HO, MI
JTI:4  		-> PO, MI, PD
JTI:5  		-> COH, RI
JTI:6  		-> HO, MI
JTI:7  		-> LZRO, MI
JTI:8  		-> RO, BI
JTI:9  		-> HO, MI
JTI:10 		-> OO, MI
JTI:11 		-> RO, CI, JU
JTI:12 		-> BO, CI, JU
JTI:13 		-> COH, MI
JTI:14 		-> COL, MI
JTI:15 		-> RO, II, CE

#0x08
RTI:0  		-> PI, MI
RTI:1  		-> PO, MI
RTI:2  		-> RO, CI
RTI:3  		-> PI, MI
RTI:4  		-> PO, MI
RTI:5  		-> RO, CI, JU, TC
RTI:6  		-> COH, MI
RTI:7  		-> COL, MI
RTI:8  		-> RO, II, CE

#0x09
#empty

#0x0A
PHA:0  		-> MI
PHA:1  		-> PO, MI, PD
PHA:2  		-> AO, RI
PHA:3  		-> COH, MI
PHA:4  		-> COL, MI
PHA:5  		-> RO, II, CE

#0x0B
PLA:0  		-> MI, PI
PLA:1  		-> PO, MI
PLA:2  		-> RO, AI
PLA:3  		-> COH, MI
PLA:4  		-> COL, MI
PLA:5  		-> RO, II, CE

#0x0C
TXS:0  		-> MI
TXS:1  		-> PO, MI, PD
TXS:2  		-> XO, RI
TXS:3  		-> COH, MI
TXS:4  		-> COL, MI
TXS:5  		-> RO, II, CE

#0x0D
TSX:0  		-> MI, PI
TSX:1  		-> PO, MI
TSX:2  		-> RO, XI
TSX:3  		-> COH, MI
TSX:4  		-> COL, MI
TSX:5  		-> RO, II, CE

#0x0E
PHP:0  		-> MI
PHP:1  		-> PO, MI, PD
PHP:2  		-> FO, RI
PHP:3  		-> COH, MI
PHP:4  		-> COL, MI
PHP:5  		-> RO, II, CE

#0x0F
PLP:0  		-> MI, PI
PLP:1  		-> PO, MI
PLP:2  		-> RO, FL
PLP:3  		-> COH, MI
PLP:4  		-> COL, MI
PLP:5  		-> RO, II, CE

#0x10
TAG:0  		-> AO, GI
TAG:1  		-> COH, MI
TAG:2  		-> COL, MI
TAG:3  		-> RO, II, CE

#0x11
TAX:0  		-> AO, XI
TAX:1  		-> COH, MI
TAX:2  		-> COL, MI
TAX:3  		-> RO, II, CE

#0x12
TGA:0  		-> GO, AI
TGA:1  		-> COH, MI
TGA:2  		-> COL, MI
TGA:3  		-> RO, II, CE

#0x13
TXA:0  		-> XO, AI
TXA:1  		-> COH, MI
TXA:2  		-> COL, MI
TXA:3  		-> RO, II, CE

#0x14
TAD:0  		-> AO, DI
TAD:1  		-> COH, MI
TAD:2  		-> COL, MI
TAD:3  		-> RO, II, CE

#0x15  TODO:FIXME
TCL:0  		-> COH, MI
TCL:1  		-> COL, MI
TCL:2  		-> RO, II, CE

#0x16  TODO:FIXME
TCH:0  		-> COH, MI
TCH:1  		-> COL, MI
TCH:2  		-> RO, II, CE

#0x17
INV:0  		-> LNOT, AI, FI
INV:1  		-> COH, MI
INV:2  		-> COL, MI
INV:3  		-> RO, II, CE

#0x18
#empty

#0x19
#empty

#0x1A
PHX:0  		-> MI
PHX:1  		-> PO, MI, PD
PHX:2  		-> XO, RI
PHX:3  		-> COH, MI
PHX:4  		-> COL, MI
PHX:5  		-> RO, II, CE

#0x1B
PLX:0  		-> MI, PI
PLX:1  		-> PO, MI
PLX:2  		-> RO, XI
PLX:3  		-> COH, MI
PLX:4  		-> COL, MI
PLX:5  		-> RO, II, CE

#0x1C
INX:0  		-> BI
INX:1  		-> EO, XI
INX:2  		-> COH, MI
INX:3  		-> COL, MI
INX:4  		-> RO, II, CE

#0x1D
DEX:0  		-> BI
DEX:1  		-> ES, EO, XI #FIXME
DEX:2  		-> COH, MI
DEX:3  		-> COL, MI
DEX:4  		-> RO, II, CE

#0x1E
ROL:0  		-> LSHL, AI, FI
ROL:1  		-> COH, MI
ROL:2  		-> COL, MI
ROL:3  		-> RO, II, CE

#0x1F
ROR:0  		-> AR, AI, FI
ROR:1  		-> COH, MI
ROR:2  		-> COL, MI
ROR:3  		-> RO, II, CE

#0x20
LDAi:0  		-> COH, MI
LDAi:1  		-> COL, MI, CE
LDAi:2  		-> RO, AI
LDAi:3  		-> COH, MI
LDAi:4  		-> COL, MI
LDAi:5  		-> RO, II, CE

#0x21
LDXi:0  		-> COH, MI
LDXi:1  		-> COL, MI, CE
LDXi:2  		-> RO, XI
LDXi:3  		-> COH, MI
LDXi:4  		-> COL, MI
LDXi:5  		-> RO, II, CE

#0x22
#empty

#0x23
#empty

#0x24
ANDi:0  		-> COH, MI
ANDi:1  		-> COL, MI, CE
ANDi:2  		-> RO, BI
ANDi:3  		-> LAND, AI, FI
ANDi:4  		-> COH, MI
ANDi:5  		-> COL, MI
ANDi:6  		-> RO, II, CE

#0x25
ORAi:0  		-> COH, MI
ORAi:1  		-> COL, MI, CE
ORAi:2  		-> RO, BI
ORAi:3  		-> LORA, AI, FI
ORAi:4  		-> COH, MI
ORAi:5  		-> COL, MI
ORAi:6  		-> RO, II, CE

#0x26
EORi:0  		-> COH, MI
EORi:1  		-> COL, MI, CE
EORi:2  		-> RO, BI
EORi:3  		-> LXOR, AI, FI
EORi:4  		-> COH, MI
EORi:5  		-> COL, MI
EORi:6  		-> RO, II, CE

#0x27
#empty

#0x28
ADCi:0  		-> COH, MI
ADCi:1  		-> COL, MI, CE
ADCi:2  		-> RO, BI
ADCi:3  		-> LADD, AI, FI
ADCi:4  		-> COH, MI
ADCi:5  		-> COL, MI
ADCi:6  		-> RO, II, CE

#0x29
SBCi:0  		-> COH, MI
SBCi:1  		-> COL, MI, CE
SBCi:2  		-> RO, BI
SBCi:3  		-> LSUB, AI, FI
SBCi:4  		-> COH, MI
SBCi:5  		-> COL, MI
SBCi:6  		-> RO, II, CE

#0x2A
CMPi:0  		-> COH, MI
CMPi:1  		-> COL, MI, CE
CMPi:2  		-> RO, BI
CMPi:3  		-> LSUB, LC, FI
CMPi:4  		-> COH, MI
CMPi:5  		-> COL, MI
CMPi:6  		-> RO, II, CE

#0x2B
CPXi:0  		-> COH, MI
CPXi:1  		-> COL, MI, CE
CPXi:2  		-> RO, BI
CPXi:3  		-> ES, EO, BI  #FIXME
CPXi:4  		-> BO, FI
CPXi:5  		-> COH, MI
CPXi:6  		-> COL, MI
CPXi:7  		-> RO, II, CE

#0x2C
#empty

#0x2D
#empty

#0x2E
#empty

#0x2F
#empty

#0x30
LDAabs:0  		-> COH, MI
LDAabs:1  		-> COL, MI, CE
LDAabs:2  		-> RO, BI
LDAabs:3  		-> COH, MI
LDAabs:4  		-> COL, MI, CE
LDAabs:5  		-> RO, MI
LDAabs:6  		-> BO, MI
LDAabs:7  		-> RO, AI
LDAabs:8  		-> COH, MI
LDAabs:9  		-> COL, MI
LDAabs:10 		-> RO, II, CE

#0x31
LDXabs:0  		-> COH, MI
LDXabs:1  		-> COL, MI, CE
LDXabs:2  		-> RO, BI
LDXabs:3  		-> COH, MI
LDXabs:4  		-> COL, MI, CE
LDXabs:5  		-> RO, MI
LDXabs:6  		-> BO, MI
LDXabs:7  		-> RO, XI
LDXabs:8  		-> COH, MI
LDXabs:9  		-> COL, MI
LDXabs:10 		-> RO, II, CE

#0x32
STAabs:0  		-> COH, MI
STAabs:1  		-> COL, MI, CE
STAabs:2  		-> RO, BI
STAabs:3  		-> COH, MI
STAabs:4  		-> COL, MI, CE
STAabs:5  		-> RO, MI
STAabs:6  		-> BO, MI
STAabs:7  		-> AO, RI
STAabs:8  		-> COH, MI
STAabs:9  		-> COL, MI
STAabs:10 		-> RO, II, CE

#0x33
STXabs:0  		-> COH, MI
STXabs:1  		-> COL, MI, CE
STXabs:2  		-> RO, BI
STXabs:3  		-> COH, MI
STXabs:4  		-> COL, MI, CE
STXabs:5  		-> RO, MI
STXabs:6  		-> BO, MI
STXabs:7  		-> XO, RI
STXabs:8  		-> COH, MI
STXabs:9  		-> COL, MI
STXabs:10 		-> RO, II, CE

#0x34
ANDabs:0  		-> COH, MI
ANDabs:1  		-> COL, MI, CE
ANDabs:2  		-> RO, BI
ANDabs:3  		-> COH, MI
ANDabs:4  		-> COL, MI, CE
ANDabs:5  		-> RO, MI
ANDabs:6  		-> BO, MI
ANDabs:7  		-> RO, BI
ANDabs:8  		-> LAND, AI, FI
ANDabs:9  		-> COH, MI
ANDabs:10 		-> COL, MI
ANDabs:11 		-> RO, II, CE

#0x35
ORAabs:0  		-> COH, MI
ORAabs:1  		-> COL, MI, CE
ORAabs:2  		-> RO, BI
ORAabs:3  		-> COH, MI
ORAabs:4  		-> COL, MI, CE
ORAabs:5  		-> RO, MI
ORAabs:6  		-> BO, MI
ORAabs:7  		-> RO, BI
ORAabs:8  		-> LORA, AI, FI
ORAabs:9  		-> COH, MI
ORAabs:10 		-> COL, MI
ORAabs:11 		-> RO, II, CE

#0x36
EORabs:0  		-> COH, MI
EORabs:1  		-> COL, MI, CE
EORabs:2  		-> RO, BI
EORabs:3  		-> COH, MI
EORabs:4  		-> COL, MI, CE
EORabs:5  		-> RO, MI
EORabs:6  		-> BO, MI
EORabs:7  		-> RO, BI
EORabs:8  		-> LXOR, AI, FI
EORabs:9  		-> COH, MI
EORabs:10 		-> COL, MI
EORabs:11 		-> RO, II, CE

#0x37
INVabs:0  		-> COH, MI
INVabs:1  		-> COL, MI, CE
INVabs:2  		-> RO, BI
INVabs:3  		-> COH, MI
INVabs:4  		-> COL, MI, CE
INVabs:5  		-> RO, MI
INVabs:6  		-> BO, MI
INVabs:7  		-> AO, BI
INVabs:8  		-> RO, AI
INVabs:9  		-> LNOT, RI, FI
INVabs:10 		-> BO, AI
INVabs:11 		-> COH, MI
INVabs:12 		-> COL, MI
INVabs:13 		-> RO, II, CE

#0x38
ADCabs:0  		-> COH, MI
ADCabs:1  		-> COL, MI, CE
ADCabs:2  		-> RO, BI
ADCabs:3  		-> COH, MI
ADCabs:4  		-> COL, MI, CE
ADCabs:5  		-> RO, MI
ADCabs:6  		-> BO, MI
ADCabs:7  		-> RO, BI
ADCabs:8  		-> LADD, AI, FI
ADCabs:9  		-> COH, MI
ADCabs:10 		-> COL, MI
ADCabs:11 		-> RO, II, CE

#0x39
SBCabs:0  		-> COH, MI
SBCabs:1  		-> COL, MI, CE
SBCabs:2  		-> RO, BI
SBCabs:3  		-> COH, MI
SBCabs:4  		-> COL, MI, CE
SBCabs:5  		-> RO, MI
SBCabs:6  		-> BO, MI
SBCabs:7  		-> RO, BI
SBCabs:8  		-> LSUB, AI, FI
SBCabs:9  		-> COH, MI
SBCabs:10 		-> COL, MI
SBCabs:11 		-> RO, II, CE

#0x3A
CMPabs:0  		-> COH, MI
CMPabs:1  		-> COL, MI, CE
CMPabs:2  		-> RO, BI
CMPabs:3  		-> COH, MI
CMPabs:4  		-> COL, MI, CE
CMPabs:5  		-> RO, MI
CMPabs:6  		-> BO, MI
CMPabs:7  		-> RO, BI
CMPabs:8  		-> LSUB, LC, FI
CMPabs:9  		-> COH, MI
CMPabs:10 		-> COL, MI
CMPabs:11 		-> RO, II, CE

#0x3B
CPXabs:0  		-> COH, MI
CPXabs:1  		-> COL, MI, CE
CPXabs:2  		-> RO, BI
CPXabs:3  		-> COH, MI
CPXabs:4  		-> COL, MI, CE
CPXabs:5  		-> RO, MI
CPXabs:6  		-> BO, MI
CPXabs:7  		-> RO, BI
CPXabs:8  		-> ES, EO, BI  #FIXME
CPXabs:9  		-> BO, FI
CPXabs:10 		-> COH, MI
CPXabs:11 		-> COL, MI
CPXabs:12 		-> RO, II, CE

#0x3C
INCabs:0  		-> COH, MI
INCabs:1  		-> COL, MI, CE
INCabs:2  		-> RO, BI
INCabs:3  		-> COH, MI
INCabs:4  		-> COL, MI, CE
INCabs:5  		-> RO, MI
INCabs:6  		-> BO, MI
INCabs:7  		-> AO, BI
INCabs:8  		-> RO, AI
INCabs:9  		-> FL                  #TODO: FIXME?
INCabs:10 		-> LADD, RI, FI
INCabs:11 		-> BO, AI
INCabs:12 		-> COH, MI
INCabs:13 		-> COL, MI
INCabs:14 		-> RO, II, CE

#0x3D
DECabs:0  		-> COH, MI
DECabs:1  		-> COL, MI, CE
DECabs:2  		-> RO, BI
DECabs:3  		-> COH, MI
DECabs:4  		-> COL, MI, CE
DECabs:5  		-> RO, MI
DECabs:6  		-> BO, MI
DECabs:7  		-> AO, BI
DECabs:8  		-> RO, AI
DECabs:9  		-> LDEC, LC, RI, FI
DECabs:10 		-> BO, AI
DECabs:11 		-> COH, MI
DECabs:12 		-> COL, MI
DECabs:13 		-> RO, II, CE

#0x3E
ROLabs:0  		-> COH, MI
ROLabs:1  		-> COL, MI, CE
ROLabs:2  		-> RO, BI
ROLabs:3  		-> COH, MI
ROLabs:4  		-> COL, MI, CE
ROLabs:5  		-> RO, MI
ROLabs:6  		-> BO, MI
ROLabs:7  		-> AO, BI
ROLabs:8  		-> RO, AI
ROLabs:9  		-> LSHL, RI, FI
ROLabs:10 		-> BO, AI
ROLabs:11 		-> COH, MI
ROLabs:12 		-> COL, MI
ROLabs:13 		-> RO, II, CE

#0x3F
RORabs:0  		-> COH, MI
RORabs:1  		-> COL, MI, CE
RORabs:2  		-> RO, BI
RORabs:3  		-> COH, MI
RORabs:4  		-> COL, MI, CE
RORabs:5  		-> RO, MI
RORabs:6  		-> BO, MI
RORabs:7  		-> AO, BI
RORabs:8  		-> RO, AI
RORabs:9  		-> AR, RI, FI
RORabs:10 		-> BO, AI
RORabs:11 		-> COH, MI
RORabs:12 		-> COL, MI
RORabs:13 		-> RO, II, CE

#0x40
JMPabs:0  		-> COH, MI
JMPabs:1  		-> COL, MI, CE
JMPabs:2  		-> RO, BI
JMPabs:3  		-> COH, MI
JMPabs:4  		-> COL, MI, CE
JMPabs:5  		-> RO, CI, JU
JMPabs:6  		-> BO, CI, JU
JMPabs:7  		-> COH, MI
JMPabs:8  		-> COL, MI
JMPabs:9  		-> RO, II, CE

#0x41
JSRabs:0  		-> MI
JSRabs:1  		-> PO, MI, PD
JSRabs:2  		-> COL, RI
JSRabs:3  		-> MI
JSRabs:4  		-> PO, MI, PD
JSRabs:5  		-> COH, RI
JSRabs:6  		-> COH, MI
JSRabs:7  		-> COL, MI, CE
JSRabs:8  		-> RO, BI
JSRabs:9  		-> COH, MI
JSRabs:10 		-> COL, MI, CE
JSRabs:11 		-> RO, CI, JU
JSRabs:12 		-> BO, CI, JU
JSRabs:13 		-> COH, MI
JSRabs:14 		-> COL, MI
JSRabs:15 		-> RO, II, CE

#0x42
BCSabs:0  		-> COH, MI
BCSabs:1  		-> COL, MI, CE
BCSabs:2  		-> RO, BI
BCSabs:3  		-> COH, MI
BCSabs:4  		-> COL, MI, CE
BCSabs:5  		-> RO, CI
BCSabs:6  		-> BO, CI
BCSabs:7  		-> COH, MI
BCSabs:8  		-> COL, MI
BCSabs:9  		-> RO, II, CE
BCSabs:10 		-> COH, MI
BCSabs:11 		-> COL, MI
BCSabs:12 		-> RO, II, CE

#0x43
BCCabs:0  		-> COH, MI
BCCabs:1  		-> COL, MI, CE
BCCabs:2  		-> RO, BI
BCCabs:3  		-> COH, MI
BCCabs:4  		-> COL, MI, CE
BCCabs:5  		-> RO, CI, FV
BCCabs:6  		-> BO, CI, FV
BCCabs:7  		-> COH, MI
BCCabs:8  		-> COL, MI
BCCabs:9  		-> RO, II, CE

#0x44
BEQabs:0  		-> COH, MI
BEQabs:1  		-> COL, MI, CE
BEQabs:2  		-> RO, BI
BEQabs:3  		-> COH, MI
BEQabs:4  		-> COL, MI, CE
BEQabs:5  		-> RO, CI, F1
BEQabs:6  		-> BO, CI, F1
BEQabs:7  		-> COH, MI
BEQabs:8  		-> COL, MI
BEQabs:9  		-> RO, II, CE

#0x45
BNEabs:0  		-> COH, MI
BNEabs:1  		-> COL, MI, CE
BNEabs:2  		-> RO, BI
BNEabs:3  		-> COH, MI
BNEabs:4  		-> COL, MI, CE
BNEabs:5  		-> RO, CI, F1, FV
BNEabs:6  		-> BO, CI, F1, FV
BNEabs:7  		-> COH, MI
BNEabs:8  		-> COL, MI
BNEabs:9  		-> RO, II, CE

#0x46
BMIabs:0  		-> COH, MI
BMIabs:1  		-> COL, MI, CE
BMIabs:2  		-> RO, BI
BMIabs:3  		-> COH, MI
BMIabs:4  		-> COL, MI, CE
BMIabs:5  		-> RO, CI, F2
BMIabs:6  		-> BO, CI, F2
BMIabs:7  		-> COH, MI
BMIabs:8  		-> COL, MI
BMIabs:9  		-> RO, II, CE

#0x47
BPLabs:0  		-> COH, MI
BPLabs:1  		-> COL, MI, CE
BPLabs:2  		-> RO, BI
BPLabs:3  		-> COH, MI
BPLabs:4  		-> COL, MI, CE
BPLabs:5  		-> RO, CI, F2, FV
BPLabs:6  		-> BO, CI, F2, FV
BPLabs:7  		-> COH, MI
BPLabs:8  		-> COL, MI
BPLabs:9  		-> RO, II, CE

#0x48
BVSabs:0  		-> COH, MI
BVSabs:1  		-> COL, MI, CE
BVSabs:2  		-> RO, BI
BVSabs:3  		-> COH, MI
BVSabs:4  		-> COL, MI, CE
BVSabs:5  		-> RO, CI, F1, F2
BVSabs:6  		-> BO, CI, F1, F2
BVSabs:7  		-> COH, MI
BVSabs:8  		-> COL, MI
BVSabs:9  		-> RO, II, CE

#0x49
BVCabs:0  		-> COH, MI
BVCabs:1  		-> COL, MI, CE
BVCabs:2  		-> RO, BI
BVCabs:3  		-> COH, MI
BVCabs:4  		-> COL, MI, CE
BVCabs:5  		-> RO, CI, F1, F2, FV
BVCabs:6  		-> BO, CI, F1, F2, FV
BVCabs:7  		-> COH, MI
BVCabs:8  		-> COL, MI
BVCabs:9  		-> RO, II, CE

#0x4A
#empty

#0x4B
#empty

#0x4C
#empty

#0x4D
#empty

#0x4E
#empty

#0x4F
#empty

#0x50
LDAzp:0  		-> COH, MI
LDAzp:1  		-> COL, MI, CE
LDAzp:2  		-> RO, BI
LDAzp:3  		-> LZRO, MI
LDAzp:4  		-> BO, MI
LDAzp:5  		-> RO, AI
LDAzp:6  		-> COH, MI
LDAzp:7  		-> COL, MI
LDAzp:8  		-> RO, II, CE

#0x51
LDXzp:0  		-> COH, MI
LDXzp:1  		-> COL, MI, CE
LDXzp:2  		-> RO, BI
LDXzp:3  		-> LZRO, MI
LDXzp:4  		-> BO, MI
LDXzp:5  		-> RO, XI
LDXzp:6  		-> COH, MI
LDXzp:7  		-> COL, MI
LDXzp:8  		-> RO, II, CE

#0x52
STAzp:0  		-> COH, MI
STAzp:1  		-> COL, MI, CE
STAzp:2  		-> RO, BI
STAzp:3  		-> LZRO, MI
STAzp:4  		-> BO, MI
STAzp:5  		-> AO, RI
STAzp:6  		-> COH, MI
STAzp:7  		-> COL, MI
STAzp:8  		-> RO, II, CE

#0x53
STXzp:0  		-> COH, MI
STXzp:1  		-> COL, MI, CE
STXzp:2  		-> RO, BI
STXzp:3  		-> LZRO, MI
STXzp:4  		-> BO, MI
STXzp:5  		-> XO, RI
STXzp:6  		-> COH, MI
STXzp:7  		-> COL, MI
STXzp:8  		-> RO, II, CE

#0x54
ANDzp:0  		-> COH, MI
ANDzp:1  		-> COL, MI, CE
ANDzp:2  		-> RO, BI
ANDzp:3  		-> LZRO, MI
ANDzp:4  		-> BO, MI
ANDzp:5  		-> RO, BI
ANDzp:6  		-> LAND, AI, FI
ANDzp:7  		-> COH, MI
ANDzp:8  		-> COL, MI
ANDzp:9  		-> RO, II, CE

#0x55
ORAzp:0  		-> COH, MI
ORAzp:1  		-> COL, MI, CE
ORAzp:2  		-> RO, BI
ORAzp:3  		-> LZRO, MI
ORAzp:4  		-> BO, MI
ORAzp:5  		-> RO, BI
ORAzp:6  		-> LORA, AI, FI
ORAzp:7  		-> COH, MI
ORAzp:8  		-> COL, MI
ORAzp:9  		-> RO, II, CE

#0x56
EORzp:0  		-> COH, MI
EORzp:1  		-> COL, MI, CE
EORzp:2  		-> RO, BI
EORzp:3  		-> LZRO, MI
EORzp:4  		-> BO, MI
EORzp:5  		-> RO, BI
EORzp:6  		-> LXOR, AI, FI
EORzp:7  		-> COH, MI
EORzp:8  		-> COL, MI
EORzp:9  		-> RO, II, CE

#0x57
INVzp:0  		-> COH, MI
INVzp:1  		-> COL, MI, CE
INVzp:2  		-> RO, BI
INVzp:3  		-> LZRO, MI
INVzp:4  		-> BO, MI
INVzp:5  		-> AO, BI
INVzp:6  		-> RO, AI
INVzp:7  		-> LNOT, RI, FI
INVzp:8  		-> BO, AI
INVzp:9  		-> COH, MI
INVzp:10 		-> COL, MI
INVzp:11 		-> RO, II, CE

#0x58
ADCzp:0  		-> COH, MI
ADCzp:1  		-> COL, MI, CE
ADCzp:2  		-> RO, BI
ADCzp:3  		-> LZRO, MI
ADCzp:4  		-> BO, MI
ADCzp:5  		-> RO, BI
ADCzp:6  		-> LADD, AI, FI
ADCzp:7  		-> COH, MI
ADCzp:8  		-> COL, MI
ADCzp:9  		-> RO, II, CE

#0x59
SBCzp:0  		-> COH, MI
SBCzp:1  		-> COL, MI, CE
SBCzp:2  		-> RO, BI
SBCzp:3  		-> LZRO, MI
SBCzp:4  		-> BO, MI
SBCzp:5  		-> RO, BI
SBCzp:6  		-> LSUB, AI, FI
SBCzp:7  		-> COH, MI
SBCzp:8  		-> COL, MI
SBCzp:9  		-> RO, II, CE

#0x5A
CMPzp:0  		-> COH, MI
CMPzp:1  		-> COL, MI, CE
CMPzp:2  		-> RO, BI
CMPzp:3  		-> LZRO, MI
CMPzp:4  		-> BO, MI
CMPzp:5  		-> RO, BI
CMPzp:6  		-> FL               #TODO: FIXME?
CMPzp:7  		-> LSUB, LC, FI
CMPzp:8  		-> COH, MI
CMPzp:9  		-> COL, MI
CMPzp:10 		-> RO, II, CE

#0x5B
CPXzp:0  		-> COH, MI
CPXzp:1  		-> COL, MI, CE
CPXzp:2  		-> RO, BI
CPXzp:3  		-> LZRO, MI
CPXzp:4  		-> BO, MI
CPXzp:5  		-> RO, BI
CPXzp:6  		-> ES, EO, BI  #FIXME
CPXzp:7  		-> BO, FI
CPXzp:8  		-> COH, MI
CPXzp:9  		-> COL, MI
CPXzp:10 		-> RO, II, CE

#0x5C
INCzp:0  		-> COH, MI
INCzp:1  		-> COL, MI, CE
INCzp:2  		-> RO, BI
INCzp:3  		-> LZRO, MI
INCzp:4  		-> BO, MI
INCzp:5  		-> AO, BI
INCzp:6  		-> RO, AI
INCzp:7  		-> FL                  #TODO: FIXME?
INCzp:8  		-> LADD, RI, FI
INCzp:9  		-> BO, AI
INCzp:10 		-> COH, MI
INCzp:11 		-> COL, MI
INCzp:12 		-> RO, II, CE

#0x5D
DECzp:0  		-> COH, MI
DECzp:1  		-> COL, MI, CE
DECzp:2  		-> RO, BI
DECzp:3  		-> LZRO, MI
DECzp:4  		-> BO, MI
DECzp:5  		-> AO, BI
DECzp:6  		-> RO, AI
DECzp:7  		-> LDEC, LC, RI, FI
DECzp:8  		-> BO, AI
DECzp:9  		-> COH, MI
DECzp:10 		-> COL, MI
DECzp:11 		-> RO, II, CE

#0x5E
ROLzp:0  		-> COH, MI
ROLzp:1  		-> COL, MI, CE
ROLzp:2  		-> RO, BI
ROLzp:3  		-> LZRO, MI
ROLzp:4  		-> BO, MI
ROLzp:5  		-> AO, BI
ROLzp:6  		-> RO, AI
ROLzp:7  		-> LSHL, RI, FI
ROLzp:8  		-> BO, AI
ROLzp:9  		-> COH, MI
ROLzp:10 		-> COL, MI
ROLzp:11 		-> RO, II, CE

#0x5F
RORzp:0  		-> COH, MI
RORzp:1  		-> COL, MI, CE
RORzp:2  		-> RO, BI
RORzp:3  		-> LZRO, MI
RORzp:4  		-> BO, MI
RORzp:5  		-> AO, BI
RORzp:6  		-> RO, AI
RORzp:7  		-> AR, RI, FI
RORzp:8  		-> BO, AI
RORzp:9  		-> COH, MI
RORzp:10 		-> COL, MI
RORzp:11 		-> RO, II, CE

#0x60
LDAabsx:0  		-> COH, MI
LDAabsx:1  		-> COL, MI, CE
LDAabsx:2  		-> RO, BI
LDAabsx:3  		-> COH, MI
LDAabsx:4  		-> COL, MI, CE
LDAabsx:5  		-> RO, MI
LDAabsx:6  		-> EO, MI
LDAabsx:7  		-> RO, AI
LDAabsx:8  		-> COH, MI
LDAabsx:9  		-> COL, MI
LDAabsx:10 		-> RO, II, CE

#0x61
#empty

#0x62
STAabsx:0  		-> COH, MI
STAabsx:1  		-> COL, MI, CE
STAabsx:2  		-> RO, BI
STAabsx:3  		-> COH, MI
STAabsx:4  		-> COL, MI, CE
STAabsx:5  		-> RO, MI
STAabsx:6  		-> EO, MI
STAabsx:7  		-> AO, RI
STAabsx:8  		-> COH, MI
STAabsx:9  		-> COL, MI
STAabsx:10 		-> RO, II, CE

#0x63
#empty

#0x64
ANDabsx:0  		-> COH, MI
ANDabsx:1  		-> COL, MI, CE
ANDabsx:2  		-> RO, BI
ANDabsx:3  		-> COH, MI
ANDabsx:4  		-> COL, MI, CE
ANDabsx:5  		-> RO, MI
ANDabsx:6  		-> EO, MI
ANDabsx:7  		-> RO, BI
ANDabsx:8  		-> LAND, AI, FI
ANDabsx:9  		-> COH, MI
ANDabsx:10 		-> COL, MI
ANDabsx:11 		-> RO, II, CE

#0x65
ORAabsx:0  		-> COH, MI
ORAabsx:1  		-> COL, MI, CE
ORAabsx:2  		-> RO, BI
ORAabsx:3  		-> COH, MI
ORAabsx:4  		-> COL, MI, CE
ORAabsx:5  		-> RO, MI
ORAabsx:6  		-> EO, MI
ORAabsx:7  		-> RO, BI
ORAabsx:8  		-> LORA, AI, FI
ORAabsx:9  		-> COH, MI
ORAabsx:10 		-> COL, MI
ORAabsx:11 		-> RO, II, CE

#0x66
EORabsx:0  		-> COH, MI
EORabsx:1  		-> COL, MI, CE
EORabsx:2  		-> RO, BI
EORabsx:3  		-> COH, MI
EORabsx:4  		-> COL, MI, CE
EORabsx:5  		-> RO, MI
EORabsx:6  		-> EO, MI
EORabsx:7  		-> RO, BI
EORabsx:8  		-> LXOR, AI, FI
EORabsx:9  		-> COH, MI
EORabsx:10 		-> COL, MI
EORabsx:11 		-> RO, II, CE

#0x67
INVabsx:0  		-> COH, MI
INVabsx:1  		-> COL, MI, CE
INVabsx:2  		-> RO, BI
INVabsx:3  		-> COH, MI
INVabsx:4  		-> COL, MI, CE
INVabsx:5  		-> RO, MI
INVabsx:6  		-> EO, MI
INVabsx:7  		-> AO, BI
INVabsx:8  		-> RO, AI
INVabsx:9  		-> LNOT, RI, FI
INVabsx:10 		-> BO, AI
INVabsx:11 		-> COH, MI
INVabsx:12 		-> COL, MI
INVabsx:13 		-> RO, II, CE

#0x68
ADCabsx:0  		-> COH, MI
ADCabsx:1  		-> COL, MI, CE
ADCabsx:2  		-> RO, BI
ADCabsx:3  		-> COH, MI
ADCabsx:4  		-> COL, MI, CE
ADCabsx:5  		-> RO, MI
ADCabsx:6  		-> EO, MI
ADCabsx:7  		-> RO, BI
ADCabsx:8  		-> LADD, AI, FI
ADCabsx:9  		-> COH, MI
ADCabsx:10 		-> COL, MI
ADCabsx:11 		-> RO, II, CE

#0x69
SBCabsx:0  		-> COH, MI
SBCabsx:1  		-> COL, MI, CE
SBCabsx:2  		-> RO, BI
SBCabsx:3  		-> COH, MI
SBCabsx:4  		-> COL, MI, CE
SBCabsx:5  		-> RO, MI
SBCabsx:6  		-> EO, MI
SBCabsx:7  		-> RO, BI
SBCabsx:8  		-> LSUB, AI, FI
SBCabsx:9  		-> COH, MI
SBCabsx:10 		-> COL, MI
SBCabsx:11 		-> RO, II, CE

#0x6A
CMPabsx:0  		-> COH, MI
CMPabsx:1  		-> COL, MI, CE
CMPabsx:2  		-> RO, BI
CMPabsx:3  		-> COH, MI
CMPabsx:4  		-> COL, MI, CE
CMPabsx:5  		-> RO, MI
CMPabsx:6  		-> EO, MI
CMPabsx:7  		-> RO, BI
CMPabsx:8  		-> LSUB, LC, FI
CMPabsx:9  		-> COH, MI
CMPabsx:10 		-> COL, MI
CMPabsx:11 		-> RO, II, CE

#0x6B
#empty

#0x6C
INCabsx:0  		-> COH, MI
INCabsx:1  		-> COL, MI, CE
INCabsx:2  		-> RO, BI
INCabsx:3  		-> COH, MI
INCabsx:4  		-> COL, MI, CE
INCabsx:5  		-> RO, MI
INCabsx:6  		-> EO, MI
INCabsx:7  		-> AO, BI
INCabsx:8  		-> RO, AI
INCabsx:9  		-> FL                  #TODO: FIXME?
INCabsx:10 		-> LADD, RI, FI
INCabsx:11 		-> BO, AI
INCabsx:12 		-> COH, MI
INCabsx:13 		-> COL, MI
INCabsx:14 		-> RO, II, CE

#0x6D
DECabsx:0  		-> COH, MI
DECabsx:1  		-> COL, MI, CE
DECabsx:2  		-> RO, BI
DECabsx:3  		-> COH, MI
DECabsx:4  		-> COL, MI, CE
DECabsx:5  		-> RO, MI
DECabsx:6  		-> EO, MI
DECabsx:7  		-> AO, BI
DECabsx:8  		-> RO, AI
DECabsx:9  		-> LDEC, LC, RI, FI
DECabsx:10 		-> BO, AI
DECabsx:11 		-> COH, MI
DECabsx:12 		-> COL, MI
DECabsx:13 		-> RO, II, CE

#0x6E
ROLabsx:0  		-> COH, MI
ROLabsx:1  		-> COL, MI, CE
ROLabsx:2  		-> RO, BI
ROLabsx:3  		-> COH, MI
ROLabsx:4  		-> COL, MI, CE
ROLabsx:5  		-> RO, MI
ROLabsx:6  		-> EO, MI
ROLabsx:7  		-> AO, BI
ROLabsx:8  		-> RO, AI
ROLabsx:9  		-> LSHL, RI, FI
ROLabsx:10 		-> BO, AI
ROLabsx:11 		-> COH, MI
ROLabsx:12 		-> COL, MI
ROLabsx:13 		-> RO, II, CE

#0x6F
RORabsx:0  		-> COH, MI
RORabsx:1  		-> COL, MI, CE
RORabsx:2  		-> RO, BI
RORabsx:3  		-> COH, MI
RORabsx:4  		-> COL, MI, CE
RORabsx:5  		-> RO, MI
RORabsx:6  		-> EO, MI
RORabsx:7  		-> AO, BI
RORabsx:8  		-> RO, AI
RORabsx:9  		-> AR, RI, FI
RORabsx:10 		-> BO, AI
RORabsx:11 		-> COH, MI
RORabsx:12 		-> COL, MI
RORabsx:13 		-> RO, II, CE

#0x70
LDAzpx:0  		-> COH, MI
LDAzpx:1  		-> COL, MI, CE
LDAzpx:2  		-> RO, BI
LDAzpx:3  		-> LZRO, MI
LDAzpx:4  		-> EO, MI
LDAzpx:5  		-> RO, AI
LDAzpx:6  		-> COH, MI
LDAzpx:7  		-> COL, MI
LDAzpx:8  		-> RO, II, CE

#0x71
#empty

#0x72
STAzpx:0  		-> COH, MI
STAzpx:1  		-> COL, MI, CE
STAzpx:2  		-> RO, BI
STAzpx:3  		-> LZRO, MI
STAzpx:4  		-> EO, MI
STAzpx:5  		-> AO, RI
STAzpx:6  		-> COH, MI
STAzpx:7  		-> COL, MI
STAzpx:8  		-> RO, II, CE

#0x73
#empty

#0x74
ANDzpx:0  		-> COH, MI
ANDzpx:1  		-> COL, MI, CE
ANDzpx:2  		-> RO, BI
ANDzpx:3  		-> LZRO, MI
ANDzpx:4  		-> EO, MI
ANDzpx:5  		-> RO, BI
ANDzpx:6  		-> LAND, AI, FI
ANDzpx:7  		-> COH, MI
ANDzpx:8  		-> COL, MI
ANDzpx:9  		-> RO, II, CE

#0x75
ORAzpx:0  		-> COH, MI
ORAzpx:1  		-> COL, MI, CE
ORAzpx:2  		-> RO, BI
ORAzpx:3  		-> LZRO, MI
ORAzpx:4  		-> EO, MI
ORAzpx:5  		-> RO, BI
ORAzpx:6  		-> LORA, AI, FI
ORAzpx:7  		-> COH, MI
ORAzpx:8  		-> COL, MI
ORAzpx:9  		-> RO, II, CE

#0x76
EORzpx:0  		-> COH, MI
EORzpx:1  		-> COL, MI, CE
EORzpx:2  		-> RO, BI
EORzpx:3  		-> LZRO, MI
EORzpx:4  		-> EO, MI
EORzpx:5  		-> RO, BI
EORzpx:6  		-> LXOR, AI, FI
EORzpx:7  		-> COH, MI
EORzpx:8  		-> COL, MI
EORzpx:9  		-> RO, II, CE

#0x77
INVzpx:0  		-> COH, MI
INVzpx:1  		-> COL, MI, CE
INVzpx:2  		-> RO, BI
INVzpx:3  		-> LZRO, MI
INVzpx:4  		-> EO, MI
INVzpx:5  		-> AO, BI
INVzpx:6  		-> RO, AI
INVzpx:7  		-> LNOT, RI, FI
INVzpx:8  		-> BO, AI
INVzpx:9  		-> COH, MI
INVzpx:10 		-> COL, MI
INVzpx:11 		-> RO, II, CE

#0x78
ADCzpx:0  		-> COH, MI
ADCzpx:1  		-> COL, MI, CE
ADCzpx:2  		-> RO, BI
ADCzpx:3  		-> LZRO, MI
ADCzpx:4  		-> EO, MI
ADCzpx:5  		-> RO, BI
ADCzpx:6  		-> LADD, AI, FI
ADCzpx:7  		-> COH, MI
ADCzpx:8  		-> COL, MI
ADCzpx:9  		-> RO, II, CE

#0x79
SBCzpx:0  		-> COH, MI
SBCzpx:1  		-> COL, MI, CE
SBCzpx:2  		-> RO, BI
SBCzpx:3  		-> LZRO, MI
SBCzpx:4  		-> EO, MI
SBCzpx:5  		-> RO, BI
SBCzpx:6  		-> LSUB, AI, FI
SBCzpx:7  		-> COH, MI
SBCzpx:8  		-> COL, MI
SBCzpx:9  		-> RO, II, CE

#0x7A
CMPzpx:0  		-> COH, MI
CMPzpx:1  		-> COL, MI, CE
CMPzpx:2  		-> RO, BI
CMPzpx:3  		-> LZRO, MI
CMPzpx:4  		-> EO, MI
CMPzpx:5  		-> RO, BI
CMPzpx:6  		-> LSUB, LC, FI
CMPzpx:7  		-> COH, MI
CMPzpx:8  		-> COL, MI
CMPzpx:9  		-> RO, II, CE

#0x7B
#empty

#0x7C
#TODO: Does this need a FI to force incrementing with a carry?
INCzpx:0  		-> COH, MI
INCzpx:1  		-> COL, MI, CE
INCzpx:2  		-> RO, BI
INCzpx:3  		-> LZRO, MI
INCzpx:4  		-> EO, MI
INCzpx:5  		-> AO, BI
INCzpx:6  		-> RO, AI
INCzpx:7  		-> BI
INCzpx:8  		-> LADD, RI, FI
INCzpx:9  		-> BO, AI
INCzpx:10 		-> COH, MI
INCzpx:11 		-> COL, MI
INCzpx:12 		-> RO, II, CE

#0x7D
DECzpx:0  		-> COH, MI
DECzpx:1  		-> COL, MI, CE
DECzpx:2  		-> RO, BI
DECzpx:3  		-> LZRO, MI
DECzpx:4  		-> EO, MI
DECzpx:5  		-> AO, BI
DECzpx:6  		-> RO, AI
DECzpx:7  		-> LDEC, LC, RI, FI
DECzpx:8  		-> BO, AI
DECzpx:9  		-> COH, MI
DECzpx:10 		-> COL, MI
DECzpx:11 		-> RO, II, CE

#0x7E
ROLzpx:0  		-> COH, MI
ROLzpx:1  		-> COL, MI, CE
ROLzpx:2  		-> RO, BI
ROLzpx:3  		-> LZRO, MI
ROLzpx:4  		-> EO, MI
ROLzpx:5  		-> AO, BI
ROLzpx:6  		-> RO, AI
ROLzpx:7  		-> LSHL, RI, FI
ROLzpx:8  		-> BO, AI
ROLzpx:9  		-> COH, MI
ROLzpx:10 		-> COL, MI
ROLzpx:11 		-> RO, II, CE

#0x7F
RORzpx:0  		-> COH, MI
RORzpx:1  		-> COL, MI, CE
RORzpx:2  		-> RO, BI
RORzpx:3  		-> LZRO, MI
RORzpx:4  		-> EO, MI
RORzpx:5  		-> AO, BI
RORzpx:6  		-> RO, AI
RORzpx:7  		-> AR, RI, FI
RORzpx:8  		-> BO, AI
RORzpx:9  		-> COH, MI
RORzpx:10 		-> COL, MI
RORzpx:11 		-> RO, II, CE

}
