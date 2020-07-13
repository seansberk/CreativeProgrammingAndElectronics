/*
Sean Sada
 Design Innovation 23 Summer 2020
 HW2
 
 In this assignment I create an "artwork" based on the concepts of tranformations and 
 loops. I hope to also make this interactive and create unique patterns
 
 // Attempt to include interactive mouseclick based artwork as well
 */

void setup() {
  size(400, 400);
  background(250);
  smooth();
  noStroke();
}

void draw() {
  
  drawCircle(width/2, height/2);
  //Attempt to make on MouseClick animations
  if (mousePressed == true) {
    drawCircle(mouseX, mouseY);
  }
  //Attempt to have a zoom out animation
}

void drawCircle (int xCenter, int yCenter) {
  // Some of the following code was inspired by the rotating color wheel from 
  //lecture
  noStroke();
  //The below makes the center smallest circle
  if (frameCount % 10 == 0) {
    fill(frameCount*5 % 255, frameCount*2 % 255, 
      frameCount % 255);
    pushMatrix();
    translate(xCenter, yCenter);
    rotate(radians(frameCount * 2  % 360));
    triangle(0, 0, 30, 0, 15, 15);
    ellipse(30, 30, 45, 45);
    stroke(frameCount*2 % 255, frameCount*3 % 255, 
      frameCount % 255);
    drawSquiggle();
    popMatrix();

    pushMatrix();
    translate(xCenter, yCenter);
    scale(2.0);
    rotate(-radians(frameCount * 2  % 360));
    stroke(frameCount*2 % 255, frameCount*3 % 255, 
      frameCount % 255);
    drawSquiggle();
    noFill();
    rect(0, 0, 30, 30, 6, 18, 6, 28);
    popMatrix();
  }
}


// Making Squiggly lines
void drawSquiggle () {
  //stroke(140);
  noFill();
  arc(15, 15, 20, 30, PI+HALF_PI, PI*2+HALF_PI);
  arc(15, 45, 20, 30, HALF_PI, PI+HALF_PI);
}


// Making repeating slanted lines across the screen
