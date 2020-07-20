class Enemy {
  float x, y, xSpeed, ySpeed;
  int health;
  boolean enemyAlive;
  PImage[] enemyImgs = new PImage[2];
  boolean enemyHit;
  PImage enemyImg;


  Enemy(float xpos, float ypos, int hp) {
    x = xpos;
    y = ypos;
    xSpeed = enemyXSp;
    ySpeed = enemyYSp;
    health = hp;
    enemyAlive = true;
    enemyHit = false;
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

  void dispEnemy() {
    if (health < 0) {
      print("Enemy has no health");
    } else if (health == 1) {
      PImage img = loadImage("img/Enemy1.png");
      PImage imgb = loadImage("img/Enemy1b.png");
      enemyImgs[0] = img;
      enemyImgs[1] = imgb;
    } else if ((health > 1) & (health <= 5)) {
      PImage img = loadImage("img/CommandShip-1.png");
      PImage imgb = loadImage("img/CommandShip-1b.png");
      enemyImgs[0] = img;
      enemyImgs[1] = imgb;
    }
  }

  //void checkAttack() {
  //  // Check for the position of the Enemy relative to the position of the base
  //  // THIS MAY NEED TO BE DONE OUTSIDE OF THE ENEMY CLASS
  //  //int temp = 0;
  //  if (health < 1) {
  //    enemyAlive = false;
  //  }
  //}

  void drawEnemy() {
    fill(200); 
    rect(x, y, enemySize, enemySize);
    
    //if (enemyAlive == false) {
    //  xSpeed = 0;
    //  ySpeed = 0;
    //} else if (enemyHit == false) {
    //  PImage pic = enemyImgs[0];
    //  image(pic, x, y, enemySize, enemySize);
    //  enemyAlive = false;
    //} else if (enemyHit == true) {
    //  PImage pic = enemyImgs[1];
    //  image(pic, x, y, enemySize, enemySize);
    //  enemyAlive = false;
    //}
  }
  float topLeftX() {
    return x - enemySize/2;
  }
  float topLeftY() {
    return y - enemySize/2;
  }
  float topRightX() {
    return x + enemySize/2;
  }
  float topRightY() {
    return y - enemySize/2;
  }
  float botLeftX() {
    return x - enemySize/2;
  }
  float botLeftY() {
    return y + enemySize/2;
  }
  float botRightX() {
    return x + enemySize/2;
  }
  float botRightY() {
    return y + enemySize/2;
  }
}
