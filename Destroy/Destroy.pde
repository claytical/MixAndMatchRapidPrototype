
InteractableCircleObject player;
ArrayList<InteractableCircleObject> circles;
ArrayList<InteractableCircleObject> projectiles;

color backgroundColor = color(0, 0, 0);


void setup() {
  fullScreen();
  //CREATE THE PLAYER
  //POSITION THEM IN THE CENTER OF THE SCREEN
  //GIVE THEM A RADIUS OF 100 PIXELS
  player = new InteractableCircleObject(width/2, height/2, 100);

  //CHANGE THE DEFAULT COLOR OF THE PLAYER TO YELLOW
  player.SetColor(color(255, 255, 0));

  //SET THE PLAYER SPEED TO 1
  player.SetSpeed(1);

  //CREATE A CONTAINER FOR THE PLAYER'S PROJECTILES
  projectiles = new ArrayList<InteractableCircleObject>();

  //CREATE A CONTAINER FOR CIRCLES TO INTERACT WITH
  circles = new ArrayList<InteractableCircleObject>();

  //CREATE 5 CIRCLES, POSITIONED RANDOMLY
  //GIVE THEM A RADIUS OF 100 PIXELS
  for (int i = 0; i < 5; i++) {
    InteractableCircleObject circle = new InteractableCircleObject(int(random(width)), int(random(height)), 50);
    circles.add(circle);
  }

  //SET ATTRIBUTES FOR EACH CIRCLE
  for (int i = 0; i < circles.size(); i++) {
    //SET ALL CIRCLES TO SPEED OF 1
    circles.get(i).SetSpeed(1);
    //SET DIRECTION FOR CIRCLES TO BE RANDOM
    circles.get(i).SetDirection(int(random(-2, 2)), int(random(-2, 2)));
  }
}

void draw() {
  //SET THE BACKGROUND COLOR TO BLACK, EVERY FRAME
  background(backgroundColor);

  //DISPLAY THE PLAYER
  player.Show();

  //MOVE THE PLAYER IN THEIR CURRENT DIRECTION
  player.Move();

  //SHOW ANY PROJECTILES
  ShowProjectiles();

  //MOVE ANY PROJECTILES CREATED BY PLAYER
  MoveProjectiles();

  //DISPLAY THE CIRCLES
  ShowCircles();

  //MOVE ALL OF THE CIRCLES
  MoveCircles();

  //KEEP CIRCLES ON SCREEN
  KeepCirclesOnScreen();

  //DID PLAYER GET HIT BY A CIRCLE?
  CheckPlayerCollisionWithCircles();

  //DID PLAYER PROJECTILES HIT A CIRCLE?
  CheckProjectileCollisionWithCircles();
}


void ShowProjectiles() {
  for (int i = 0; i < projectiles.size(); i++) {
    projectiles.get(i).Show();
  }
}

void MoveProjectiles() {
  for (int i = 0; i < projectiles.size(); i++) {
    projectiles.get(i).Move();
  }
}

void MovePlayer() {
  if (keyCode == UP) {
    player.SetDirection(0, -1);
  }

  if (keyCode == DOWN) {
    player.SetDirection(0, 1);
  }

  if (keyCode == LEFT) {
    player.SetDirection(-1, 0);
  }

  if (keyCode == RIGHT) {
    player.SetDirection(1, 0);
  }
}

void ShowCircles() {
  for (int i = 0; i < circles.size(); i++) {
    circles.get(i).Show();
  }
}

void MoveCircles() {
  for (int i = 0; i < circles.size(); i++) {
    circles.get(i).Move();
  }
}

void KeepCirclesOnScreen() {
  for (int i = 0; i < circles.size(); i++) {
    if (circles.get(i).x + circles.get(i).radius > width) {
      circles.get(i).directionX = -1;
    }

    if (circles.get(i).x - circles.get(i).radius < 0) {
      circles.get(i).directionX = 1;
    }

    if (circles.get(i).y + circles.get(i).radius > height) {
      circles.get(i).directionY = -1;
    }

    if (circles.get(i).y - circles.get(i).radius < 0) {
      circles.get(i).directionY = 1;
    }
  }
}


void CheckPlayerCollisionWithCircles() {
  for (int i = 0; i < circles.size(); i++) {
    //DID PLAYER HIT A CIRCLE?

    if (player.hitOtherCircle(circles.get(i)) ) {
      //YES? TURN THE SCREEN RED.
      backgroundColor = color(255, 0, 0);
    }
  }
}

void CheckProjectileCollisionWithCircles() {
  for (int i = 0; i < projectiles.size(); i++) {
    //DID PROJECTILE HIT A CIRCLE?
    for (int j = circles.size() -1; j >= 0; j--) {
      if (projectiles.get(i).hitOtherCircle(circles.get(j)) ) {
        //YES? REMOVE THE CIRCLE
        circles.remove(j);
      }
    }
  }
}






void keyPressed() {
  MovePlayer();

  if (key == 's' || key == 'S') {
    //SHOOT A 10 PIXEL PROJECTILE
    InteractableCircleObject projectile = new InteractableCircleObject(player.x, player.y, 10);
    projectile.SetSpeed(10);
    //IF THE PLAYER IS MOVING, SHOOT IN THAT DIRECTION.
    //IF THE PLAYER IS STATIONARY, SHOOT LEFT
    if (player.directionX == 0 && player.directionY == 0) {
      projectile.SetDirection(1, 0);
    } else {
      projectile.SetDirection(player.directionX, player.directionY);
    }
    projectiles.add(projectile);
  }

  //RESET BACKGROUND TO BLACK WHEN SPACE IS PRESSED
  if (key == ' ') {
    backgroundColor = color(0, 0, 0);
  }
}
