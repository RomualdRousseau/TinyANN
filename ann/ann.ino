#include "neurons.h"

SingleInputNeuron   frontSensor(A1);
DualInputNeuron     sideSensor(A0, A2);
HiddenNeuron        frontController(THRESHOLD_DISABLE, DECAY_QUADRATIC);
HiddenNeuron        sideController(THRESHOLD_DISABLE, DECAY_QUADRATIC);
HiddenNeuron        randomController(THRESHOLD_ZERO, 0.98);
OutputNeuron        motor_R(4, 3, 2, THRESHOLD_DEFAULT);
OutputNeuron        motor_L(5, 6, 7, THRESHOLD_DEFAULT);

void callibrate()
{
  YAPIDAutotuner autotuner(500, YAPID_PID);
  int input = 0;
  int output = 0;
  float Kp, Ki, Kd;

  // Autotune front sensor/controller/motors
  motor_R.fire(255);
  motor_L.fire(255);
  delay(200);
  motor_R.fire(0);
  motor_L.fire(0);
  delay(5000);
  autotuner.begin();
  while (autotuner.runtime(input, output))
  {
    input = frontSensor.fire();
    output = input >= 0 ? 255 : -255;
    motor_R.fire(output);
    motor_L.fire(output);
#ifdef DEBUG
    Debug.println(input);
#endif
    delay(10);
  }
  autotuner.end(&Kp, &Ki, &Kd);
  motor_R.fire(0);
  motor_L.fire(0);
  delay(10);
  frontController.setTunings(Kp, Ki, Kd);

  // Autotune side sensor/controller/motors
  motor_R.fire(-255);
  motor_L.fire(255);
  delay(200);
  motor_R.fire(0);
  motor_L.fire(0);
  delay(1000);
  autotuner.begin();
  while (autotuner.runtime(input, output))
  {
    input = sideSensor.fire();
    output = input >= 0 ? 255 : -255;
    motor_R.fire(output);
    motor_L.fire(-output);
#ifdef DEBUG
    Debug.println(input);
#endif
    delay(10);
  }
  autotuner.end(&Kp, &Ki, &Kd);
  motor_R.fire(0);
  motor_L.fire(0);
  delay(10);
  sideController.setTunings(Kp, Ki, Kd);
}

void setup()
{
  int j = 0;
  
#ifdef DEBUG
  Debug.begin(9600);
#endif

  frontSensor.init();
  sideSensor.init();
  frontController.init();
  sideController.init();
  randomController.init();
  motor_R.init();
  motor_L.init();

#ifdef CALLIBRATE
  callibrate();
  j += frontController.saveToMemory(j);
  j += sideController.saveToMemory(j);
#else
  randomController.setTunings(256.0, 1024.0, 0.0);
  j += frontController.loadFromMemory(j);
  j += sideController.loadFromMemory(j);
#endif

  // Little dance when ready
  motor_R.fire(255);
  motor_L.fire(-255);
  delay(500);
  motor_R.fire(-255);
  motor_L.fire(255);
  delay(1000);
  motor_R.fire(255);
  motor_L.fire(-255);
  delay(500);
  motor_R.fire(0);
  motor_L.fire(0);
  delay(10);
}

void loop()
{
#if defined(DEBUG_FRONT_SENSOR) // Front network
  int w1 = 1;
  int w2 = 0;
  int w3 = 0;
  int w4 = 1;
  int w5 = 0;
  int w6 = 0;
  int w7 = 1;
  int w8 = 0;
  int w9 = 0;
#elif defined(DEBUG_SIDE_SENSOR) // Side network
  int w1 = 0;
  int w2 = 1;
  int w3 = 0;
  int w4 = 0;
  int w5 = 1;
  int w6 = 0;
  int w7 = 0;
  int w8 = -1;
  int w9 = 0;
#elif defined(DEBUG_RANDOM_SENSOR) // Random network
  int w1 = 0;
  int w2 = 0;
  int w3 = -1;
  int w4 = 0;
  int w5 = 0;
  int w6 = -2;
  int w7 = 0;
  int w8 = 0;
  int w9 = 2;
#elif defined(CALLIBRATE) // Sum Front and side networks
  int w1 = 1;
  int w2 = 1;
  int w3 = 0;
  int w4 = 1;
  int w5 = 1;
  int w6 = 0;
  int w7 = 1;
  int w8 = -1;
  int w9 = 0;
#else // Sum all networks (Front + Side + Random)
  int w1 = 1;
  int w2 = 1;
  int w3 = -1;
  int w4 = 1;
  int w5 = 1;
  int w6 = -2;
  int w7 = 1;
  int w8 = -1;
  int w9 = 2;
#endif

  int x1 = frontSensor.fire();
  int x2 = sideSensor.fire();
  int x3 = frontController.fire(w1 * x1);
  int x4 = sideController.fire(w2 * x2);
  int x5 = randomController.fire(w3 * x3);
  motor_R.fire(w4 * x3 + w5 * x4 + w6 * x5);
  motor_L.fire(w7 * x3 + w8 * x4 + w9 * x5);

#ifdef DEBUG
  Debug.println(w4 * x3 + w5 * x4 + w6 * x5);
#endif

  delay(10);
}

