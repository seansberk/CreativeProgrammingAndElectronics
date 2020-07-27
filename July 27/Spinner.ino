class Spinner {
    int ledPin;
    long OnTime;                    // milliseconds of on-time
    long OffTime;                   // milliseconds of off-time

    int ledState;                   // used to set the LED
    unsigned long previousMillis;   // stores the previous time LED was updated

    Spinner(int pin, long on, long off) {
      ledPin = pin;
      pinMode(ledPin, OUTPUT);

      OnTime = on;
      OffTime = off;

      ledState = LOW;
      previousMillis = 0;
    }

    void Update() {
      unsigned long currentMillis = millis();

      // Below replaces the loop previously used
      if ((ledState == HIGH) && (currentMillis - previousMillis >= OnTime)) {
        ledState = LOW;
        previousMillis = currentMillis;
        digitalWrite(ledPin, ledState);
      }
      else if ((ledState == LOW) && (currentMillis - previousMillis >= Offtime)) {
        ledState = HIGH;
        previousMillis = currentMillis;
        digitalWrite(ledPin, ledState);
      }
    }
};
