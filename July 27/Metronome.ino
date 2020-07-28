//class Metronome {
//    // Set the sound value of Meternome
//    int sound = NOTE_C4;
//
//    // Initialize the note duration for on and off
//    int noteDuration;
//    int noteL;
//
//    // Increases and decreases the tempo
//    int buttonSpeedUp;
//    int buttonSpeedDown;
//    int increment;
//
//    // State
//    bool soundState = true;
//
//    // Pin
//    int pin;
//
//    // Time tracker for last time the sound was updated
//    unsigned long previousMillis;
//
//  public:
//    Metronome(int note, int pinNum) {
//      noteL = note;
//      noteDuration = 1000 / noteL;
//      pin = pinNum;
//
//      increment = 1.2;
//    }
//
//    void Update() {
//      int currentMillis = millis();
//      int duration = noteDuration*2;
//      if (currentMillis-previousMillis > duration) {
//        tone(pin,sound,noteDuration);
//        previousMillis = currentMillis;
//      }
//    }
//
//    void increaseSpeed () {
//        if (noteL <= 8){
//          noteL += 1;
//          noteDuration = 1000/noteL;
//        }
//    }
//
//    void decreaseSpeed() {
//      if (noteL > 1) {
//        noteL -= 1;
//        noteDuration = 1000/noteL;
//      }
//    }
//
//};
