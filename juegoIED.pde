Starfield starfield;
ArrayList<Rock> rocks;
PImage rockImg;

void setup() {
  size(640, 480);
  rockImg = loadImage("rock01.png");
  starfield = new Starfield( 100 );
  rocks = new ArrayList<Rock>();
  rocks.add(new Rock());
  frameRate( 30 );
  smooth();
}

void draw() {
  background(0, 0, 10);
  starfield.draw();

  for (Rock r : rocks) {
    r.draw();
  }

  for (int i = rocks.size()-1; i >= 0; i--) {
    Rock r = rocks.get(i);
    if (!r.alive) {
      rocks.remove(i);
    }
  }

}

void keyPressed() {
  if (key == 'n') {
    Rock r = new Rock();
    rocks.add(r);
  }
}

void mouseReleased(){

  for (int i = rocks.size()-1; i >= 0; i--) {
    Rock r = rocks.get(i);
    r.shutInside(mouseX,mouseY);
  }

}