//class Metronome {
//    // Set the sound value of Meternome
//    int sound = NOTE_C4;
//
//    // Initialize the note duration for on and off
//    int noteDuration;
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
//    Metronome(int note, int pinNum) {
//      noteDuration = 1000 / note;
//      pin = pinNum;
//      
//      increment = 1.2;
//    }
//
//    void Update() {
//      currentMillis = millis();
//      if (currentMillis-previousMillis <= noteDuration*2) {
//        tone(pin,sound, noteDuration);  
//        previousMillis = currentMillis;
//      }
//    }
//
//    void increaseSpeed () {
//      noteDuration = noteDuration * 1.6;
//    }
//
//    void decreaseSpeed() {
//      noteDuration = noteDuration * 0.625;
//    }
//
//}
