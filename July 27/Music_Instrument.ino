/*
   Sean Sada
   Design Invocation 23
   Homework Assignment

   I am attempting to develop a program that works to pluck guitar strings while
   setting a tempo which can be changed with switches as if it was a meteronome

   Dev note: Spinner is no longer being used and is currently storing a class for
   led's which was intended to be used to indicate the meteronome speed in binary
*/

#include "pitches.h"
#include <Servo.h>

class Metronome {
    // Set the sound value of Meternome
    int sound = NOTE_C4;

    // Initialize the note duration for on and off
    int noteDuration;

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
    Metronome(int note, int pinNum) {
      noteDuration = 1000 / note;
      pin = pinNum;

      increment = 1.2;
    }

    void Update() {
      int currentMillis = millis();
      if (currentMillis - previousMillis <= noteDuration * 2) {
        tone(pin, sound, noteDuration);
        previousMillis = currentMillis;
      }
    }

    void increaseSpeed () {
      noteDuration = noteDuration * 1.6;
    }

    void decreaseSpeed() {
      noteDuration = noteDuration * 0.625;
    }

};

class Plucker {
    Servo Finger;
    int pos;
    int increment;
    int updateInterval;
    unsigned long lastUpdate;

  public:
    Plucker(int interval) {
      updateInterval = interval;
      increment = 5;
    }

    void Attach(int pin) {
      Finger.attach(pin);
    }

    void Detach() {
      Finger.detach();
    }

    void Update() {
      // Will update the servo position
      //      if ((millis() - lastUpdate) > updateInterval) {
      //        lastUpdate = millis();
      //        pos += increment;
      //        servo.write(pos);
      //        Serial.println(pos);
      //        if ((pos >= 180) || (pos <= 0)) {
      //          increment = -increment;
      //        }
      //      }

      if (pos < 180) {
        pos = 0;
        Finger.write(pos);
      } else if (pos > 0) {
        pos = 180;
        Finger.write(pos);
      }
    }
};


// Create a servo object called finger to pluck strings
Servo finger;

// Stores servo position
int pos = 0;

//int melody[] = {
//  NOTE_C4, NOTE_G3, NOTE_G3, NOTE_A3, NOTE_G3, 0, NOTE_B3, NOTE_C4
//};
//
//int noteDurations[] = {
//  4, 8, 8, 4, 4, 4, 4, 4
//};

// Button press to play note


// Meteronome object initialized with
Metronome metronome = Metronome(4, 7);

// Plucker object initialized
Plucker finger = Plucker(5);
Plucker.attach(9);

void setup() {
  // put your setup code here, to run once:
  //  pinMode(8, OUTPUT);
  //  pinMode(10, OUTPUT);

}

void loop() {
  // put your main code here, to run repeatedly:

  // This checks to see if the button is pressed and causes the servo to turn and this
  // plucking the guitar string
  if (digitalread(11) == HIGH) {
    finger.update();
  }

  // These if statements check to see if their respective buttons are pressed, increasing
  // or decreasing the meteronome speed
  if (digitalread(12) == HIGH) {
    metronome.increaseSpeed();
  }
  if (digitalread(13) == HIGH) {
    metronome.decreaseSpeed();
  }

}
