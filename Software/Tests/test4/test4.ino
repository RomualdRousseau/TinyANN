#include "neurons.h"

HiddenNeuron myNeuron(-64, 0.985);

void setup()
{
  Debug.begin(9600);
  myNeuron.init();
  myNeuron.setTunings(256.0, 1024.0, 0.0);

  for(int i = 0; i < 100; i++)
  {
    Debug.println(myNeuron.fire(-48));
    delay(10);
  }

  for(int i = 0; i < 100; i++)
  {
    Debug.println(myNeuron.fire(-255));
    delay(10);
  }

  for(int i = 0; i < 100; i++)
  {
    Debug.println(myNeuron.fire(-48));
    delay(10);
  }
}

void loop()
{
  Debug.println(myNeuron.fire(-255));
  delay(10);
}

