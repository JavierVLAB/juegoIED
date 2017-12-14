
class Rock {
  PVector p;
  PVector v;
  float   diameter;
  PImage img;
  boolean alive;
  boolean inside;
  float angle;
  float alpha;

  Rock() {
    p = new PVector(random(width), random(height));
    v = new PVector(random(-1, 1), random(-1, 1));
    angle = random(-0.1,0.1);
    alpha = 0;
    v.setMag(random(3,5));
    diameter = random(20, 80);
    img = rockImg.copy();
    alive = true;
    inside = false;
  }

  Rock(PVector _p, PVector _v, float d, float a) {
    p = _p;
    v = _v;
    diameter = d;
    img = rockImg.copy();
    alive = true;
    inside = false;
    alpha = a;
    
  }

  void update() {
    p.add(v);
    alpha += angle;

    if (p.x <  - 2*diameter || p.x > width + 2 * diameter ||
      p.y < - 2*diameter || p.y > height + 2*diameter) {
      alive = false;
    }
  }

  void draw() {
    
    update();
    
    pushMatrix();
    translate(p.x, p.y);
    rotate(alpha);
    image(img, 0,0, diameter, diameter);
    popMatrix();
    

    //noStroke();
    //fill(255);
    //ellipse(p.x,p.y,r,r);
  }

  void shutInside(float x, float y) {

    if (x < p.x + diameter && x > p.x - diameter && 
      y < p.y + diameter && y > p.y - diameter) {
      alive = false;
      if (diameter >= 20) {
        PVector v1 = new PVector(random(-1,1),random(-1,1));
        v1.setMag(random(2,3));
        PVector v2 = PVector.sub(v, v1);
        float a = random(-0.1,0.1);
        Rock r1 = new Rock(p.copy(), PVector.add(v1, v), diameter/2,a);
        Rock r2 = new Rock(p.copy(), v2, diameter/2,-a);
        rocks.add(r1);
        rocks.add(r2);
      }
    }
  }
}