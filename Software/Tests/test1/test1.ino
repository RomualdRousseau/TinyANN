#include "neurons.h"

SingleInputNeuron myNeuron(A1);

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

