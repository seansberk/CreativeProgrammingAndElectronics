/* 
 Processing Code for Room Mapping Robot
 Developed by Sean Sada
 Project for Design Inovation 23
 
 This code is used to develop a drawing based on the input provided by the sensors on Arduino.
 It will create responsive artworks that are dependant on the data provided by the Arduino 
 sensors. It will use data from the milliseconds elapsed, distance measured by the ultasonic 
 sensor, light measured by the photoresistor, and temperature measured by the TMP36 
 temperature sensor.
 
 */

import processing.serial.*;     // import the Processing serial library
Serial myPort;                  // The serial port

/* Initializing the variables for use in drawing */
float bgcolor;      // Background color, automatically sets to black
float fgcolor;      // Fill color
float xpos, ypos;   // Position of brush
float xProportion = 1.0;        // used to divide distance between x/y

/* Initializing sensor values */
float temperature;    // Temperature of the room
float time;           // Milliseconds elapsed
float light;          // Amount of light available
float distance;       // Distance measured by ultrasonic sensor

/* Initializing values for Artwork */
int OFF_MAX = 300; // Sets the offset distance
float maxLight = 1000.0;  //Based on testing value where max with direct flashlight was 950
float minLight = 250.0;   //Base on testing val with min 270 when covered with finger
// Originally temps set at max 30, min 18, for visualization set max 40 min 25
float maxTemp = 30.0;     // This is the average termperature in Jakarta
float minTemp = 18.0;     // This is the lowest AC setting temperature generally
float tempDiff = 3.0;
// Note that rarely does the sensor read below 24 so for visualization this may
// be a better choice in terms of min value but can be update via the function
float maxDist = 150.0;    // had a hard time reaching 100 but there were jumps to abour 135
float minDist = 0.0;

/* Initialize the sensor values array globally */
float sensors[];

/* Initialize global values for lighting and camera position */
float lightPos;
float divider;

/* To counter null errors, have wait values before the program begins checking for inputs */
int wait = 0;
int waitTime = 50;

/* Store previous values */
float lastDist = -1;

void setup() {
  size(1600, 1000, P3D);
  
  translate(width/2, height/2,0); // sets the middle of the window as the 0th position

  // List all the available serial ports to find Arduino Port
  //println(Serial.list());  // use this to find your port with the arduino

  // My port is always COM7 which is the 5th element in the array so
  // Serial.list()[4]
  myPort = new Serial(this, Serial.list()[4], 9600);

  // read bytes into a buffer until you get a linefeed (ASCII 10):
  // This way fully lines of information can be used
  myPort.bufferUntil('\n');

  // draw with smooth edges:
  smooth();
}

void draw() {
  background(bgcolor);
  fill(fgcolor);
  
  // Lighting set up and look up values
  lightPos = lighting();
  pointLight(255,255,255,-300,300,lightPos);
  ambientLight(100,100,100);
  
  // Camera Positioning
  divider = distDivCam();
  camera(width/2, height/2, (height/divider) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  
  // Draw the shape
  ellipse(xpos, ypos, 20, 20);
  
  theArt();
}

// serialEvent method is run automatically by the Processing applet whenever
// the buffer reaches the  byte value set in the bufferUntil()
// method in the setup():

void serialEvent(Serial myPort) {
  // read the serial buffer:
  String myString = myPort.readStringUntil('\n');
  // if you got any bytes other than the linefeed:
  myString = trim(myString);

  // split the string at the commas and convert the sections into integers:
  sensors = float(split(myString, ','));
  //println(sensors); // Used for debugging

  // print out the values you got:
  for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
    print("Sensor " + sensorNum + ": " + sensors[sensorNum] + "\t");
  }
  print("maxTemp : " + maxTemp);
  print("wait Time : " + wait);
  // add a linefeed after all the sensor values are printed:
  println();
  if (sensors.length > 1) {
    xpos = map(sensors[0], 0, 1023, 0, width);
    ypos = map(sensors[1], 0, 1023, 0, height);
    fgcolor = sensors[2];
  }
  // send a byte to ask for more data:
  myPort.write("A");
}

int colorFromOffset(int offset) {
  return (int) ((offset + OFF_MAX) / (2.0 * OFF_MAX) * 255);
}

int[] colorFromTemp() {
  /* Take the max temperature and min temperature as values to map to 
  The default max and min temperatures should be set globally
  Have an if statement to update if the max or min increases
  Make sure to use the global variables in the map function to make sure 
  updates to the temperature of the room can properly be recorded
  */
  
  // The following check keeps running into NullPointerException and it does not
  // want to deal with the NaN but I could not correct. Causes program to fail
  // 3/5 times possibly because initial check throws an error
  //if (sensors[0] > maxTemp) {
  //  maxTemp = sensors[0];
  //  if ((maxTemp-minTemp) > tempDiff) {
  //    minTemp = maxTemp - tempDiff;
  //  }
  //}
  //if (sensors[0] < minTemp) {
  //  minTemp = sensors[0];
  //  if ((maxTemp-minTemp) > tempDiff) {
  //    maxTemp = minTemp + tempDiff;
  //  }
  //}
  if (wait < waitTime) {
    int[] temp = new int[2];
    temp[0] = 0;
    temp[1] = 0;
    return temp;
  }
  float temp = map(abs(sensors[0]), minTemp, maxTemp, 0, 255);
  int[] colors = new int[2];
  colors[0] = int(temp);
  colors[1] = 255-int(temp);
  return colors;
}

float lighting() {
  wait += 1;
  if (wait < waitTime) {
    return 1000.0;
  }
  float lightMove = map(sensors[2], minLight, maxLight, -1000, 2000);
  return lightMove;
}

int distDivCam() {
  if (wait < waitTime) {
    return 2;
  }
  if (sensors[1] > maxDist) {
    sensors[1] = maxDist;
  }
  float mappedDist = map(sensors[1], minDist, maxDist, 100, 1);
  int rtVal = int(sqrt(mappedDist));
  return rtVal;
}

void updateLastDist() {
  lastDist = sensors[1];
}

void checkLastDist() {
  if (lastDist == -1) {
    return ;
  }
  
}

void theArt() {
  /* Requires some review but this makes the artwork */
  background(0);
  translate(width / 2, height / 2, -OFF_MAX);
  rotateX(frameCount * .01);
  rotateY(frameCount * .01);
  rotateZ(frameCount * .01);

  for (int xOff = -OFF_MAX; xOff <= OFF_MAX; xOff += 50) {
    for (int yOff = -OFF_MAX; yOff <= OFF_MAX; yOff += 50) {
      for (int zOff = -OFF_MAX; zOff <= OFF_MAX; zOff += 50) {
        pushMatrix();
        translate(xOff, yOff, zOff);
        rotateX(frameCount * .02);
        rotateY(frameCount * .02);
        rotateZ(frameCount * .02);
        
        /* Need to set colors to be within 20 of the middle distance
         Maybe use map from -OFF_MAX to OFF_MAX mapped to -20 to 20
         This can be labeled as colOff for color offset and then 
         added into the values for red and blue
        
         We can run a new function which returns an int[] and take the
         values of that array as different values for the rgb values of
         fill
         
         Since green will always be 0 (temperature being visualized from
         red to blue), we only need to save the values for red and blue
        */
        int[] colVals= colorFromTemp();
        int redVal = colVals[0];
        int bluVal = colVals[1];
        float redMod = map(xOff, -OFF_MAX, OFF_MAX, -30, 30);
        float bluMod = map(zOff, -OFF_MAX, OFF_MAX, -30, 30);
        redVal += redMod;
        bluVal += bluMod;
        fill(redVal, 0, bluVal);
        
        // Original testing code, save for debugging as a known working part
        //fill(colorFromOffset(xOff), colorFromOffset(yOff), 
        //  colorFromOffset(zOff));
        
        
        box((float) (20 + (Math.sin(frameCount / 20.0)) * 15));
        popMatrix();
      }
    }
  }
}
