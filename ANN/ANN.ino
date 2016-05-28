#include "global.h"

int w[11] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
int x[7] = {0, 0, 0, 0, 0, 0, 0};
  
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

#ifdef ENABLE_JOYSTICK
  joystick.init();  
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

#if defined(DEBUG_FRONT_SENSOR) // Front network
  w[0] = 0;
  w[1] = 1;
  w[2] = 0;
  w[3] = 0;
  w[4] = 0;
  w[5] = 1;
  w[6] = 0;
  w[7] = 0;
  w[8] = 1;
  w[9] = 0;
  w[10] = 0;
#elif defined(DEBUG_SIDE_SENSOR) // Side network
  w[0] = 0;
  w[1] = 0;
  w[2] = 0;
  w[3] = 1;
  w[4] = 0;
  w[5] = 0;
  w[6] = 1;
  w[7] = 0;
  w[8] = 0;
  w[9] = -1;
  w[10] = 0;
#elif defined(DEBUG_RANDOM_SENSOR) // Random network
  w[0] = 0;
  w[1] = 0;
  w[2] = 0;
  w[3] = 0;
  w[4] = -1;
  w[5] = 0;
  w[6] = 0;
  w[7] = -2;
  w[8] = 0;
  w[9] = 0;
  w[10] = 2;
#elif defined(CALLIBRATE) // Sum Front and side networks
  w[0] = 0;
  w[1] = 1;
  w[2] = 0;
  w[3] = 1;
  w[4] = 0;
  w[5] = 1;
  w[6] = 1;
  w[7] = 0;
  w[8] = 1;
  w[9] = -1;
  w[10] = 0;
#elif defined(ENABLE_JOYSTICK) // Sum all networks (Front + Side + Joystick)
  w[0] = 0;
  w[1] = 1;
  w[2] = 0;
  w[3] = 1;
  w[4] = 0;
  w[5] = 1;
  w[6] = 1;
  w[7] = 0;
  w[8] = 1;
  w[9] = -1;
  w[10] = 0;
#else // Sum all networks (Front + Side + Random)
  w[0] = 0;
  w[1] = 1;
  w[2] = 0;
  w[3] = 1;
  w[4] = -1;
  w[5] = 1;
  w[6] = 1;
  w[7] = -2;
  w[8] = 1;
  w[9] = -1;
  w[10] = 2;
#endif

  // Little dance when ready
  motor_R.fire(255);
  motor_L.fire(-255);
  delay(250);
  motor_R.fire(-255);
  motor_L.fire(255);
  delay(500);
  motor_R.fire(255);
  motor_L.fire(-255);
  delay(250);
  motor_R.fire(0);
  motor_L.fire(0);
  delay(10);
}

void loop()
{
#ifdef ENABLE_JOYSTICK
  if(joystick.ready())
  {
    x[0] = joystick.Y;
    x[1] = joystick.X;
  }
  if(joystick.ModeAuto)
  {
    w[0] = 0;
    w[1] = 1;
    w[2] = 0;
    w[3] = 1;
  }
  else
  {
    w[0] = 1;
    w[1] = 0;
    w[2] = -1;
    w[3] = 0;
  }
#endif

  x[2] = frontSensor.fire();
  x[3] = sideSensor.fire();
  x[4]= frontController.fire(w[0] * x[0] + w[1] * x[2]);
  x[5] = sideController.fire(w[2] * x[1] + w[3] * x[3]);
  x[6] = randomController.fire(w[4] * x[4]);

  motor_R.fire(w[5] * x[4] + w[6] * x[5] + w[7] * x[6]);
  motor_L.fire(w[8] * x[4] + w[9] * x[5] + w[10] * x[6]);

#ifdef DEBUG
  Debug.print(x[2]);
  Debug.print(',');
  Debug.print(x[3]);
  Debug.print(',');
  Debug.println(w[5] * x[4] + w[6] * x[5] + w[7] * x[6]);
#endif

  delay(5);
}

