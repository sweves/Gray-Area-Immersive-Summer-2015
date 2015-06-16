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

//intialize positioning variables
float mappedx, mappedy;

//initialize connect the dots backgrounds and variable to keep track of what background you're on
PImage catdots;
PImage eagledots;
PImage sealdots;
int backgroundcounter;

void setup() {

  size(1680, 1050);
  
  //load images to be later used as backgrounds
  catdots = loadImage("cat.png");
  eagledots = loadImage("eagle.png");
  sealdots = loadImage("seal.png");
  
  //start counter at 0 and the cat background first
  backgroundcounter = 0;
  background(catdots);
  
  //Create an array to hold creepy painters and start with one on the screen
  creepers = new ArrayList();
  creepers.add(new Creep(color(random(0, 255), random(0, 255), random(0, 255)), mappedx, mappedy, 100.0));
  
  //start to capture video and opencv, load face recognition files
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  video.start();
}

void draw() {
  
  frameRate(60);
  
  //mirror video
  pushMatrix();
  opencv.loadImage(video);
  scale(-1, 1);
  translate(-video.width, 0);
  image(video, 0, 0);
  
  //intialize array to store face locations
  Rectangle[] faces = opencv.detect();
  println(faces.length);

  //cycle through any faces on the screen
  for (int i = 0; i < faces.length; i++) {
    println(faces[i].x + "," + faces[i].y);
    //uncomment to draw face rectangles for debugging:
    //stroke(0, 255, 0);
    //strokeWeight(3);
    //noFill();
    //rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    
    //adjust position of where the creep will draw on the screen in relation to where it detects a face
    scale(-1, 1);
    translate(video.width*2, 0);
    mappedx = map(faces[i].x, 110, 180, 0, width);
    mappedy = map(faces[i].y, 20, 70, 0, height);
  }
  
  //translate back
  scale(-1, 1);
  translate(-video.width, 0);
  
  //drawing and animating each creep stored in the array
  for (int i = creepers.size ()-1; i >=0; i--) {
    Creep creep = (Creep) creepers.get(i);
    creep.display();
    creep.follow();
  }

  popMatrix();
}

void mousePressed() {
  //add another creep painter every time you click
  creepers.add(new Creep(color(random(0, 255), random(0, 255), random(0, 255)), 0, 0, 100.0));
}

void keyPressed() {
  
  //when space bar is pressed clear the screen and give new dot pattern/new creep
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
  //start webcam capture
  c.read();
}
