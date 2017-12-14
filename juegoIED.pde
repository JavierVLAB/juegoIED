import processing.video.*;
import blobDetection.*;
import blobscanner.*;


Starfield starfield;
ArrayList<Rock> rocks;
PImage rockImg;

Detector bd;


Capture video;
boolean showVideo = false;

void setup() {
  size(1000,600);
  imageMode(CENTER);
  rockImg = loadImage("rock01.png");
  starfield = new Starfield( 100 );
  rocks = new ArrayList<Rock>();
  rocks.add(new Rock());
  video = new Capture(this,640,480);
  bd = new Detector( this, 255 );
  video.start();
  frameRate( 25 );
  smooth();
}

void draw() {
  background(0, 0, 50);
  if(showVideo) image(video,0,0);
  starfield.draw();
  
  PImage img;
  img = video.copy();
  img.filter(THRESHOLD, 0.6);
  image(img,0,0);
  bd.imageFindBlobs(img);
  bd.loadBlobsFeatures();
  bd.findCentroids();
  
  for (int i = 0; i < bd.getBlobsNumber(); i++) {
    
    noFill();
    stroke(0, 255, 0);
    strokeWeight(1);
    ellipse(bd.getCentroidX(i), bd.getCentroidY(i),20,20);
    point(bd.getCentroidX(i), bd.getCentroidY(i));
    for (int j = rocks.size()-1; j >= 0; j--) {
      Rock r = rocks.get(j);
      r.shutInside(bd.getCentroidX(i), bd.getCentroidY(i));
    }
  }
  
  
  

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
  if (key == 'p'){
    showVideo = !showVideo;
  }
}

void mouseReleased(){

  for (int i = rocks.size()-1; i >= 0; i--) {
    Rock r = rocks.get(i);
    r.shutInside(mouseX,mouseY);
  }

}

void captureEvent(Capture c) {
  c.read();
  
}