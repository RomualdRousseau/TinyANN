class Joystick
{
  public:
    int ModeAuto;
    int X;
    int Y;

    Joystick():
      ModeAuto(0),
      X(0),
      Y(0),
      m_serial(0, 1),
      m_state(0),
      m_sign(0)
    {
    }

    void init()
    {
      m_serial.begin(9600);
    }

    int ready()
    {
      if (m_serial.available())
      {
        char a = m_serial.read();
        switch (m_state)
        {
          case 0:
            if (a == '+') {
              m_state = 1;
              m_sign = 1;
              X = 0;
              Y = 0;
            }
            else if (a == '-') {
              m_state = 1;
              m_sign = -1;
              X = 0;
              Y = 0;
            }
            else if (a == 'A') {
              ModeAuto = 1;
              X = 0;
              Y = 0;
              return 1;
            }
            else if (a == 'M') {
              ModeAuto = 0;
              X = 0;
              Y = 0;
              return 1;
            }
            break;
          case 1:
            if (a == ',') {
              m_state = 2;
              X = (X < 256) ? 0 : m_sign * X;
            }
            else {
              X = X * 10 + int(a) - int('0');
            }
            break;
          case 2:
            if (a == '+') {
              m_state = 3;
              m_sign = 1;
            }
            else if (a == '-') {
              m_state = 3;
              m_sign = -1;
              
            }
            break;
          case 3:
            if (a == '\n') {
              m_state = 0;
              Y = (Y < 256) ? 0 : m_sign * Y;
              return 1;
            }
            else {
              Y = Y * 10 + int(a) - int('0');
            }
            break;
        }
      }
      return 0;
    }

  private:
    SoftwareSerial m_serial;
    int m_state;
    int m_sign;
};



