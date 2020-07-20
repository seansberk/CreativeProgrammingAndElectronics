class Base {
  float x, y, xSpeed, ySpeed;
  int health;
  boolean baseAlive;
  PImage base;

  Base(float xpos, float ypos, int hp) {
    x = xpos;
    y = ypos;
    xSpeed = 0;
    ySpeed = 0;
    health = hp;
    baseAlive = true;
    base = loadImage("img/Base.png");
  }

  void update() {
    x += xSpeed;
    y += ySpeed;
  }

  void checkCollisions() {
    /* This method check to see if it has collided with any of the boundaries or with other objects */
    float r = enemySize/2;
    if ((x<r)||(x>width-r)) {
      xSpeed = -xSpeed;
    }
    if ((y<r) || (y>height-r)) {
      ySpeed = -ySpeed;
    }
  }
  
  
  //void losehealth() {
    /* This method is meant to cause the base to lose health
    However, this may need a funciton built within MT_Game to be able to work on both enemy and base */
  //  health -= 
  //}
  
  //void checkAttack() {
  //  // Check for the position of the Enemy relative to the position of the base
  //  // THIS MAY NEED TO BE DONE OUTSIDE OF THE ENEMY CLASS
  //  //int temp = 0;
  //  if (health < 1) {
  //    baseAlive = false;
  //  }
  //}

  void drawBase() {
    //fill(140); 
    //rect(x, y, baseSize, baseSize);
    image(base, x, y, baseSize, baseSize);
  }
  
  /* The below finds the coordinates of each point and will be used to compare to the coordinates of 
  the base to find if the enemy has hit or not */
  float topLeftX() {
    return x - baseSize/2;
  }
  float topLeftY() {
    return y - baseSize/2;
  }
  float topRightX() {
    return x + baseSize/2;
  }
  float topRightY() {
    return y - baseSize/2;
  }
  float botLeftX() {
    return x - baseSize/2;
  }
  float botLeftY() {
    return y + baseSize/2;
  }
  float botRightX() {
    return x + baseSize/2;
  }
  float botRightY() {
    return y + baseSize/2;
  }
}
