float voltage = 0;
float degreeC = 0;
float degreeF = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  voltage = analogRead(A1) * 0.004882813;
  degreeC = (voltage - 0.5) * 100.0;
  degreeF = degreeC * (9.0/5.0) + 32.0;
  Serial.print("DegreeC: ");
  Serial.println(degreeC);
}
