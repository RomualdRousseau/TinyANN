#include "neurons.h"

#define SPEED 255

OuputNeuron myNeuronR(4, 3, 2, 64);
OuputNeuron myNeuronL(5, 6, 7, 64);

void setup()
{
  Debug.begin(9600);
  
  myNeuronR.init();
  myNeuronL.init();

  Debug.println("forward");
  myNeuronR.fire(SPEED);
  myNeuronL.fire(SPEED);
  delay(500);
  myNeuronR.fire(0);
  myNeuronL.fire(0);

  Debug.println("backward");
  myNeuronR.fire(-SPEED);
  myNeuronL.fire(-SPEED);
  delay(500);
  myNeuronR.fire(0);
  myNeuronL.fire(0);

  Debug.println("left");
  myNeuronR.fire(SPEED);
  myNeuronL.fire(-SPEED);
  delay(500);
  myNeuronR.fire(0);
  myNeuronL.fire(0);

  Debug.println("right");
  myNeuronR.fire(-SPEED);
  myNeuronL.fire(SPEED);
  delay(500);
  myNeuronR.fire(0);
  myNeuronL.fire(0);
  
  Debug.println("end.");
}

void loop()
{
}
