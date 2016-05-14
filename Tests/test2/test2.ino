#include "neurons.h"

DualInputNeuron myNeuron(A0, A2);

void setup()
{
  Debug.begin(9600);
  myNeuron.init();
}

void loop()
{
  Debug.println(myNeuron.fire());
  delay(10);
}

