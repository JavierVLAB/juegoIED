
class Rock {
  PVector p;
  PVector v;
  float   diameter;
  PImage img;
  boolean alive;
  boolean inside;

  Rock() {
    p = new PVector(random(width), random(height));
    v = new PVector(random(-2, 2), random(-2, 2));
    diameter = random(20, 80);
    img = rockImg.copy();
    alive = true;
    inside = false;
  }

  Rock(PVector _p, PVector _v, float d) {
    p = _p;
    v = _v;
    diameter = d;
    img = rockImg.copy();
    alive = true;
    inside = false;
    
  }

  void update() {
    p.add(v);

    if (p.x <  - 2*diameter || p.x > width + 2 * diameter ||
      p.y < - 2*diameter || p.y > height + 2*diameter) {
      alive = false;
    }
  }

  void draw() {
    image(img, p.x, p.y, diameter, diameter);
    update();

    //noStroke();
    //fill(255);
    //ellipse(p.x,p.y,r,r);
  }

  void shutInside(float x, float y) {

    if (x < p.x + diameter && x > p.x - diameter && 
      y < p.y + diameter && y > p.y - diameter) {
      alive = false;
      if (diameter >= 20) {
        PVector v1 = new PVector(random(-0.5,0.5),random(-0.5,0.5));
        PVector v2 = PVector.sub(v, v1);
        Rock r1 = new Rock(p.copy(), PVector.add(v1, v), diameter/2);
        Rock r2 = new Rock(p.copy(), v2, diameter/2);
        rocks.add(r1);
        rocks.add(r2);
      }
    }
  }
}