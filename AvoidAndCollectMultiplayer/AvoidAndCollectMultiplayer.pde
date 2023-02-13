
InteractableCircleObject player1;
InteractableCircleObject player2;

ArrayList<InteractableCircleObject> killerCircles;
ArrayList<InteractableCircleObject> collectableCircles;

color backgroundColor = color(0, 0, 0);


void setup() {
  fullScreen();
  //CREATE THE PLAYERS
  //POSITION THEM ON OPPOSITE SIDES
  //GIVE THEM A RADIUS OF 100 PIXELS
  player1 = new InteractableCircleObject(100, height/2, 100);
  player2 = new InteractableCircleObject(width - 100, height/2, 100);

  //CHANGE THE DEFAULT COLOR OF THE PLAYER1 TO YELLOW
  player1.SetColor(color(255, 255, 0));
  //CHANGE THE DEFAULT COLOR OF THE PLAYER2 TO BLUE

  player2.SetColor(color(0, 0, 255));

  //SET THE PLAYER SPEED TO 1
  player1.SetSpeed(1);

  //SET THE PLAYER SPEED TO 1
  player2.SetSpeed(1);


  //CREATE KILLER CIRCLES
  SetupKillerCircles();

  //CREATE COLLECTABLE CIRCLES
  SetupCollectableCircles();
}

void draw() {
  //SET THE BACKGROUND COLOR TO BLACK, EVERY FRAME
  background(backgroundColor);

  //DISPLAY THE PLAYERS
  player1.Show();
  player2.Show();

  //DISPLAY THE KILLER CIRCLES
  ShowKillerCircles();

  //DISPLAY THE COLLECTABLE CIRCLES
  ShowCollectableCircles();

  //MOVE ALL OF THE KILLER CIRCLES
  MoveKillerCircles();

  //KEEP CIRCLES ON SCREEN
  KeepCirclesOnScreen();

  //DID PLAYER GET HIT BY A CIRCLE?
  CheckPlayerCollisionWithKillerCircles();

  //DID PLAYER COLLECT A CIRCLE?
  CheckPlayerCollisionWithCollectableCircles();

  //INPUT LIMITATION? HOW DOES THE HACK FEEL?

    player1.Move();
    player2.Move();
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



void SetupCollectableCircles() {
  //CREATE A CONTAINER FOR CIRCLES TO INTERACT WITH
  collectableCircles = new ArrayList<InteractableCircleObject>();

  //CREATE 10 CIRCLES, POSITIONED RANDOMLY
  //GIVE THEM A RADIUS OF 25 PIXELS
  for (int i = 0; i < 2; i++) {
    InteractableCircleObject circle = new InteractableCircleObject(int(random(width)), int(random(height)), 25);
    collectableCircles.add(circle);
  }

  //SET ATTRIBUTES FOR EACH CIRCLE
  for (int i = 0; i < collectableCircles.size(); i++) {
    //SET COLOR OF COLLECTABLE CIRCLES TO GREEN
    collectableCircles.get(i).SetColor(color(0, 255, 0));
  }
}

void ShowCollectableCircles() {
  for (int i = 0; i < collectableCircles.size(); i++) {
    collectableCircles.get(i).Show();
  }
}



void SetupKillerCircles() {
  //CREATE A CONTAINER FOR CIRCLES TO INTERACT WITH
  killerCircles = new ArrayList<InteractableCircleObject>();

  //CREATE 5 CIRCLES, POSITIONED RANDOMLY
  //GIVE THEM A RADIUS OF 50 PIXELS
  for (int i = 0; i < 5; i++) {
    InteractableCircleObject circle = new InteractableCircleObject(int(random(width)), int(random(height)), 50);
    killerCircles.add(circle);
  }

  //SET ATTRIBUTES FOR EACH CIRCLE
  for (int i = 0; i < killerCircles.size(); i++) {
    //SET ALL CIRCLES TO SPEED OF 1
    killerCircles.get(i).SetSpeed(1);
    //SET DIRECTION FOR CIRCLES TO BE RANDOM
    killerCircles.get(i).SetDirection(int(random(-2, 2)), int(random(-2, 2)));
  }
}


void ShowKillerCircles() {
  for (int i = 0; i < killerCircles.size(); i++) {
    killerCircles.get(i).Show();
  }
}

void MoveKillerCircles() {
  for (int i = 0; i < killerCircles.size(); i++) {
    killerCircles.get(i).Move();
  }
}

void KeepCirclesOnScreen() {
  for (int i = 0; i < killerCircles.size(); i++) {
    if (killerCircles.get(i).x + killerCircles.get(i).radius > width) {
      killerCircles.get(i).directionX = -1;
    }

    if (killerCircles.get(i).x - killerCircles.get(i).radius < 0) {
      killerCircles.get(i).directionX = 1;
    }

    if (killerCircles.get(i).y + killerCircles.get(i).radius > height) {
      killerCircles.get(i).directionY = -1;
    }

    if (killerCircles.get(i).y - killerCircles.get(i).radius < 0) {
      killerCircles.get(i).directionY = 1;
    }
  }
}


void CheckPlayerCollisionWithKillerCircles() {
  for (int i = 0; i < killerCircles.size(); i++) {
    //DID PLAYER HIT A CIRCLE?

    if (player1.hitOtherCircle(killerCircles.get(i)) || player2.hitOtherCircle(killerCircles.get(i))) {
      //YES? TURN THE SCREEN RED.
      backgroundColor = color(255, 0, 0);
    }
}
}

void CheckPlayerCollisionWithCollectableCircles() {
  for (int i = collectableCircles.size() - 1; i >= 0; i--) {
    //DID PLAYER HIT A CIRCLE?

    if (player1.hitOtherCircle(collectableCircles.get(i)) || player2.hitOtherCircle(collectableCircles.get(i)) ) {
      //YES? REMOVE THAT COLLECTABLE CIRCLE FROM THE ENVIRONMENT
      collectableCircles.remove(i);
    }
  }
  //IF THE LAST COLLECTABLE CIRCLE IS COLLECTED, TURN THE SCREEN GREEN
  if (collectableCircles.size() == 0) {
    backgroundColor = color(0, 255, 0);
  }
}





void keyPressed() {
  MovePlayer1();
  MovePlayer2();
  //RESET BACKGROUND TO BLACK WHEN SPACE IS PRESSED
  if (key == ' ') {
    backgroundColor = color(0, 0, 0);
  }
}
