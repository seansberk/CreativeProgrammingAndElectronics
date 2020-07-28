//class Plucker {
//  public:
//    Servo Finger;
//    int pos;
//    int increment;
//    int updateInterval;
//    unsigned long lastUpdate;
//
//    Plucker(int interval) {
//      updateInterval = interval;
//      increment = 5;
//    }
//
//    void Attach(int pin) {
//      Finger.attach(pin);
//    }
//
//    void Detach() {
//      Finger.detach();
//    }
//
//    void Update() {
//      if (pos < 180) {
//        pos = 180;
//        Finger.write(pos);
//      } else if (pos > 0) {
//        pos = 0;
//        Finger.write(pos);
//      }
//    }
//};
