/*
  Arduino code for project Room Mapping Robot
  Developed by Sean Sada
  Projec for Design Innovation 23

  This adapts code written for sparkfun's inventor kit to help automate robot movements but includes
  use of sensors and utilizes the serial write functions to send information over to processing to generate
  dynamic art based on the input from the sensors.
*/

/* Pins for sensors */
const int tempPin = A1;
const int lightPin = A0;
// Distance variables
const int trigPin = 6;
const int echoPin = 5;

/* initialize values recorded by different sensors */
float tempSensor = 0;           // analog temperature sensor
float distSensor = 0;           // digital distance sensor
float lightSensor = 0;          // analog light sensor
unsigned long time;             // time readout reported later in milliseconds

int inByte = 0;                 // incoming serial byte

/* Temperature Values */
float voltage = 0;
float degreeC = 0;
float degreeF = 0;

/* Light Sensor Values */
int threshold = 750;             // will turn on indicator light when light values surpass threshold
const int lightIndPin = 4;

/* The right motor will be controlled by the motor A pins on the motor driver*/
const int AIN1 = 13;           //control pin 1 on the motor driver for the right motor
const int AIN2 = 12;           //control pin 2 on the motor driver for the right motor
const int PWMA = 11;           //speed control pin on the motor driver for the right motor

/* The left motor will be controlled by the motor B pins on the motor driver */
const int PWMB = 10;           //speed control pin on the motor driver for the left motor
const int BIN2 = 9;            //control pin 2 on the motor driver for the left motor
const int BIN1 = 8;            //control pin 1 on the motor driver for the left motor

int switchPin = 7;             //switch to turn the robot on and off

float distance = 0;            //variable to store the distance measured by the distance sensor

//robot behaviour variables
int backupTime = 300;             //time that the robot will back up, apprx. 1 ft
int turnTime = 200;               //amount that the robot will turn after back up, approximately 90 deg

/********************************************************************************/
void setup()
{
  pinMode(trigPin, OUTPUT);       //this pin will send ultrasonic pulses out from the distance sensor
  pinMode(echoPin, INPUT);        //this pin will sense when the pulses reflect back to the distance sensor

  pinMode(switchPin, INPUT_PULLUP);   //set this as a pullup to sense whether the switch is flipped


  //set the motor control pins as outputs
  pinMode(AIN1, OUTPUT);
  pinMode(AIN2, OUTPUT);
  pinMode(PWMA, OUTPUT);

  pinMode(BIN1, OUTPUT);
  pinMode(BIN2, OUTPUT);
  pinMode(PWMB, OUTPUT);

  Serial.begin(9600);                       //begin serial communication with the computer
  Serial.print("Robot Activated!");         //test the serial connection
}

/********************************************************************************/
void loop()
{
  /* If statement waits until there is valid byte before reading sensors */
  //  if (Serial.available() > 0) {           // Uncomment when Processing works
  // accepts incoming byte
  inByte = Serial.read();

  /* STORE THE CURRENT TIME ELAPSED */
  time = millis();

  /* GET TEMPERATURE READING */
  tempSensor = tempC();         // I will be using tempC() but you can replace with tempF()

  /* GET LIGHT SENSOR VALUES */
  lightSensor = getLight();

  /* DETECT THE DISTANCE READ BY THE DISTANCE SENSOR */
  distance = getDistance();
  distSensor = distance;

  /* Debugging code to see that the ultrasonic sensor works */
  //  Serial.print("Distance: ");
  //  Serial.print(distance);
  //  Serial.println(" in");              // print the units

  /* SEND SERIAL INFORMATION TO PROCESSING */
  Serial.print(tempSensor);
  Serial.print(",");
  Serial.print(distSensor);
  Serial.print(",");
  Serial.print(lightSensor);
  Serial.print(",");
  Serial.println(time);

  if (digitalRead(switchPin) == LOW) { //if the on switch is flipped

    if (distance < 10) {              //if an object is detected
      //back up and turn

      /* Debugging code to make sure this if statement runs */
      //      Serial.print(" ");
      //      Serial.print("BACK!");

      //stop for a moment
      rightMotor(0);
      leftMotor(0);
      delay(200);

      //back up
      rightMotor(-255);             // Works best at -255 otherwise there is not enough power
      leftMotor(-255);              // Works best at -255 otherwise there is not enough power
      delay(backupTime);

      //turn away from obstacle
      rightMotor(255);
      leftMotor(-255);
      delay(turnTime);

    } else {                        //if no obstacle is detected drive forward
      /* Debugging code to check that this statement runs */
      //      Serial.print(" ");
      //      Serial.print("Moving...");


      rightMotor(255);              // Works best at -255 otherwise there is not enough power
      leftMotor(255);               // Works best at -255 otherwise there is not enough power
    }
  } else {                          //if the switch is off then stop

    //stop the motors
    rightMotor(0);
    leftMotor(0);

//    /* SEND SERIAL INFORMATION TO PROCESSING */
//    // send 0 values for all sensor read out
//    Serial.print("0,");
//    Serial.print("0,");
//    Serial.print("0,");
//    Serial.println("0");
  }

  delay(50);                      //wait 50 milliseconds between readings
  //  }                     // UNCOMMENT WHEN PROCESSING WORKS
}

/********************************************************************************/
void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("0,0,0,0");   // send an initial string
    delay(300);                  // wait 300 milliseconds before pinging again
  }
}

/********************************************************************************/
float tempC() {
  // The following math was found in a sparkFun tutorial
  voltage = analogRead(tempPin) * 0.004882813;
  degreeC = (voltage - 0.5) * 100.0;
  return degreeC;
}

float tempF() {
  degreeC = tempC();
  degreeF = degreeC * (9.0 / 5.0) + 32.0;
}

/********************************************************************************/
float getLight() {
  float light = analogRead(lightPin);
  if (light < threshold) {
    digitalWrite(lightIndPin, HIGH);        // Turn on indicator LED
  } else {
    digitalWrite(lightIndPin, LOW);        // Turn off indicator LED
  }
  return light;
}

/* THE FOLLOWING CODE IS FOR ROBOT MOVEMENTS */
/********************************************************************************/
void rightMotor(int motorSpeed) {
  /* Function to work the right motor */
  if (motorSpeed > 0)                                 //if the motor should drive forward (positive speed)
  {
    digitalWrite(AIN1, HIGH);                         //set pin 1 to high
    digitalWrite(AIN2, LOW);                          //set pin 2 to low
  }
  else if (motorSpeed < 0)                            //if the motor should drive backward (negative speed)
  {
    digitalWrite(AIN1, LOW);                          //set pin 1 to low
    digitalWrite(AIN2, HIGH);                         //set pin 2 to high
  }
  else                                                //if the motor should stop
  {
    digitalWrite(AIN1, LOW);                          //set pin 1 to low
    digitalWrite(AIN2, LOW);                          //set pin 2 to low
  }
  analogWrite(PWMA, abs(motorSpeed));                 //now that the motor direction is set, drive it at the entered speed
}

/********************************************************************************/
void leftMotor(int motorSpeed) {
  /* Function to work the left motor */
  if (motorSpeed > 0)                                 //if the motor should drive forward (positive speed)
  {
    digitalWrite(BIN1, HIGH);                         //set pin 1 to high
    digitalWrite(BIN2, LOW);                          //set pin 2 to low
  }
  else if (motorSpeed < 0)                            //if the motor should drive backward (negative speed)
  {
    digitalWrite(BIN1, LOW);                          //set pin 1 to low
    digitalWrite(BIN2, HIGH);                         //set pin 2 to high
  }
  else                                                //if the motor should stop
  {
    digitalWrite(BIN1, LOW);                          //set pin 1 to low
    digitalWrite(BIN2, LOW);                          //set pin 2 to low
  }
  analogWrite(PWMB, abs(motorSpeed));                 //now that the motor direction is set, drive it at the entered speed
}

/********************************************************************************/
//RETURNS THE DISTANCE MEASURED BY THE HC-SR04 DISTANCE SENSOR
float getDistance()
{
  float echoTime;                   //variable to store the time it takes for a ping to bounce off an object
  float calculatedDistance;         //variable to store the distance calculated from the echo time

  //send out an ultrasonic pulse that's 10ms long
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  echoTime = pulseIn(echoPin, HIGH);      //use the pulsein command to see how long it takes for the
  //pulse to bounce back to the sensor

  calculatedDistance = echoTime / 148.0;  //calculate the distance of the object that reflected the pulse (half the bounce time multiplied by the speed of sound)

  return calculatedDistance;              //send back the distance that was calculated
}
