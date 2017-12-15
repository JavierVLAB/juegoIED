import processing.video.*;
import blobDetection.*;
import blobscanner.*;


Starfield starfield;
ArrayList<Rock> rocks;
PImage rockImg;
PImage[] spaceImages;
PImage boomImg;
Detector bd;




Capture video;
boolean showVideo = false;
boolean showCalibration = false;
float xMin = 0;
float xMax = 1000;
float yMin = 0;
float yMax = 1000;

void setup() {
  //size(1920,1080);
  //size(1440,900);
  
  //String[] cameras = Capture.list();
  fullScreen();
  imageMode(CENTER);
  rockImg = loadImage("rock01.png");
  boomImg = loadImage("explosion.png");
  starfield = new Starfield( 100 );
  rocks = new ArrayList<Rock>();
  rocks.add(new Rock());
  video = new Capture(this,320,240);
  bd = new Detector( this, 255 );
  video.start();
  frameRate( 25 );
  smooth();
  //println(cameras);
  
  String[] filenames = listFileNames(dataPath("ships"));
  spaceImages = new PImage [filenames.length]; //array of original images
 
  for (int i=0; i<spaceImages.length; i++) { 
    spaceImages[i] = loadImage ("ships/"+ filenames[i]); //load each image
  }
  
}

void draw() {
  imageMode(CORNER);
  background(0, 0, 50);
  if(showVideo) image(video,0,0,1280,960);
  starfield.draw();
  
  PImage img;
  img = video.copy();
  img.filter(THRESHOLD, 1.0f);
  //image(img,0,0,1280,860);
  bd.imageFindBlobs(img);
  bd.loadBlobsFeatures();
  bd.findCentroids();
  
  for (int i = 0; i < bd.getBlobsNumber(); i++) {
    
    noFill();
    stroke(0, 255, 0);
    strokeWeight(1);
    float x, y;
    x = map(bd.getCentroidX(i),0,img.width,xMin,xMax);
    y = map(bd.getCentroidY(i),0,img.height,yMin,yMax);
    
    ellipse(x,y,20,20);
    point(x,y);
    for (int j = rocks.size()-1; j >= 0; j--) {
      Rock r = rocks.get(j);
      r.shutInside(x, y);
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
  
  
  if(showCalibration){
   calibration(); 
    if(bd.getBlobsNumber() > 0 && keyPressed){
      switch(key){
        case '1':
          xMin = bd.getCentroidX(0);
          yMin = bd.getCentroidY(0);
          print("xMin : ");
          println(xMin);
          print(",  yMin : ");
          println(yMin);
        break;
        case '2':
          xMax = bd.getCentroidX(0);
          yMax = bd.getCentroidY(0);
          print("xMax : ");
          print(xMax);
          print(",  yMax : ");
          println(yMax);
        break;
        
      }
    }
  }
  
  //New Rocks
  
  if(random(1) < 0.04){
    Rock r = new Rock();
    rocks.add(r);
  }
  
  if(random(1) < 0.01){
    Ship s = new Ship();
    rocks.add(s);
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
  if(key == 'c'){
    showCalibration = !showCalibration;
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

void calibration(){

  noFill();
  stroke(255,0,0);
  strokeWeight(2);
  int space = 0;
  point(space,space);
  point(width-space,space);
  point(space,height-space);
  point(width-space,height-space);
  int diameter = 40;
  ellipse(space,space, diameter, diameter);
  ellipse(width-space,space, diameter, diameter);
  ellipse(space,height-space, diameter, diameter);
  ellipse(width-space,height-space, diameter, diameter);
  
}

String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}