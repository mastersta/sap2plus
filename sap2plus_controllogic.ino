#include <Adafruit_MCP23X17.h>
#include <Adafruit_MCP23XXX.h>

#define debounce           10  //how long to wait for debounce of switch


//pins to collect data bus values
#define pin_instr0         2
#define pin_instr1         3
#define pin_instr2         4
#define pin_instr3         5
#define pin_instr4         6
#define pin_instr5         7
#define pin_instr6         8
#define pin_instr7         9  //just for viewing

//pins for i2c comms
#define pin_i2cClock       11
#define pin_i2cData        12

//pins for system clock control
#define pin_sysclockOut    A0
#define pin_sysclockMode   A1
#define pin_sysclockPulse  A2
#define pin_sysclockSpeed  A3

//pin assignments for port expanders
//MCP23017_0
#define PEpin_Y0           0
#define PEpin_Y1           1
#define PEpin_Y2           2
#define PEpin_Z0           3
#define PEpin_Z1           4
#define PEpin_Z2           5
#define PEpin_T0           6
#define PEpin_T1           7
#define PEpin_T2           8
#define PEpin_PI           9
#define PEpin_PD           10
#define PEpin_TC           11
#define PEpin_JU           12
#define PEpin_FV           13
#define PEpin_F1           14
#define PEpin_F2           15

//MCP23017_1
#define PEpin_FL           0
#define PEpin_L3           1
#define PEpin_L2           2
#define PEpin_L1           3
#define PEpin_L0           4
#define PEpin_LC           5
#define PEpin_LM           6
#define PEpin_ES           7
#define PEpin_data0        8
#define PEpin_data1        9
#define PEpin_data2        10
#define PEpin_data3        11
#define PEpin_data4        12
#define PEpin_data5        13
#define PEpin_data6        14
#define PEpin_data7        15

//MCP23017 stand-ins for control EEPROMS
Adafruit_MCP23X17 mcp0;
Adafruit_MCP23X17 mcp1;

//instruction mnemonic definitions
//input decoder (controller 0)
#define II                 0x200000
#define MI                 0x400000
#define RI                 0x600000
#define IR                 0x800000
#define AI                 0xA00000
#define BI                 0xC00000
#define XI                 0xE00000

//output decoder (controller 0)
#define RO                 0x040000
#define AR                 0x080000
#define LO                 0x0C0000
#define EO                 0x100000
#define XO                 0x140000
#define PO                 0x180000
#define FO                 0x1C0000

//misc decoder (controller 0/1)
#define CE                 0x008000
#define CI                 0x010000
#define COH                0x018000
#define COL                0x020000
#define FI                 0x028000
#define FC                 0x030000
#define TD                 0x038000

//controller 1
#define PI                 0x004000
#define PD                 0x002000
#define TC                 0x001000
#define JU                 0x000800
#define FV                 0x000400
#define F1                 0x000200
#define F2                 0x000100

//controller 2
#define FL                 0x000080
#define L3                 0x000040
#define L2                 0x000020
#define L1                 0x000010
#define L0                 0x000008
#define LC                 0x000004
#define LM                 0x000002
#define ES                 0x000001

//ALU functions
#define AO                 0x000004
#define BO                 0x000052
#define LADD               0x000008
#define LSUB               0x000030
#define LDEC               0x00007C
#define LSHL               0x000064
#define LZRO               0x00001A
#define LNEG               0x00001C
#define LNOT               0x000002
#define LAND               0x00005A
#define LORA               0x00000C
#define LXOR               0x000032

//active-low inputs for each controller, to be xor'd later
#define ctrl0_bar          0b00000000
#define ctrl1_bar          0b01101000
#define ctrl2_bar          0b00000000

/*========================================
         instruction microcode
  step 0: COH|MI      [JTI]:MI        [INI]:PO|CI|JU
  step 1: COL|MI      [JTI]:PO|MI|PD  [INI]:LZRO|CI|JU
  step 2: RO|II|CE    [JTI]:COL|RI    [INI]:LNEG|PI
          steps 3-15 follow:
========================================*/
const long uinstr_template[128][13] PROGMEM {
/*                   step 3           step 4          step 5          step 6          step 7          step 8          step 9          step 10         step 11         step 12         step 13         step 14         step 15 */
/*0x00 INI      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x01 TAX      */  {AO|XI,           IR,             0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x02 INX      */  {BI,              EO|XI,          IR,             0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x03 LDA i    */  {COH|MI,          COL|MI|CE,      RO|AI,          IR,             0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x04 AND abs  */  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          RO|BI,          LAND|LO|AI|FI,  FI|IR,          0,              0,              0},
/*0x05 LDA abs  */  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          RO|AI,          IR,             0,              0,              0,              0},
/*0x06 INC abs  */  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          BI,             RO|AI,          LO|LADD|RI|FI,  FI|IR,          0,              0},
/*0x07 BCS      */  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|CI,          BO|CI,          IR,             0,              0,              0,              0,              0},
/*                   step 3           step 4          step 5          step 6          step 7          step 8          step 9          step 10         step 11         step 12         step 13         step 14         step 15 */
/*0x08 LDA zp   */  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          RO|AI,          IR,             0,              0,              0,              0,              0,              0},
/*0x09 ADC zp   */  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          RO|BI,          LADD|LO|AI|FI,  FI|IR,          0,              0,              0,              0,              0},
/*0x0A LDA abs,x*/  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          EO|MI,          RO|AI,          IR,             0,              0,              0,              0},
/*0x0B INC abs,x*/  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          EO|MI,          BI,             RO|AI,          LO|AI|FI,       AO|RI|FI,       IR,             0},
/*0x0C LDA zp,x */  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          RO|AI,          IR,             0,              0,              0,              0,              0,              0},
/*0x0D INC zp,x */  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          RO|AI,          BI              LADD|LC|RI|FI,  FI|IR,          0,              0,              0,              0},
/*0x0E LDA(zp,x)*/  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          RO|AI},
/*0x0F LDA(zp),x*/  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          EO|MI,          RO|AI},
/*                   step 3           step 4          step 5          step 6          step 7          step 8          step 9          step 10         step 11         step 12         step 13         step 14         step 15 */
/*0x10 NOP      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x11 TXA      */  {XO|AI,           IR,             0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x12 DEX      */  {LNEG|LO|BI,      EO|ES|XI,       IR,             0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x13 LDX i    */  {COH|MI,          COL|MI|CE,      RO|XI,          IR,             0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x14 EOR abs  */  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          RO|BI,          LXOR|LO|AI|FI,  FI|IR,          0,              0,              0},
/*0x15 LDX abs  */  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          RO|XI,          IR,             0,              0,              0,              0},
/*0x16 DEC abs  */  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          BI,             RO|AI,          LO|AI|FI,       AO|RI|FI,       IR,             0},
/*0x17 BCC      */  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|CI|FV,       BO|CI|FV,       IR,             0,              0,              0,              0,              0},
/*                   step 3           step 4          step 5          step 6          step 7          step 8          step 9          step 10         step 11         step 12         step 13         step 14         step 15 */
/*0x18 LDX zp   */  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          RO|XI,          IR,             0,              0,              0,              0,              0,              0},
/*0x19 SBC zp   */  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          RO|BI,          LSUB|LO|AI|FI,  FI|IR,          0,              0,              0,              0,              0},
/*0x1A STA abs,x*/  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          EO|MI,          AO|RI,          IR,             0,              0,              0,              0},
/*0x1B DEC abs,x*/  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          EO|MI,          BI,             RO|AI,          LO|AI|FI,       AO|RI|FI,       IR,             0},
/*0x1C STA zp,x */  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          AO|RI,          IR,             0,              0,              0,              0,              0,              0},
/*0x1D DEC zp,x */  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          RO|AI,          LDEC|LO|RI,     IR,             0,              0,              0,              0,              0},
/*0x1E STA(zp,x)*/  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          AO|RI},
/*0x1F STA(zp),x*/  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          EO|MI,          AO|RI},
/*                   step 3           step 4          step 5          step 6          step 7          step 8          step 9          step 10         step 11         step 12         step 13         step 14         step 15 */
/*0x20 RTI      */  {MI|PI,           PO|MI|PI,       RO|CI|JU,       MI,             PO|MI|PI,       RO|CI|JU,       IR,             0,              0,              0,              0,              0,              0},
/*0x21 TSX      */  {MI|PI,           PO|MI|PI,       RO|XI,          IR,             0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x22 ROL      */  {LSHL|LO|BI,      BO|AI,          IR,             0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x23 AND i    */  {COH|MI,          COL|MI|CE,      RO|BI,          LAND|LO|AI,     IR,             0,              0,              0,              0,              0,              0,              0,              0},
/*0x24 ORA abs  */  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          RO|BI,          LORA|LO|AI|FI,  FI|IR,          0,              0,              0},
/*0x25 STA abs  */  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          AO|RI,          IR,             0,              0,              0,              0},
/*0x26 ROL abs  */  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          RO|AI,          LSHL|LO|RI,     IR,             0,              0,              0},
/*0x27 BEZ      */  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|CI|F1,       BO|CI|F1,       IR,             0,              0,              0,              0,              0},
/*                   step 3           step 4          step 5          step 6          step 7          step 8          step 9          step 10         step 11         step 12         step 13         step 14         step 15 */
/*0x28 STA zp   */  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          AO|RI,          IR,             0,              0,              0,              0,              0,              0},
/*0x29 ROL zp   */  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          RO|AI,          LSHL|LO|RI,     IR,             0,              0,              0,              0,              0},
/*0x2A AND abs,x*/  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          EO|MI,          RO|BI,          LAND|LO|AI|FI,  FI|IR,          0,              0,              0},
/*0x2B ROL abs,x*/  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          EO|MI,          RO|AI,          LSHL|LO|RI,     IR,             0,              0,              0},
/*0x2C AND zp,x */  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          RO|BI,          LAND|LO|AI|FI,  FI|IR,          0,              0,              0,              0,              0},
/*0x2D ROL zp,x */  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          RO|BI,          LSHL|LO|AI|FI,  FI|IR,          0,              0,              0,              0,              0},
/*0x2E AND(zp,x)*/  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          LAND|LO|AI|FI}, //TODO: save a step to get the second FI
/*0x2F AND(zp),x*/  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          EO|MI,          LAND|LO|AI|FI}, //TODO: save a step to get the second FI
/*                   step 3           step 4          step 5          step 6          step 7          step 8          step 9          step 10         step 11         step 12         step 13         step 14         step 15 */
/*0x30 CLF      */  {FC,              IR,             0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x31 TXS      */  {MI,              PO|MI|PD,       XO|RI,          IR,             0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x32 ROR      */  {AR|BI|F1|FI,     BO|AI|FI,       IR,             0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x33 EOR i    */  {COH|MI,          COL|MI|CE,      RO|BI,          LXOR|LO|AI,     IR,             0,              0,              0,              0,              0,              0,              0,              0},
/*0x34 NOP      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x35 STX abs  */  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          XO|RI,          IR,             0,              0,              0,              0},
/*0x36 ROR abs  */  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          RO|AI,          AR|BI|F1|FI,    BO|RI|FI,       IR,             0,              0},
/*0x37 BNZ      */  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|CI|F1|FV,    BO|CI|F1|FV,    IR,             0,              0,              0,              0,              0},
/*                   step 3           step 4          step 5          step 6          step 7          step 8          step 9          step 10         step 11         step 12         step 13         step 14         step 15 */
/*0x38 STX zp   */  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          XO|RI,          IR,             0,              0,              0,              0,              0,              0},
/*0x39 ROR zp   */  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          RO|AI,          AR|BI|F1|FI,    BO|AI|FI,       IR,             0,              0,              0,              0},
/*0x3A EOR abs,x*/  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          EO|MI,          RO|BI,          LXOR|LO|AI|FI,  FI|IR,          0,              0,              0},
/*0x3B ROR abs,x*/  {COH|MI,          COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          EO|MI,          RO|AI,          AR|BI|F1|FI,    BO|RI|FI,       IR,             0,              0},
/*0x3C EOR zp,x */  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          RO|BI,          LXOR|LO|AI|FI,  FI|IR,          0,              0,              0,              0,              0},
/*0x3D ROR zp,x */  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          RO|AI,          AR|BI|F1|FI,    BO|AI|FI,       IR,             0,              0,              0,              0},
/*0x3E EOR(zp,x)*/  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          LXOR|LO|AI|FI}, //TODO: save a step to get the second FI
/*0x3F EOR(zp),x*/  {COH|MI,          COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          EO|MI,          LXOR|LO|AI|FI}, //TODO: save a step to get the second FI
/*                   step 3           step 4          step 5          step 6          step 7          step 8          step 9          step 10         step 11         step 12         step 13         step 14         step 15 */
/*0x40 CLI      */  {TC,              IR,             0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x41 PHA      */  {MI,              PO|MI|PD,       AO|RI,          IR,             0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x42 RTS      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x43 ORA i    */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x44 NOP      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x45 ADC abs  */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x46 JMP abs  */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x47 BMI      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*                   step 3           step 4          step 5          step 6          step 7          step 8          step 9          step 10         step 11         step 12         step 13         step 14         step 15 */
/*0x48 AND zp   */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x49 INC ZP   */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x4A ORA abs,x*/  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x4B NOP      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x4C ORA zp,x */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x4D NOP      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x4E ORA(zp,x)*/  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x4F ORA(zp),x*/  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*                   step 3           step 4          step 5          step 6          step 7          step 8          step 9          step 10         step 11         step 12         step 13         step 14         step 15 */
/*0x50 SEI      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x51 PHP      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x52 NOP      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x53 ADC i    */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x54 NOP      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x55 SBC abs  */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x56 JSR abs  */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x57 BPL      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*                   step 3           step 4          step 5          step 6          step 7          step 8          step 9          step 10         step 11         step 12         step 13         step 14         step 15 */
/*0x58 EOR zp   */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x59 DEC zp   */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x5A ADC abs,x*/  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x5B NOP      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x5C ADC zp,x */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x5D NOP      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x5E ADC(zp,x)*/  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x5F ADC(zp),x*/  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*                   step 3           step 4          step 5          step 6          step 7          step 8          step 9          step 10         step 11         step 12         step 13         step 14         step 15 */
/*0x60 INV      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x61 PLA      */  {MI,              PO|MI|PI,       RO|AI,          IR,             0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x62 NOP      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x63 ABC i    */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x64 NOP      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x65 CMP abs  */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x66 NOP      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x67 BEQ      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*                   step 3           step 4          step 5          step 6          step 7          step 8          step 9          step 10         step 11         step 12         step 13         step 14         step 15 */
/*0x68 ORA zp   */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x69 CMP zp   */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x6A SBC abs,x*/  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x6B NOP      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x6C SBC zp,x */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x6D NOP      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x6E SBC(zp,x)*/  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x6F SBC(zp),x*/  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*                   step 3           step 4          step 5          step 6          step 7          step 8          step 9          step 10         step 11         step 12         step 13         step 14         step 15 */
/*0x70 JMP      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x71 PLP      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x72 JTI      */  {MI,              COH|MI|PD,      0, /*TODO*/     0, /*NEED JV*/  0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x73 CMP i    */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x74 CPX i    */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x75 CPX abs  */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x76 NOP      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x77 BNE      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*                   step 3           step 4          step 5          step 6          step 7          step 8          step 9          step 10         step 11         step 12         step 13         step 14         step 15 */
/*0x78 NOP      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x79 CPX zp   */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x7A CMP abs,x*/  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x7B NOP      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x7C CMP zp,x */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x7D NOP      */  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x7E CMP(zp,x)*/  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0},
/*0x7F CMP(zp),x*/  {IR,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0}
/*                   step 3           step 4          step 5          step 6          step 7          step 8          step 9          step 10         step 11         step 12         step 13         step 14         step 15 */
};

long uinstr_table[128][13];

void init_uinstr_table() {
  memcpy(uinstr_table, uinstr_template, sizeof(uinstr_template));
}

void setup() {

  init_uinstr_table();
  
  Serial.begin(19200);
  
  pinMode(pin_instr0,         INPUT);
  pinMode(pin_instr1,         INPUT);
  pinMode(pin_instr2,         INPUT);
  pinMode(pin_instr3,         INPUT);
  pinMode(pin_instr4,         INPUT);
  pinMode(pin_instr5,         INPUT);
  pinMode(pin_instr6,         INPUT);
  pinMode(pin_instr7,         INPUT);

  if(!mcp0.begin_I2C() | !mcp1.begin_I2C()) {
    Serial.println("MCP initialization failure");
    while(true);
  }

  pinMode(pin_sysclockOut,    OUTPUT);
  pinMode(pin_sysclockMode,   OUTPUT);
  pinMode(pin_sysclockPulse,  OUTPUT);
  pinMode(pin_sysclockSpeed,  OUTPUT);

  //start clock low
  digitalWrite(pin_sysclockOut, 0);

  mcp0.pinMode(PEpin_Y0,      OUTPUT);
  mcp0.pinMode(PEpin_Y1,      OUTPUT);
  mcp0.pinMode(PEpin_Y2,      OUTPUT);
  mcp0.pinMode(PEpin_Z0,      OUTPUT);
  mcp0.pinMode(PEpin_Z1,      OUTPUT);
  mcp0.pinMode(PEpin_Z2,      OUTPUT);
  mcp0.pinMode(PEpin_FI,      OUTPUT);
  mcp0.pinMode(PEpin_FC,      OUTPUT);
  mcp0.pinMode(PEpin_L3,      OUTPUT);
  mcp0.pinMode(PEpin_L2,      OUTPUT);
  mcp0.pinMode(PEpin_L1,      OUTPUT);
  mcp0.pinMode(PEpin_L0,      OUTPUT);
  mcp0.pinMode(PEpin_LC,      OUTPUT);
  mcp0.pinMode(PEpin_LM,      OUTPUT);
  mcp0.pinMode(PEpin_ES,      OUTPUT);
  mcp0.pinMode(PEpin_IR,      OUTPUT);
    
  mcp1.pinMode(PEpin_PI,      OUTPUT);
  mcp1.pinMode(PEpin_PD,      OUTPUT);
  mcp1.pinMode(PEpin_DI,      OUTPUT);
  mcp1.pinMode(PEpin_CE,      OUTPUT);
  mcp1.pinMode(PEpin_CIH,     OUTPUT);
  mcp1.pinMode(PEpin_CIL,     OUTPUT);
  mcp1.pinMode(PEpin_COH,     OUTPUT);
  mcp1.pinMode(PEpin_COL,     OUTPUT);
  mcp1.pinMode(PEpin_data0,   INPUT);
  mcp1.pinMode(PEpin_data1,   INPUT);
  mcp1.pinMode(PEpin_data2,   INPUT);
  mcp1.pinMode(PEpin_data3,   INPUT);
  mcp1.pinMode(PEpin_data4,   INPUT);
  mcp1.pinMode(PEpin_data5,   INPUT);
  mcp1.pinMode(PEpin_data6,   INPUT);
  mcp1.pinMode(PEpin_data7,   INPUT);

  Serial.println("MCPs initialized");
}

void loop() {

  const  int  stablizationWait       = 10;
  static char stepCtr                = 0;
  static bool waitForPulse           = true;
  static bool busStabilized          = false;
  static int  busStabilizedTimer     = 0;
  static bool sysclockOut            = false;
  static int  nextClockTime          = 0;
  static bool programmingMode        = false;
         char instructionIn          = 0;
         char busValuesIn            = 0;
         bool autoMode               = digitalRead(pin_sysclockMode);
         bool autoSpeed              = digitalRead(pin_sysclockSpeed);
         bool pulseActive            = digitalRead(pin_sysclockPulse);
         int  currentMillis          = millis();

  //build instruction byte
  for(char i = 7; i >= 0; i--) {
    instructionIn = instructionIn & digitalRead(i + 2); //instruction pins start at 9 and go down to 2
    instructionIn = instructionIn << 1;
  }


  //if clock is currently low
  if (!sysclockOut) {
    //TODO: set outputs based on table
    /*
      if step = 0: COH|MI
      if step = 1: COL|MI
      if step = 2: RO|II|CE
      if step = 3-15: from table

      write mcp0 GPIOA (controller 0: Y0-FC)
      write mcp0 GPIOB (controller 1: L3-IR)
      write mcp1 GPIOA (controller 2: PI-COL)
        --I might have these reversed?--
        --I should probably only do this once rather than repeatedly while the clock is low--
    */
    
    //if auto:
    if (autoMode) {
    
    //  if we're in auto and we haven't run yet, wait for a pulse before we do anything
      if (waitForPulse) {
        waitForPulse = digitalRead(pin_sysclockPulse);
  
      } else {
        //if we've already started running, wait for time to pulse the clock high
        if (nextClockTime <= currentMillis) {
          nextClockTime = currentMillis + autoSpeed;
          sysclockOut = HIGH;
        }
      }

    //if manual:
    } else {
      if (digitalRead(pin_sysclockPulse)) {
        delay(debounce); //debounce
        sysclockOut = HIGH;
      }
    }

  //if clock is currently high
  } else {
    //if !butStabilized and busStabilizedTimer <= millis:
    if ((!busStabilized) && (busStabilizedTimer <= currentMillis)) {
      //print instruction (including flags)
      Serial.print(instructionIn, HEX);
      Serial.print("\t");
      
      //print current step number
      Serial.print(stepCtr, HEX);
      Serial.print("\t");
      
      //get current bus value & print
      busValuesIn = mcp1.readGPIOB();
      Serial.print(busValuesIn, HEX);
      Serial.print("\t");
      
      busStabilized = true;
    }
    
    if ((busStabilized) && (autoMode)) {
      if (nextClockTime <= currentMillis) {
        nextClockTime = currentMillis + autoSpeed;
        sysclockOut = LOW;
      }
    }

    if ((busStabilized) && (!autoMode)) {
      if (!digitalRead(pin_sysclockPulse)) {
        delay(debounce); //debounce
        sysclockOut = LOW;
      }
    }

  }

  digitalWrite(pin_sysclockOut, sysclockOut);
    
}
