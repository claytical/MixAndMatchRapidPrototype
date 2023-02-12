ArrayList<InteractableCircleObject> circles;

void setup() {
  fullScreen();
  circles = new ArrayList<InteractableCircleObject>();
  for (int i = 0; i < 5; i++) {
    InteractableCircleObject circle = new InteractableCircleObject(int(random(width)), int(random(height)), 50);
    circles.add(circle);
  }
}

void draw() {
  background(0);
  for (int i = 0; i < circles.size(); i++) {
    circles.get(i).Show();
  }

}

void keyPressed() {

  //ASSIGN SPEED AND DIRECTION WHEN Q IS PRESSED
  if (key == 's' || key == 'S') {
    for (int i = 0; i < circles.size(); i++) {
      circles.get(i).SetSpeed(1);
      circles.get(i).SetDirection(1, 0);
    }
  }

  //MOVE EVERYTHING WHEN M IS PRESSED
  if (keyPressed) {
    if (key == 'm' || key == 'M') {
      for (int i = 0; i < circles.size(); i++) {
        circles.get(i).Move();
      }
    }
  }



}
