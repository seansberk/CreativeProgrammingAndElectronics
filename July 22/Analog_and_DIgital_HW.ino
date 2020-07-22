void blinker () {
  // Digital Response
  int blinks = 3;
  for (int i = 0; i < blinks; i++) {
    if (i < 2) {
      digitalWrite(13, HIGH);
      delay(100);
      digitalWrite(13, LOW);
      delay(100);
    }
    else {
      digitalWrite(13, HIGH);
      delay(500);
      digitalWrite(13, LOW);
      delay(100);
    }
  }
}


int brightness = 0;    // how bright the LED is
int fadeAmount = 5;    // the amount to fade the LED by

void setup() {
  // put your setup code here, to run once:
  // Declare Pin to be an output:
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(13, OUTPUT);
  pinMode(A2, INPUT);
  Serial.begin(9600);
}

void loop() {

  // put your main code here, to run repeatedly:

  // I write the code to read the digital and analog signals
  int switchPosition = digitalRead(A2);
  int sensorValue = analogRead(A3);

  // This line is used for debugging and setting values for the conditional statement
  Serial.println(sensorValue);
  delay(1);

  if (switchPosition == HIGH) {
    digitalWrite(10, HIGH);   // turn the LED on (HIGH is the voltage level)
    digitalWrite(9, LOW);
    blinker();
  } else  {
    if (sensorValue >500) {
      digitalWrite(10, HIGH);
      delay(100);
      digitalWrite(10, LOW);
      delay(100);
    }

    digitalWrite(9, HIGH);
  }
}
