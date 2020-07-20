int enemyXSp = 3;
int enemyYSp = 5;
int enemySize = 20;
int enemyNumber = 20;
int enemyHealth;

//int enemyXSp = 3;
//int enemyYSp = 5;
int baseSize = 50;
int baseHealth;
//int enemyNumber = 20;

// Mouse Position
float mXPos;
float mYPos;

// Initializing the enemies and homebase
Enemy[] enemies = new Enemy[enemyNumber];
Base homeBase;

PImage bkgrd;

void setup() {
  size(700, 700);
  smooth();
  //enemyXSp = 3;
  //enemyYSp = 5;

  // Adding the enemies to the array
  for (int i=0; i<enemies.length; i++) {
    enemies[i] = new Enemy(random(enemySize, width-enemySize), random(enemySize, width-enemySize), 2);
  }
  // Adding the Home Base 
  homeBase = new Base(random(baseSize, width-baseSize), random(baseSize, width-baseSize), 100);
  
  bkgrd = loadImage("img/space.png");
}

void draw() {
  //background(bkgrd);
  background(0);

  for (int i =0; i<enemies.length; i++) {
    enemies[i].update();
    enemies[i].checkCollisions();
    enemies[i].drawEnemy();
  }
  homeBase.update();
  homeBase.drawBase();
}

void mousePressed() {
  float mXPos = mouseX;
  float mYPos = mouseY;
  //print(mXPos, mYPos); // This was used for debugging to make sure that the proper positioning was saved
}

void hitEnemy() {
  /* This function checks the coordinate of the mouse is within the coordinate range of the enemy and then
  tells the enemy that it is hit */
  for (int i=0; i<enemies.length; i++) {
    if (((mXPos > enemies[i].topLeftX()) & (mXPos < enemies[i].topRightX())) & 
    (mYPos > enemies[i].topLeftY()) & (mXPos < enemies[i].botRightY())) {
      
    }
  }
}
