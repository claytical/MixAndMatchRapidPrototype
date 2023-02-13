class InteractableImageObject {
  int x;
  int y;
  int directionX;
  int directionY;
  int radius;
  float speed;
  PImage img;
  color c;
  
  InteractableImageObject(int _x, int _y, final PImage _img) {
    x = _x;
    y = _y;
    speed = 0;
    c = color(255,255,255);
    img = _img;
    radius = img.width;
}
 
  void Show() {
    image(img, x, y);
  }
  
  void SetImage(String filename) {
    img = loadImage(filename);
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
  
  boolean hitCircle(InteractableCircleObject circle) {
    if(dist(x, y, circle.x, circle.y) <= radius + circle.radius) {
      return true;
    }
    return false;
  }

}
