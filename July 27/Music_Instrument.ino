/*
   Sean Sada
   Design Invocation 23
   Homework Assignment

   I am attempting to develop a program that works to pluck guitar strings while
   setting a tempo which can be changed with switches as if it was a meteronome

   Dev note: Spinner is no longer being used and is currently storing a class for
   led's which was intended to be used to indicate the meteronome speed in binary.
   Furthermore, both classes Metronome and Plucker were moved to this file as they
   won't be recognized due to the file naming scheme. This will be something I
   will be aware of in the future
*/

#include "pitches.h"
#include <Servo.h>

class Metronome {
    // Set the sound value of Meternome
    int sound = NOTE_C4;

    // Initialize the note duration for on and off
    int noteDuration;
    int noteL;

    // Increases and decreases the tempo
    int buttonSpeedUp;
    int buttonSpeedDown;
    int increment;

    // State
    bool soundState = true;

    // Pin
    int pin;

    // Time tracker for last time the sound was updated
    unsigned long previousMillis;

  public:
    // Constructor
    Metronome(int note, int pinNum) {
      noteL = note;
      noteDuration = 1000 / noteL;
      pin = pinNum;

      increment = 1.2;
    }

    // Method called to update the information of the metronome
    void Update() {
      int currentMillis = millis();
      int duration = noteDuration*2;
      if (currentMillis-previousMillis > duration) {
        tone(pin,sound,noteDuration);
        previousMillis = currentMillis;
      }
    }

    // Method used to increase the beep rate of the meteronome maxing out at an eigth
    // not to prevent the rate getting too high and making just a single long beep
    void increaseSpeed () {
        if (noteL <= 8){
          noteL += 1;
          noteDuration = 1000/noteL;
        }
    }

    // Method used to decrease beep rate of the metronome with at a minimum being 
    // 1000 milliseconds so as to not have the meteronome stop playing completely
    void decreaseSpeed() {
      if (noteL > 1) {
        noteL -= 1;
        noteDuration = 1000/noteL;
      }
    }

};

class Plucker {
  public:
    // Initializing the Servo within the Plucker as a Finger
    Servo Finger;

    // Initializes and stores Servo position
    int pos;

    // Used to update the increment of the rotation but this currently has no use
    int increment;

    int updateInterval;
//    unsigned long lastUpdate;                         // No longer used

    // Constructor
    Plucker(int interval) {
      updateInterval = interval;
      increment = 5;
    }

    // Method to attach pin to Finger
    void Attach(int pin) {
      Finger.attach(pin);
    }

    // Method to detatch pin from Finger
    void Detach() {
      Finger.detach();
    }

    // Method to be called in loop to update the Finger
    void Update() {
      // Will update the servo position                 // No longer used
      //      if ((millis() - lastUpdate) > updateInterval) {
      //        lastUpdate = millis();
      //        pos += increment;
      //        servo.write(pos);
      //        Serial.println(pos);
      //        if ((pos >= 180) || (pos <= 0)) {
      //          increment = -increment;
      //        }
      //      }

      // rotates the servo 180 degrees each way
      if (pos < 180) {
        pos = 180;
        Finger.write(pos);
      } else if (pos > 0) {
        pos = 0;
        Finger.write(pos);
      }
    }
};

// Stores servo position, originally used it testing
int pos = 0;                                           // No longer used

// Meteronome object initialized with
Metronome metronome = Metronome(4, 8);

// Plucker object initialized
Plucker finger = Plucker(5);

void setup() {
  // this attached the pin to the finger servo
  finger.Attach(9); 
}

void loop() {
  // This checks the metronome to see what it should play
  metronome.Update();
  
  // This checks to see if the button is pressed and causes the servo to turn and this
  // plucking the guitar string
  if (digitalRead(11) == HIGH) {
    finger.Update();
  }

  // These if statements check to see if their respective buttons are pressed, increasing
  // or decreasing the meteronome speed
  if (digitalRead(12) == HIGH) {
    metronome.increaseSpeed();
  }
  if (digitalRead(13) == HIGH) {
    metronome.decreaseSpeed();
  }

}
