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
float temperature;  // Temperature of the room
float time;
float light;
float distance;

/* Initializing values for Artwork */
int OFF_MAX = 300; // Sets the offset distance

void setup() {
  size(1600, 1000, P3D);

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
  // Draw the shape
  ellipse(xpos, ypos, 20, 20);
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
  float sensors[] = float(split(myString, ','));

  // print out the values you got:
  for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
    print("Sensor " + sensorNum + ": " + sensors[sensorNum] + "\t");
  }
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
        fill(colorFromOffset(xOff), colorFromOffset(yOff), 
          colorFromOffset(zOff));
        box((float) (20 + (Math.sin(frameCount / 20.0)) * 15));
        popMatrix();
      }
    }
  }
}
