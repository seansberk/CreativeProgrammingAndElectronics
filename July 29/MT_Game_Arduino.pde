import processing.sound.*;
import processing.serial.*;

/* Initializing Components to work with Arduino */
Serial myPort;
//float[] inByte = ;
float inByte = 0;
int pauseCheck;
int unpauseCheck;

/* Initializing Pause State */
boolean pause = false;

/* Initializing Enemy Vairables */
int enemyXSp = 1;
int enemyYSp = 2;
int enemySize = 50;
int enemyMaxSize = 150;
int enemyMinSize = 15;
int enemyCurrentSize;
int enemyNumber = 20;
int enemyHealth;
int enemiesDead;

/* Initializing Base Vairables */
int baseSize = 100;
int baseHealth;

/* Initializing Mouse Position variables */
float mXPos;
float mYPos;

/* Initializing the enemies and homebase */
Enemy[] enemies = new Enemy[enemyNumber];
Base homeBase;

/* Initializing Sound files */
SoundFile bounce;
SoundFile blaster;

// Initialize the background image of the game
PImage bkgrd;

void setup() {
  size(768, 768);
  smooth();
  myPort = new Serial(this, Serial.list()[4], 9600);
  bounce = new SoundFile(this, "sound/Bounce.mp3"); // set the first parameter and check to see if this works
  blaster = new SoundFile(this, "sound/Blaster.mp3");

  // Adding the enemies to the array
  for (int i=0; i<enemies.length; i++) {
    enemies[i] = new Enemy(random(enemySize, width-enemySize), random(enemySize, width-enemySize), 2);
  }
  // Adding the Home Base 
  homeBase = new Base(random(baseSize, width-baseSize), random(baseSize, width-baseSize), 100);

  // Setting initial value of number of enemies
  enemiesDead = 0;

  // Adding a background image to make the game more space like
  bkgrd = loadImage("img/space.png");
  
  enemyCurrentSize = enemySize;
}

void draw() {
  background(bkgrd);
  //background(0);

  enemiesDead = 0;
  hitEnemy();
  for (int i =0; i<enemies.length; i++) {
    enemies[i].update();
    enemies[i].checkCollisions();
    enemies[i].checkDead();
    enemies[i].drawEnemy();
    if (enemies[i].enemyAlive == false) {
      enemiesDead += 1;
    }
  }
  //hitEnemy(); // For some reason I wrote this twice
  homeBase.update();
  homeBase.drawBase();
  //print(homeBase.health); //Debugging if the health decreases
  //println(homeBase.topY()); //Debugging if the homeBase positioning is being properly reported
  gameOver();
}

void mousePressed() {
  mXPos = mouseX;
  mYPos = mouseY;
  //print(mXPos, mYPos); // This was used for debugging to make sure that the proper positioning was saved
}

void hitEnemy() {
  /* This function checks the coordinate of the mouse is within the coordinate range of the enemy and then
   tells the enemy that it is hit */
  for (int i=0; i<enemies.length; i++) {
    if (((mXPos >= enemies[i].leftX()) & (mXPos <= enemies[i].rightX())) & 
      ((mYPos >= enemies[i].topY()) & (mYPos <= enemies[i].botY()))) {
      enemies[i].enemyHit = true;
      print("hit!"); // This is not Displaying properly// THIS WORKS NOW
    }
  }
}

void hitBase() {
  /* This function checks the coordinates of each of the enemies and if they are equal to the position of
   the base then the attack is considered a hit on the base and the base loses health and destroys the enemy*/
  for (int i=0; i<enemies.length; i++) {
    if ((enemies[i].rightX() >= homeBase.leftX()) & (enemies[i].leftX() <= homeBase.rightX())) {
      if ((enemies[i].topY() <= homeBase.botY()) & (enemies[i].botY() >= homeBase.topY())) {
        homeBase.health -= 1;
      }
    }
  }
  mXPos = -1;
  mYPos = -1;
}

void gameOver() {
  /* This checks for the Game Over gamestate */
  // This checks to see if all the enemies have died and if so increases the number of dead enemies
  if (enemiesDead >= enemies.length) {
    enemyNumber = enemyNumber*2;

    // This initializes all the new enemies
    for (int i=0; i<enemies.length; i++) {
      enemies[i] = new Enemy(random(enemySize, width-enemySize), random(enemySize, width-enemySize), 2);
    }
    // Adding a new Home Base 
    homeBase = new Base(random(baseSize, width-baseSize), random(baseSize, width-baseSize), 100);
  }
}

void serialEvent (Serial myPort) {
  String inString = myPort.readStringUntil('\n');
  
  if (inString != null) {
    inString = trim(inString);
    int sensors[] = int(split(inString, ','));
    
    for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
      print("Sensor " + sensorNum + ":" + sensors[sensorNum]);
    }
    println();
    
    // Included all the values for each sensor
    float size = sensors[0]; 
    unpauseCheck = sensors[1];
    pauseCheck = sensors[2];
    
    // This should be used to change the size of the enemies
    size = map(size, 0, 1023, enemyMinSize, enemyMaxSize);
    enemyCurrentSize = int(size);
    
    if (unpauseCheck >= 1) {
      pause = false;
    } else if (pauseCheck >= 1) {
      pause = true;
    }
  }
}

void pauseGame() {
  while (pause == true) {
    ;
  }
}
