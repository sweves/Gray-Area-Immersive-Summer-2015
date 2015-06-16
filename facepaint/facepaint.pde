// connect the dots game
// WITH YO FACE
//
//

//initialize libraries
import gab.opencv.*;
import processing.video.*;
import java.awt.*;

//initialize face recognition and webcam
Capture video;
OpenCV opencv;


//initialize creeper array and number of creepers
int countCreeps = 1;
ArrayList creepers;
float facex;
float facey;

float overshootx;
float overshooty;

float creepx, creepy;
float mappedx, mappedy;

PImage catdots;
PImage eagledots;
PImage sealdots;

int backgroundcounter;

void setup() {

  size(1680, 1050);

  catdots = loadImage("cat.png");
  eagledots = loadImage("eagle.png");
  sealdots = loadImage("seal.png");

  backgroundcounter = 0;
  background(catdots);

  creepers = new ArrayList();
  creepers.add(new Creep(color(random(0, 255), random(0, 255), random(0, 255)), mappedx, mappedy, 100.0));
  
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();
}

void draw() {
  frameRate(60);

  pushMatrix();
  opencv.loadImage(video);
  scale(-1, 1);
  translate(-video.width, 0);
  image(video, 0, 0);
  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();

  println(faces.length);

  for (int i = 0; i < faces.length; i++) {
    println(faces[i].x + "," + faces[i].y);
    //uncomment to draw face rectangles for debugging:
    //rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    facex = faces[i].x;
    facey = faces[i].y;
    overshootx = faces[i].width/2;
    overshooty = faces[i].height/2;
    creepx = facex+overshootx;
    creepy = facey+overshooty;

    scale(-1, 1);
    translate(video.width*2, 0);
    mappedx = map(facex, 110, 180, 0, width);
    mappedy = map(facey, 20, 70, 0, height);
  }

  scale(-1, 1);
  translate(-video.width, 0);

  for (int i = creepers.size ()-1; i >=0; i--) {

    Creep creep = (Creep) creepers.get(i);

    creep.display();
    creep.follow();
  }

  popMatrix();
}

void mousePressed() {
  creepers.add(new Creep(color(random(0, 255), random(0, 255), random(0, 255)), 0, 0, 100.0));
}

void keyPressed() {

  if (key == ' ') {

    for (int i = creepers.size ()-1; i >=0; i--) {

      creepers.remove(i);

      if (backgroundcounter == 0) {
        background(eagledots);
        backgroundcounter++;
      } else if (backgroundcounter == 1) {
        background(sealdots);
        backgroundcounter++;
      } else {
        background(catdots);
        backgroundcounter=0;
      }
    }

    creepers.add(new Creep(color(random(0, 255), random(0, 255), random(0, 255)), 0, 0, 100.0));
  }
}

void captureEvent(Capture c) {
  c.read();
}
