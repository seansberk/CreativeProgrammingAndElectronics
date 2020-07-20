import processing.sound.*;

/* Initializing Enemy Vairables */
int enemyXSp = 1;
int enemyYSp = 2;
int enemySize = 50;
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
// Inserting new SoundFile for destroyed enemy

/* Initializing  */

// Initialize the background image of the game
PImage bkgrd;

void setup() {
  size(700, 700);
  smooth();
  bounce = new SoundFile(this, "sound/Bounce.mp3"); // set the first parameter and check to see if this works

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
}

void draw() {
  //background(bkgrd);
  background(0);
  
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
  hitEnemy();
  homeBase.update();
  homeBase.drawBase();
  //print(homeBase.health); //Debugging if the health decreases
  //println(homeBase.topY()); //Debugging if the homeBase positioning is being properly reported
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
    //if (((enemies[i].rightX >= homeBase.leftX()) & mXPos <= homeBase.rightX()) & 
    //  (mYPos >= homeBase.topY()) & (mYPos <= homeBase.botY())) {
    //  homeBase.health -= 1;
    //}
  }
  mXPos = -1;
  mYPos = -1;
}
