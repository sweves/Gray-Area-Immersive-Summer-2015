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

    noStroke();
    fill(c);
    ellipse(xpos, ypos, 20, 20);
  }

  void follow() {

    xpos = xpos + ( mappedx - xpos)/followspeed;
    ypos = ypos + ( mappedy - ypos)/followspeed;
  }
}
