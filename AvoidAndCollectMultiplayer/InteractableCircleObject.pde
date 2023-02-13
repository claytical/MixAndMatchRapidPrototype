class InteractableCircleObject {
  int x;
  int y;
  int directionX;
  int directionY;
  int radius;
  float speed;
  PImage image;
  color c;
  
  InteractableCircleObject(int _x, int _y, int _r) {
    x = _x;
    y = _y;
    radius = _r;
    speed = 0;
    c = color(255,255,255);
  }
 
  void Show() {
    noStroke();
    fill(c);
    ellipse(x, y, radius*2, radius*2);
  }
  
  void SetImage(PImage img) {
    image = img;  
  }
  
  void SetSpeed(float _s) {
    speed = _s;
  }
  
  void SetDirection(int _x, int _y) {
   directionX = _x;
   directionY = _y;
  }
  
  void SetColor(color _c) {
   c = _c; 
  }
  
  void Move() {
   x = x + int((directionX * speed));
   y = y + int((directionY * speed));
  }
  
  boolean hitOtherCircle(InteractableCircleObject otherCircle) {
    if(dist(x, y, otherCircle.x, otherCircle.y) <= radius + otherCircle.radius) {
      return true;
    }
    return false;
  }

}
