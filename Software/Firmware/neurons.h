#define THRESHOLD_ZERO      0
#define THRESHOLD_DEFAULT   32
#define THRESHOLD_DISABLE   -32768

class SingleInputNeuron
{
  public:
    SingleInputNeuron(int a):
      m_pin(a)
    {
      m_val = 0;
      m_lim = 0;
    }

    void init()
    {
      pinMode(m_pin, INPUT);

      for (int i = 0; i < 100; i++)
      {
        fire();
        delay(10);
      }
      m_lim = m_val * 50 / 100;
    }

    int fire()
    {
      m_val = (m_val * 3 + analogRead(m_pin)) / 4;
      int a = m_val - m_lim;
      return abs(a) < 100 ? 0 : a;
    }

  private:
    const int m_pin;
    int m_val;
    int m_lim;
};

class DualInputNeuron
{
  public:
    DualInputNeuron(int a, int b):
      m_pinR(a),
      m_pinL(b)
    {
      m_valR = 0;
      m_valL = 0;
      m_delta = 0;
    }

    void init()
    {
      pinMode(m_pinR, INPUT);
      pinMode(m_pinL, INPUT);

      for (int i = 0; i < 100; i++)
      {
        fire();
        delay(10);
      }
      m_delta = m_valR - m_valL;
    }

    int fire()
    {
      m_valR = (m_valR * 3 + analogRead(m_pinR)) / 4;
      m_valL = (m_valL * 3 + analogRead(m_pinL)) / 4;
      int a = m_valR - m_valL - m_delta;
      return abs(a) < 100 ? 0 : a;
    }

  private:
    const int m_pinR;
    const int m_pinL;
    int m_valR;
    int m_valL;
    int m_delta;
};

class HiddenNeuron
{
  public:
    HiddenNeuron(const int threshold, const float decay):
      m_threshold(threshold),
      m_pidController(-255, 255, decay)
    {
    }

    void init()
    {
      m_pidController.setConservativeTunings();
    }

    int fire(int value)
    {
      return m_pidController.compute((value < m_threshold) ? 0 : value);
    }

    void setTunings(const float Kp, const float Ki, const float Kd)
    {
      m_pidController.setTunings(Kp, Ki, Kd);
    }

    int loadFromMemory(int a)
    {
      float Kp, Ki, Kd;
      a += EEPROMEX.get(a, Kp);
      a += EEPROMEX.get(a, Ki);
      a += EEPROMEX.get(a, Kd);
      m_pidController.setTunings(Kp, Ki, Kd);
#ifdef DEBUG
      Debug.print("Load tunings: ");
      Debug.print(Kp);
      Debug.print(", ");
      Debug.print(Ki);
      Debug.print(", ");
      Debug.println(Kd);
#endif
      return a;
    }

    int saveToMemory(int a)
    {
      float Kp, Ki, Kd;
      m_pidController.getTunings(&Kp, &Ki, &Kd);
#ifdef DEBUG
      Debug.print("Save tunings: ");
      Debug.print(Kp);
      Debug.print(", ");
      Debug.print(Ki);
      Debug.print(", ");
      Debug.println(Kd);
#endif
#ifndef DEBUG_PRESERVE_EEPROM
      a += EEPROMEX.put(a, Kp);
      a += EEPROMEX.put(a, Ki);
      a += EEPROMEX.put(a, Kd);
#endif
      return a;
    }

  private:
    const int m_threshold;
    YAPIDController m_pidController;
};

class OutputNeuron
{
  public:
    OutputNeuron(int e, int a, int b, int threshold):
      m_pinEnable(e),
      m_pinInputA(a),
      m_pinInputB(b),
      m_threshold(threshold)
    {
    }

    void init()
    {
      pinMode(m_pinEnable, OUTPUT);
      pinMode(m_pinInputA, OUTPUT);
      pinMode(m_pinInputB, OUTPUT);

      fire(0);
    }

    void fire(int value)
    {
      if (value >= m_threshold)
      {
        analogWrite(m_pinEnable, min(value, 255));
        digitalWrite(m_pinInputA, HIGH);
        digitalWrite(m_pinInputB, LOW);
      }
      else if (value <= -m_threshold)
      {
        analogWrite(m_pinEnable, min(-value, 255));
        digitalWrite(m_pinInputA, LOW);
        digitalWrite(m_pinInputB, HIGH);
      }
      else
      {
        analogWrite(m_pinEnable, 0);
        digitalWrite(m_pinInputA, LOW);
        digitalWrite(m_pinInputB, LOW);
      }
    }

  private:
    const int m_threshold;
    const int m_pinEnable;
    const int m_pinInputA;
    const int m_pinInputB;
};


