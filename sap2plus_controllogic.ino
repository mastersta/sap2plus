#include <Adafruit_MCP23X17.h>
#include <Adafruit_MCP23XXX.h>

#define stabilization      10  //how long to wait for bus stabilization



//MCP23017 stand-ins for control EEPROMS
Adafruit_MCP23X17 mcp0;
Adafruit_MCP23X17 mcp1;


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
  mcp0.pinMode(PEpin_T0,      OUTPUT);
  mcp0.pinMode(PEpin_T1,      OUTPUT);
  mcp0.pinMode(PEpin_T2,      OUTPUT);
  mcp0.pinMode(PEpin_PI,      OUTPUT);
  mcp0.pinMode(PEpin_PD,      OUTPUT);
  mcp0.pinMode(PEpin_TC,      OUTPUT);
  mcp0.pinMode(PEpin_JU,      OUTPUT);
  mcp0.pinMode(PEpin_FV,      OUTPUT);
  mcp0.pinMode(PEpin_F1,      OUTPUT);
  mcp0.pinMode(PEpin_F2,      OUTPUT);
    
  mcp1.pinMode(PEpin_FL,      OUTPUT);
  mcp1.pinMode(PEpin_L3,      OUTPUT);
  mcp1.pinMode(PEpin_L2,      OUTPUT);
  mcp1.pinMode(PEpin_L1,      OUTPUT);
  mcp1.pinMode(PEpin_L0,      OUTPUT);
  mcp1.pinMode(PEpin_LC,      OUTPUT);
  mcp1.pinMode(PEpin_LM,      OUTPUT);
  mcp1.pinMode(PEpin_ES,      OUTPUT);
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



  /*
  Sets mcp outputs based on provided instruction
  */
void setOutputs(uint8_t instruction, uint8_t step) {

  uint32_t outputLong = 0;

  switch(step) {

    case 0:
      outputLong = COH|MI;
      break;

    case 1:
      outputLong = COL|MI;
      break;

    case 2:
      if(instruction > 0) {
        outputLong = RO|II|CE;
      } else {
        outputLong = RO;
      }
      break;

    case 3:
    case 4:
    case 5:
    case 6:
    case 7:
    case 8:
    case 9:
    case 10:
    case 11:
    case 12:
    case 13:
    case 14:
    case 15:
      outputLong = uinstr_table[instruction][step - 3];
  }

  uint8_t output0 = outputLong;
  uint8_t output1 = outputLong >> 8;
  uint8_t output2 = outputLong >> 16;

  mcp0.writeGPIOA(output0);
  mcp0.writeGPIOB(output1);
  mcp1.writeGPIOA(output2);

}

//function to increment and wrap
uint8_t incrementWrap (uint8_t inputVal, uint8_t wrap) { return (inputVal++) & wrap; };


//function to print current instruction, step, and bus values to serial
void printCPUState(uint8_t instruction, uint8_t step) {

  uint8_t busValue = mcp1.readGPIOB();

  Serial.print(instruction, HEX);
  Serial.print("\t");

  Serial.print(step, DEC);
  Serial.print("\t");

  Serial.println(busValue, HEX);
}


//function to get current instruction
uint8_t getInstruction () {
  uint8_t instructionOut = 0;

  instructionOut = instructionIn | digitalRead(pin_instr0);
  instructionOut = instructionIn | (digitalRead(pin_instr1) * 0x02);
  instructionOut = instructionIn | (digitalRead(pin_instr2) * 0x04);
  instructionOut = instructionIn | (digitalRead(pin_instr3) * 0x08);
  instructionOut = instructionIn | (digitalRead(pin_instr4) * 0x0F);
  instructionOut = instructionIn | (digitalRead(pin_instr5) * 0x20);
  instructionOut = instructionIn | (digitalRead(pin_instr6) * 0x40);
  instructionOut = instructionIn | (digitalRead(pin_instr7) * 0x80);

  return instructionOut;
}


void loop() {

  static uint8_t   runMode             = 0;
  static uint8_t   stepCtr             = 0;
  static bool      clockOut            = 0;
         uint8_t   instructionIn       = getInstruction();
         bool      clockMode           = digitalRead(pin_sysclockMode);
         bool      clockPulse          = digitalRead(pin_sysclockPulse);
         int       clockSpeed          = digitalRead(pin_sysclockSpeed);
         uint32_t  currentMillis       = millis();
  static uint32_t  busStabilizedTime   = (currentMillis + stabilization);
  static uint32_t  nextTransition      = (currentMillis + stabilization + clockSpeed);
  static bool      outputsSetFlag      = false;
  static bool      printFlag           = false;
         char      serCommand[4]       = 0;
         uint8_t   serData[16]         = 0;



  if(runMode < 2) {
    if(clockMode) { set runMode to 2; }

  } else if(runMode == 2 || runMode == 3) {
    if(!clockMode) { set runMode to 0; }

  }



  switch(runMode) {

    /*-----CLOCK MANUAL, LOW-----
      Sets clock low
      Sets outputs on first pass
      Exits if pulse pin is pressed
    */
    case 0:
      clockOut = 0;

      if(!outputsSetFlag) {
        stepCtr = incrementWrap(stepCtr, 0xF);
        setOutputs(instructionIn, stepCtr);
        outputsSetFlag = true;
      }

      serCommand = Serial.read();

      if(clockPulse) { runMode = 1; }
      break;



    /*-----CLOCK MANUAL, HIGH-----
      Sets clock high
      Outputs CPU state to serial
      Exits if pulse pin is released
    */
    case 1:
      clockOut = 1;

      if((currentMillis > busStabilizedTime) && !printFlag) {
        printCPUState();
        printFlag = true;
      }

      if(!clockPulse) {
        runMode = 0;
        outputsSetFlag = false;
      }
      break;



    /*-----CLOCK AUTO, WAITING FOR RUN-----
      Sets clock low
      Exits if pulse pin is pressed
    */
    case 2:
      clockOut = 0;

      if(clockPulse) { runMode = 3; }
      break;



    /*-----CLOCK AUTO, LOW-----
      Sets clock low
      Sets outputs on first pass
      Exits when time for clock high transition
    */
    case 3:
      clockOut = 0;

      if(!outputsSetFlag) {
        stepCtr = incrementWrap(stepCtr, 0xF);
        setOutputs(instructionIn, stepCtr);
        outputsSetFlag = true;
      }

      if(currentMillis > nextTransition) {
        nextTransition = currentMillis + clockSpeed;
        runMode = 4;
      }
      break;



    /*-----CLOCK AUTO, HIGH-----
      Sets clock high
      Outputs CPU state to serial
      Exits when time for clock low transition
    */
    case 4:
      clockOut = 1;
      
      if((currentMillis > busStabilizedTime) && !printFlag) {
        printCPUState();
        printFlag = true;
      }

      if(currentMillis > nextTransition) {
        nextTransition = currentMillis + clockSpeed;
        runMode = 3;
      }

      break;



    /*-----PROGRAMMING MODE, WAITING FOR DATA-----
      Entered when PROG sent via serial, only available in modes 0 or 2
      Sets clock low
      Waits for 2 hex byte address and 16 hex byte data from serial monitor
      Moves to mode 6 to write data at address
      Exits when instruction and all 16 bytes have been received
    */
    case 5:



    /*-----PROGRAMMING MODE, WRITE DATA-----
      Pulses clock twice while outputting address to MAR
      Pulses clock 16 times while writing data to RAM
      Returns to mode 5 when complete
    */
    case 6:



    /*-----ROM READ MODE-----
      Activates on RORD command from serial
      Loops through entire ROM and outputs to serial
    */
    case 7:


    /*-----RAM READ MODE-----
      Activates on RARD command from serial
      Loops through entire RAM and outputs to serial
    */
    case 8:

  }


  digitalWrite(pin_sysclockOut, clockOut);
}
