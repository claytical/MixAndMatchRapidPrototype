
InteractableCircleObject player1;
InteractableCircleObject player2;
ArrayList<InteractableCircleObject> circles;
ArrayList<InteractableCircleObject> player1projectiles;
ArrayList<InteractableCircleObject> player2projectiles;

color backgroundColor = color(0, 0, 0);


void setup() {
  fullScreen();
  //CREATE THE PLAYER
  //POSITION THEM IN THE CENTER OF THE SCREEN
  //GIVE THEM A RADIUS OF 100 PIXELS
  player1 = new InteractableCircleObject(100, height/2, 100);
  player2 = new InteractableCircleObject(width - 100, height/2, 100);

  //CHANGE THE DEFAULT COLOR OF THE PLAYER1 TO YELLOW
  player1.SetColor(color(255, 255, 0));

  //CHANGE THE DEFAULT COLOR OF THE PLAYER2 TO BLUE
  player2.SetColor(color(0, 0, 255));

  //SET THE PLAYERS SPEED TO 1
  player1.SetSpeed(1);
  player2.SetSpeed(1);

  //CREATE A CONTAINER FOR THE PLAYERS PROJECTILES
  player1projectiles = new ArrayList<InteractableCircleObject>();
  player2projectiles = new ArrayList<InteractableCircleObject>();

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

  //DISPLAY THE PLAYERS
  player1.Show();
  player2.Show();

  //MOVE THE PLAYERS IN THEIR CURRENT DIRECTION
  player1.Move();
  player2.Move();

  //SHOW ANY PROJECTILES
  ShowProjectiles();

  //MOVE ANY PROJECTILES CREATED BY PLAYERS
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

  CheckProjectileCollisionWithPlayers();
}

void CheckProjectileCollisionWithPlayers() {
  for (int i = 0; i < player1projectiles.size(); i++) {
    if (player1projectiles.get(i).hitOtherCircle(player2) ) {
      //PLAYER 1 HIT PLAYER 2
      backgroundColor = color(255,255,0);
  }
  }
  for (int i = 0; i < player2projectiles.size(); i++) {
    if (player2projectiles.get(i).hitOtherCircle(player1) ) {
      //PLAYER 2 HIT PLAYER 1
      backgroundColor = color(0,0,255);

  }
  }
}
  void ShowProjectiles() {
    for (int i = 0; i < player1projectiles.size(); i++) {
      player1projectiles.get(i).Show();
    }

    for (int i = 0; i < player2projectiles.size(); i++) {
      player2projectiles.get(i).Show();
    }
  }

  void MoveProjectiles() {
    for (int i = 0; i < player1projectiles.size(); i++) {
      player1projectiles.get(i).Move();
    }
    for (int i = 0; i < player2projectiles.size(); i++) {
      player2projectiles.get(i).Move();
    }
  }

  void MovePlayer1() {
    if (keyCode == UP) {
      player1.SetDirection(0, -1);
    }

    if (keyCode == DOWN) {
      player1.SetDirection(0, 1);
    }

    if (keyCode == LEFT) {
      player1.SetDirection(-1, 0);
    }

    if (keyCode == RIGHT) {
      player1.SetDirection(1, 0);
    }
  }

  void MovePlayer2() {
    if (key == 'w' || key == 'W') {
      player2.SetDirection(0, -1);
    }

    if (key == 's' || key == 'S') {
      player2.SetDirection(0, 1);
    }

    if (key == 'a' || key == 'A') {
      player2.SetDirection(-1, 0);
    }

    if (key == 'd' || key == 'D') {
      player2.SetDirection(1, 0);
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

      if (player1.hitOtherCircle(circles.get(i)) ) {
        //YES? TURN THE SCREEN RED.
        backgroundColor = color(255, 0, 0);
      }

      if (player2.hitOtherCircle(circles.get(i)) ) {
        //YES? TURN THE SCREEN RED.
        backgroundColor = color(255, 0, 0);
      }
    }
  }

  void CheckProjectileCollisionWithCircles() {
    for (int i = 0; i < player1projectiles.size(); i++) {
      //DID PROJECTILE HIT A CIRCLE?
      for (int j = circles.size() -1; j >= 0; j--) {
        if (player1projectiles.get(i).hitOtherCircle(circles.get(j)) ) {
          //YES? REMOVE THE CIRCLE
          circles.remove(j);
        }
      }
    }

    for (int i = 0; i < player2projectiles.size(); i++) {
      //DID PROJECTILE HIT A CIRCLE?
      for (int j = circles.size() -1; j >= 0; j--) {
        if (player2projectiles.get(i).hitOtherCircle(circles.get(j)) ) {
          //YES? REMOVE THE CIRCLE
          circles.remove(j);
        }
      }
    }
  }


  void keyPressed() {
    MovePlayer1();
    MovePlayer2();

    if (key == 'f' || key == 'F') {
      //SHOOT A 10 PIXEL PROJECTILE
      InteractableCircleObject projectile = new InteractableCircleObject(player1.x, player1.y, 10);
      projectile.SetSpeed(10);
      //IF THE PLAYER IS MOVING, SHOOT IN THAT DIRECTION.
      //IF THE PLAYER IS STATIONARY, SHOOT LEFT
      if (player1.directionX == 0 && player1.directionY == 0) {
        projectile.SetDirection(1, 0);
      } else {
        projectile.SetDirection(player1.directionX, player1.directionY);
      }
      player1projectiles.add(projectile);
    }

    if (keyCode == SHIFT) {
      //SHOOT A 10 PIXEL PROJECTILE
      InteractableCircleObject projectile = new InteractableCircleObject(player2.x, player2.y, 10);
      projectile.SetSpeed(10);
      //IF THE PLAYER IS MOVING, SHOOT IN THAT DIRECTION.
      //IF THE PLAYER IS STATIONARY, SHOOT LEFT
      if (player2.directionX == 0 && player2.directionY == 0) {
        projectile.SetDirection(1, 0);
      } else {
        projectile.SetDirection(player2.directionX, player2.directionY);
      }
      player2projectiles.add(projectile);
    }


    //RESET BACKGROUND TO BLACK WHEN SPACE IS PRESSED
    if (key == ' ') {
      backgroundColor = color(0, 0, 0);
    }
  }
