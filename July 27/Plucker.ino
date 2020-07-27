//class Plucker {
//    Servo Finger;
//    int pos;
//    int increment;
//    int updateInterval;
//    unsigned long lastUpdate;
//
//  public:
//    Plucker(int interval) {
//      updateInterval = interval;
//      increment = 5;
//    }
//
//    void Attach(int pin) {
//      servo.attach(pin);
//    }
//
//    void Detach() {
//      servo.Detach();
//    }
//
//    void Update() {
//      // Will update the servo position
////      if ((millis() - lastUpdate) > updateInterval) {
////        lastUpdate = millis();
////        pos += increment;
////        servo.write(pos);
////        Serial.println(pos);
////        if ((pos >= 180) || (pos <= 0)) {
////          increment = -increment;
////        }
////      }
//
//      if (pos < 180) {
//        pos = 0;
//        servo.write(pos);
//      } else if (pos > 0) {
//        pos = 180;
//        servo.write(pos);
//      }
//    }
//}
