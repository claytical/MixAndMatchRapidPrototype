
InteractableCircleObject player;
ArrayList<InteractableCircleObject> circles;
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

  //DISPLAY THE CIRCLES
  ShowCircles();

  //MOVE ALL OF THE CIRCLES
  MoveCircles();

  //KEEP CIRCLES ON SCREEN
  KeepCirclesOnScreen();

  //DID PLAYER GET HIT BY A CIRCLE?
  CheckPlayerCollisionWithCircles();
}

void MovePlayer() {
  if (keyCode == UP) {
    player.SetDirection(0, -1);
    player.Move();
  }

  if (keyCode == DOWN) {
    player.SetDirection(0, 1);
    player.Move();
  }

  if (keyCode == LEFT) {
    player.SetDirection(-1, 0);
    player.Move();
  }

  if (keyCode == RIGHT) {
    player.SetDirection(1, 0);
    player.Move();
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

void keyPressed() {
  MovePlayer();
  
  //RESET BACKGROUND TO BLACK WHEN SPACE IS PRESSED
  if(key == ' ') {
   backgroundColor = color(0,0,0); 
  }
  
}
