void setup() {
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(13, OUTPUT);
  pinMode(A2, INPUT);
}

void loop() {

  int switchPosition = digitalRead(A2);

  if (switchPosition == HIGH) {
    digitalWrite(10, HIGH);   // turn the LED on (HIGH is the voltage level)
    digitalWrite(9, LOW);
  } else  {
    digitalWrite(10, LOW);    // turn the LED off by making the voltage LOW
    digitalWrite(9, HIGH);
  }
}
