/*
Sean Sada
 Design Innovation 23 Summer 2020
 HW3
 July 15, 2020
 
 I am attempting to create a simple click based game that destroys bouncing objects
 and states when a central object has been damaged. I hope to include a score keeping
 as well as event based actions and text updates while using classes to 
 
 */

//void damageTaken() {
//  /* This function will check to see if any asteroids have hit the base */
//}

// Title Screen

// Health Stats


class Base {
  /* This class is to make a base that can be attacked by asteroids */
  float size = 60;
  int currentHealth;
  float x, y;
  boolean dead = false;
  
  Base(int health, float positionX, float positionY) {
    /* Base constructor*/
    //ellipse(positionX, positionY, radius, radius);
    int currentHealth = health;
    x = positionX;
    y = positionY;
  }

  void checkDead() {
    /* This function checks to see if the Base has died */
    if (currentHealth < 1) {
      dead = true;
    }
  }

  void drawBase() {
    /* This function draws the base if the base is not dead */
    if (dead == false) {
      fill(#FFFF00);
      ellipse(x, y, size, size);
    } else {
      print ("truee"); // used for debugging
    }
  }
}


class Asteroid {
  /* This class is to make asteroids that can attack a base */
  float size = 10;
  int currentHealth;
  float x, y, xSpeed, ySpeed;
  boolean dead = false;

  Asteroid(float XSPEED, float YSPEED, int health, float xPos, float yPos) {
    xSpeed = XSPEED;
    ySpeed = YSPEED;
    currentHealth = health;
    x = xPos;
    y = yPos;
  }

  void checkDead() {
    /* This function checks to see if the asteroid has died */
    if (currentHealth < 1) {
      dead = true;
    }
  }

  void update() {
    /* This updates the position of the asteroid based on the speed*/
    x += xSpeed;
    y += ySpeed;
  }

  void checkCollisions() {
    float rad = size/2;
    if ((x<rad) || (x>rad)) { 
      xSpeed = -xSpeed;
    }
    if ((y<rad) || (y>rad)) { 
      ySpeed = -ySpeed;
    }
  }

  void drawAst() {
    if (dead == false) {
      fill(200);
      rect(x, y, size, size);
    }
  }
}

Base homeBase = new Base(20, random(60,width-60), random(60,height-60));
Asteroid ast1 = new Asteroid(3, 7, 3, random(width-60), random(height-60));

void setup() {
  size(800, 800);
  smooth();
}

void draw() {
  background(0);
  //homeBase.checkDead(); //For some reason this keeps coming back as true and the base does not get drawn
  homeBase.drawBase();
  ast1.checkDead();
  ast1.drawAst();
}
