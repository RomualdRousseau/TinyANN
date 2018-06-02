#include <SoftwareSerial.h>
#include <EEPROMEX.h>
#include <YAPID.h>

#include "config.h"

#ifdef DEBUG
SoftwareSerial Debug(0, 1);
#undef ENABLE_JOYSTICK
#endif

#ifdef CALLIBRATE
#undef ENABLE_JOYSTICK
#endif

#include "neurons.h"
#include "joystick.h"

#ifdef ENABLE_JOYSTICK
Joystick            joystick;  
#endif

SingleInputNeuron   frontSensor(A1);
DualInputNeuron     sideSensor(A0, A2);
HiddenNeuron        frontController(THRESHOLD_DISABLE, DECAY_QUADRATIC);
HiddenNeuron        sideController(THRESHOLD_DISABLE, DECAY_QUADRATIC);
HiddenNeuron        randomController(THRESHOLD_ZERO, 0.98);
OutputNeuron        motor_R(4, 3, 2, THRESHOLD_DEFAULT);
OutputNeuron        motor_L(5, 6, 7, THRESHOLD_DEFAULT);

