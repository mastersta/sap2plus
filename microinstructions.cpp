/*
  instruction mnemonic definitions
*/

//input decoder (controller 0)
#define II                 0x200000
#define MI                 0x400000
#define RI                 0x600000
#define AI                 0x800000
#define BI                 0xA00000
#define XI                 0xC00000
#define CI                 0xE00000

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
#define COH                0x010000
#define COL                0x018000
#define FI                 0x020000
#define TD                 0x028000
#define ZI                 0x030000
#define ZO                 0x038000

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
#define LDEC               0x00007C
#define LSHL               0x000064
#define LNEG               0x000062
#define LAND               0x00005A
#define BO                 0x000052
#define LXOR               0x000032
#define LSUB               0x000030
#define LZRO               0x00001A
#define LORA               0x00000C
#define LADD               0x000008
#define AO                 0x000004
#define LNOT               0x000002

//active-low inputs for each controller, to be xor'd later
#define ctrl0_bar          0b00000000
#define ctrl1_bar          0b01101000
#define ctrl2_bar          0b00000000

/*========================================
  instruction microcode
  step 0: COH|MI
  step 1: COL|MI
  step 2: RO|II|CE
  steps 3-15 follow:
========================================*/

/* JTI: push PC to stack, get 8000 and 8001 into PC, jump */
const long uinstr_template[128][13] PROGMEM {

/*                step 3          step 4          step 5          step 6          step 7          step 8          step 9          step A          step B          step C          step D          step E          step F          */
/*00 INI      */ {TD|CI|JU,       LZRO|LO|CI|JU,  RO|CE,          RO|CE,          COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI,         RO|CI|JU,       BO|CI|JU|TC,    0,              0               },
/*01 NOP      */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*02 CLC      */ {FO|BI,          AO|ZI,          AI,             LNOT|LO|AI,     LAND|LO|FI,     0,              0,              0,              0,              0,              0,              0,              0               },
/*03 CLF      */ {LZRO|LO|FI,     0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*04 CLI      */ {TC,             0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*05 SEI      */ {TD,             0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*06 RTS      */ {MI|PI,          PO|MI,          RO|CI|JU,       MI|CE|PI,       PO|MI,          RO|CI|JU,       RO|CE,          RO|CE,          0,              0,              0,              0,              0               },
/*07 JTI      */ {MI,             PO|MI|PD,       COL|RI,         MI,             PO|MI|PD,       COH|RI,         TD|MI,          LZRO|LO|MI,     RO|BI,          TD|MI,          MI,             RO|CI|JU,       BO|CI|JU|TC     },
/*                step 3          step 4          step 5          step 6          step 7          step 8          step 9          step A        step B            step C          step D          step E          step F          */
/*08 RTI      */ {PI|MI,          PO|MI,          RO|CI,          PI|MI,          PO|MI,          RO|CI|TC,       0,              0,              0,              0,              0,              0,              0               },
/*09          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*0a PHA      */ {MI,             PO|MI|PD,       AO|RI,          0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*0b PLA      */ {MI|PI,          PO|MI,          RO|AI,          0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*0c TXS      */ {MI,             PO|MI|PD,       XO|RI,          0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*0d TSX      */ {MI|PI,          PO|MI,          RO|XI,          0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*0e PHP      */ {MI,             PO|MI|PD,       FO|RI,          0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*0f PLP      */ {MI|PI,          PO|MI,          RO|FL,          0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*                step 3          step 4          step 5          step 6          step 7          step 8          step 9          step A        step B            step C          step D          step E          step F          */
/*10          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*11 TAX      */ {AO|XI,          0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*12          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*13 TXA      */ {XO|AI,          0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*14          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*15          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*16 INV      */ {LNOT|LO|AI,     0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*17          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*                step 3          step 4          step 5          step 6          step 7          step 8          step 9          step A        step B            step C          step D          step E          step F          */
/*18          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*19          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*1a          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*1b          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*1c INX      */ {BI,             EO|XI,          0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*1d DEX      */ {BI,             ES|EO|XI,       0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*1e ROL      */ {LSHL|LO|AI|FI,  FI,             0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*1f ROR      */ {AR|BI|FI,       BO|AI|FI,       0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*                step 3          step 4          step 5          step 6          step 7          step 8          step 9          step A        step B            step C          step D          step E          step F          */
/*20 LDA i    */ {COH|MI,         COL|MI|CE,      RO|AI,          0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*21 LDX i    */ {COH|MI,         COL|MI|CE,      RO|XI,          0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*22          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*23          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*24 AND i    */ {COH|MI,         COL|MI|CE,      RO|BI,          LAND|LO|AI|FI,  FI|RO,          0,              0,              0,              0,              0,              0,              0,              0               },
/*25 ORA i    */ {COH|MI,         COL|MI|CE,      RO|BI,          LORA|LO|AI|FI,  FI|RO,          0,              0,              0,              0,              0,              0,              0,              0               },
/*26 EOR i    */ {COH|MI,         COL|MI|CE,      RO|BI,          LXOR|LO|AI|FI,  FI|RO,          0,              0,              0,              0,              0,              0,              0,              0               },
/*27          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*                step 3          step 4          step 5          step 6          step 7          step 8          step 9          step A        step B            step C          step D          step E          step F          */
/*28 ADC i    */ {COH|MI,         COL|MI|CE,      RO|BI,          LADD|LO|AI|FI,  FI,             0,              0,              0,              0,              0,              0,              0,              0               },
/*29 SBC i    */ {COH|MI,         COL|MI|CE,      RO|BI,          LSUB|LO|AI|FI,  FI,             0,              0,              0,              0,              0,              0,              0,              0               },
/*2a CMP i    */ {COH|MI,         COL|MI|CE,      AO|ZI,          RO|BI,          LSUB|LC|LO|AI|FI,  ZO|AI|FI,    0,              0,              0,              0,              0,              0,              0               },
/*2b CPX i    */ {COH|MI,         COL|MI|CE,      RO|BI,          AO|ZI,          XO|AI,          LSUB|LC|LO|AI|FI,  AO|XI|FI,    FI|RO,          0,              0,              0,              0,              0               },
/*2c          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*2d          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*2e          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*2f          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*                step 3          step 4          step 5          step 6          step 7          step 8          step 9          step A        step B            step C          step D          step E          step F          */
/*30 LDA abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          RO|AI,          0,              0,              0,              0,              0               },
/*31 LDX abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          RO|XI,          0,              0,              0,              0,              0               },
/*32 STA abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          AO|RI,          0,              0,              0,              0,              0               },
/*33 STX abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          XO|RI,          0,              0,              0,              0,              0               },
/*34 AND abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          RO|BI,          LAND|LO|AI|FI,  FI|RO,          0,              0,              0               },
/*35 ORA abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          RO|BI,          LORA|LO|AI|FI,  FI|RO,          0,              0,              0               },
/*36 EOR abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          RO|BI,          LXOR|LO|AI|FI,  FI|RO,          0,              0,              0               },
/*37          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*                step 3          step 4          step 5          step 6          step 7          step 8          step 9          step A        step B            step C          step D          step E          step F          */
/*38 ADC abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          RO|BI,          LADD|LO|AI|FI,  FI|RO,          0,              0,              0               },
/*39 SBC abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          RO|BI,          LSUB|LO|AI|FI,  FI|RO,          0,              0,              0               },
/*3a CMP abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          RO|BI,          AO|ZI,          LSUB|LC|LO|AI|FI,  ZO|AI|FI,    0,              0               },
/*3b CPX abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          RO|BI,          AO|ZI,          XO|AI,          LSUB|LC|LO|AI|  FI,AO|XI|FI,    ZO|AI           },
/*3c INC abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          AO|ZI,          RO|AI,          BI,             LADD|LC|LO|AI|FI,  FI|AO|RI,    ZO|AI           },
/*3d DEC abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          AO|BI,          RO|AI,          LDEC|LC|LO|AI|FI,  FI|AO|RI,    BO|AI,          0               },
/*3e ROL abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          AO|BI,          RO|AI,          LSHL|LO|AI|FI,  AO|RI|FI,       BO|AI,          0               },
/*3f ROR abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          BO|MI,          AO|BI,          RO|AI,          AR|RI|FI,       BO|AI|FI,       0,              0               },
/*                step 3          step 4          step 5          step 6          step 7          step 8          step 9          step A        step B            step C          step D          step E          step F          */
/*40 JMP abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|CI|JU,       BO|CI|JU,       0,              0,              0,              0,              0,              0               },
/*41 JSR abs  */ {MI,             PO|MI|PD,       COL|RI,         MI,             PO|MI|PD,       COH|RI,         COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|CI|JU,       BO|CI|JU        },
/*42 BCS abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|CI,          BO|CI|JU,       0,              0,              0,              0,              0,              0               },
/*43 BCC abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|CI|FV,       BO|CI|JU,       0,              0,              0,              0,              0,              0               },
/*44 BEZ abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|CI|F1,       BO|CI|JU,       0,              0,              0,              0,              0,              0               },
/*45 BNZ abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|CI|F1|FV,    BO|CI|JU,       0,              0,              0,              0,              0,              0               },
/*46 BEQ abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|CI|F2,       BO|CI|JU,       0,              0,              0,              0,              0,              0               },
/*47 BNE abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|CI|F2|FV,    BO|CI|JU,       0,              0,              0,              0,              0,              0               },
/*                step 3          step 4          step 5          step 6          step 7          step 8          step 9          step A        step B            step C          step D          step E          step F          */
/*48 BMI abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|CI|F1|F2,    BO|CI|JU,       0,              0,              0,              0,              0,              0               },
/*49 BPL abs  */ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|CI|F1|F2|FV, BO|CI|JU,       0,              0,              0,              0,              0,              0               },
/*4a JMP (zp) */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          RO|ZI,          XI,             LZRO|LO|MI,     EO|MI,          RO|CI|JU,       ZO|CI|JU,       0,              0               },
/*4b          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*4c          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*4d          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*4e          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*4f          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*                step 3          step 4          step 5          step 6          step 7          step 8          step 9          step A        step B            step C          step D          step E          step F          */
/*50 LDA zp   */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          RO|AI,          0,              0,              0,              0,              0,              0,              0               },
/*51 LDX zp   */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          RO|XI,          0,              0,              0,              0,              0,              0,              0               },
/*52 STA zp   */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          AO|RI,          0,              0,              0,              0,              0,              0,              0               },
/*53 STX zp   */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          XO|RI,          0,              0,              0,              0,              0,              0,              0               },
/*54 AND zp   */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          RO|BI,          LAND|LO|AI|FI,  FI|RO,          0,              0,              0,              0,              0               },
/*55 ORA zp   */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          RO|BI,          LORA|LO|AI|FI,  FI|RO,          0,              0,              0,              0,              0               },
/*56 EOR zp   */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          RO|BI,          LXOR|LO|AI|FI,  FI|RO,          0,              0,              0,              0,              0               },
/*57     zp   */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*                step 3          step 4          step 5          step 6          step 7          step 8          step 9          step A        step B            step C          step D          step E          step F          */
/*58 ADC zp   */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          RO|BI,          LADD|LO|AI|FI,  FI|RO,          0,              0,              0,              0,              0               },
/*59 SBC zp   */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          RO|BI,          LSUB|LO|AI|FI,  FI|RO,          0,              0,              0,              0,              0               },
/*5a CMP zp   */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          RO|BI,          AO|ZI,          LSUB|LC|LO|AI|FI,  ZO|AI|FI,    0,              0,              0,              0               },
/*5b CPX zp   */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          RO|BI,          AO|ZI,          XO|AI,          LSUB|LC|LO|AI|  FI,AO|XI|FI,    ZO|AI,          0,              0               },
/*5c INC zp   */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          AO|ZI,          RO|AI,          BI,             LADD|LC|LO|AI|FI,  FI|AO|RI,    ZO|AI,          0,              0               },
/*5d DEC zp   */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          AO|BI,          RO|AI,          LDEC|LC|LO|AI|FI,  FI|AO|RI,    BO|AI,          0,              0,              0               },
/*5e ROL zp   */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          AO|BI,          RO|AI,          LSHL|LO|AI|FI,  AO|RI|FI,       BO|AI,          0,              0,              0               },
/*5f ROR zp   */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     BO|MI,          AO|BI,          RO|AI,          AR|RI|FI,       BO|AI|FI,       0,              0,              0,              0               },
/*                step 3          step 4          step 5          step 6          step 7          step 8          step 9          step A        step B            step C          step D          step E          step F          */
/*60 LDA abs,x*/ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CI,      RO|MI,          EO|MI,          RO|AI,          0,              0,              0,              0,              0               },
/*61          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*62 STA abs,x*/ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CI,      RO|MI,          EO|MI,          AO|RI,          0,              0,              0,              0,              0               },
/*63          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*64 AND abs,x*/ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CI,      RO|MI,          EO|MI,          RO|BI,          LAND|LO|AI|FI,  FI|RO,          0,              0,              0               },
/*65 ORA abs,x*/ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CI,      RO|MI,          EO|MI,          RO|BI,          LORA|LO|AI|FI,  FI|RO,          0,              0,              0               },
/*66 EOR abs,x*/ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CI,      RO|MI,          EO|MI,          RO|BI,          LXOR|LO|AI|FI,  FI|RO,          0,              0,              0               },
/*67          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*                step 3          step 4          step 5          step 6          step 7          step 8          step 9          step A        step B            step C          step D          step E          step F          */
/*68 ADC abs,x*/ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CI,      RO|MI,          EO|MI,          RO|BI,          LADD|LO|AI|FI,  FI|RO,          0,              0,              0               },
/*69 SBC abs,x*/ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CI,      RO|MI,          EO|MI,          RO|BI,          LSUB|LO|AI|FI,  FI|RO,          0,              0,              0               },
/*6a CMP abs,x*/ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          EO|MI,          RO|BI,          AO|ZI,          LSUB|LC|LO|AI|FI,  ZO|AI|FI,    0,              0               },
/*6b          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*6c INC abs,x*/ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          EO|MI,          AO|ZI,          RO|AI,          BI,             LADD|LC|LO|AI|FI,  FI|AO|RI,    ZO|AI           },
/*6d DEC abs,x*/ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CI,      RO|MI,          EO|MI,          AO|BI,          RO|AI,          LDEC|LC|LO|AI|FI,  FI|AO|RI,    BO|AI,          0               },
/*6e ROL abs,x*/ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          EO|MI,          AO|BI,          RO|AI,          LSHL|LO|AI|FI,  AO|RI|FI,       BO|AI,          0               },
/*6f ROR abs,x*/ {COH|MI,         COL|MI|CE,      RO|BI,          COH|MI,         COL|MI|CE,      RO|MI,          EO|MI,          AO|BI,          RO|AI,          AR|RI|FI,       BO|AI|FI,       0,              0               },
/*                step 3          step 4          step 5          step 6          step 7          step 8          step 9          step A        step B            step C          step D          step E          step F          */
/*70 LDA zp,x */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          RO|AI,          0,              0,              0,              0,              0,              0,              0               },
/*71          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*72 STA zp,x */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          AO|RI,          0,              0,              0,              0,              0,              0,              0               },
/*73          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*74 AND zp,x */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          RO|BI,          LAND|LO|AI|FI,  FI|RO,          0,              0,              0,              0,              0               },
/*75 ORA zp,x */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          RO|BI,          LORA|LO|AI|FI,  FI|RO,          0,              0,              0,              0,              0               },
/*76 EOR zp,x */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          RO|BI,          LXOR|LO|AI|FI,  FI|RO,          0,              0,              0,              0,              0               },
/*77          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*                step 3          step 4          step 5          step 6          step 7          step 8          step 9          step A        step B            step C          step D          step E          step F          */
/*78 ADC zp,x */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          RO|BI,          LADD|LO|AI|FI,  FI|RO,          0,              0,              0,              0,              0               },
/*79 SBC zp,x */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          RO|BI,          LSUB|LO|AI|FI,  FI|RO,          0,              0,              0,              0,              0               },
/*7a CMP zp,x */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          RO|BI,          AO|ZI,          LSUB|LC|LO|AI|FI,  ZO|AI|FI,    0,              0,              0,              0               },
/*7b          */ {0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0,              0               },
/*7c INC zp,x */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          AO|ZI,          RO|AI,          BI,             LADD|LC|LO|AI|FI,  FI|AO|RI,    ZO|AI           0,              0               },
/*7d DEC zp,x */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          AO|BI,          RO|AI,          LDEC|LC|LO|AI|FI,  FI|AO|RI,    BO|AI,          0,              0,              0               },
/*7e ROL zp,x */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          AO|BI,          RO|AI,          LSHL|LO|AI|FI,  AO|RI|FI,       BO|AI,          0,              0,              0               },
/*7f ROR zp,x */ {COH|MI,         COL|MI|CE,      RO|BI,          LZRO|LO|MI,     EO|MI,          AO|BI,          RO|AI,          AR|RI|FI,       BO|AI|FI,       0,              0,              0,              0               },

};
