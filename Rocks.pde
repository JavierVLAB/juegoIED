
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
    diameter = random(20, 80);
    int init = (int) random(0, 2);

    switch(init) {
    case 0:
      p = new PVector(-diameter, random(height / 8, 7 * height/8));
      v = new PVector(random(0, 1), random(-0.5, 0.5));
      break;

    case 1:
      p = new PVector(width + diameter, random(height / 8, 7 * height/8));
      v = new PVector(random(-1, 0), random(-0.5, 0.5));
      break;
    }


    v.setMag(random(3, 5));
    angle = random(-0.1, 0.1);
    alpha = 0;

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
    angle = a;
  }

  void update() {
    p.add(v);
    alpha += angle;

    if (p.x <  - 3*diameter || p.x > width + 3 * diameter ||
      p.y < - 3*diameter || p.y > height + 3*diameter) {
      alive = false;
    }
  }

  void draw() {

    update();

    pushMatrix();
    imageMode(CENTER);
    translate(p.x, p.y);
    rotate(alpha);
    image(img, 0, 0, diameter, diameter);
    popMatrix();


    //noStroke();
    //fill(255);
    //ellipse(p.x,p.y,r,r);
  }

  void shutInside(float x, float y) {
    int radio = (int) diameter / 2;
    if (x < p.x + radio && x > p.x - radio && 
      y < p.y + radio && y > p.y - radio) {
      alive = false;
      if (diameter >= 20) {
        PVector v1 = new PVector(random(-1, 1), random(-1, 1));
        v1.setMag(random(2, 3));
        PVector v2 = PVector.sub(v, v1);
        float a = random(-0.1, 0.1);
        Rock r1 = new Rock(p.copy(), PVector.add(v1, v), diameter/2, angle);
        Rock r2 = new Rock(p.copy(), v2, diameter/2, -angle);
        rocks.add(r1);
        rocks.add(r2);
      }
    }
  }
}

class Ship extends Rock {
  int type; 
  int life;
  boolean dead;

  Ship() {
    super();
    diameter = random(60,100);
    angle = 0;
    type = (int) random(spaceImages.length);
    life = 10;
    img = spaceImages[type];
    dead = false;
  }

  void shutInside(float x, float y) {
    int radio = (int) diameter / 2;
    if (x < p.x + radio && x > p.x - radio && 
      y < p.y + radio && y > p.y - radio) {
      dead = true;
      img = boomImg.copy();
      if (diameter >= 20) {
      }
    }
  }

  void update() {
    super.update();

    if (dead) {
      life--;
      if (life <= 0) alive = false;
    }
  }
}