//class for creepy drawers that follow your face

class Creep {

  color c;
  float xpos;
  float ypos;
  float followspeed;

  Creep(color tempC, float tempXpos, float tempYpos, float tempfollowspeed) {

    c = tempC;
    xpos = tempXpos;
    ypos = tempYpos;
    followspeed = tempfollowspeed;
  }

  void display() {
    //draws creep on screen
    noStroke();
    fill(c);
    ellipse(xpos, ypos, 20, 20);
  }

  void follow() {
    //tells creep to follow faces
    xpos = xpos + ( mappedx - xpos)/followspeed;
    ypos = ypos + ( mappedy - ypos)/followspeed;
  }
}
