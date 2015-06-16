//class for creepy drawers that follow your mouse

class Creep {

  color c;
  float xpos;
  float ypos;
  //give x and y different follow speeds so slightly more unpredictable
  float followx;
  float followy;

  Creep(color tempC, float tempXpos, float tempYpos, float tempfollowx, float tempfollowy) {

    c = tempC;
    xpos = tempXpos;
    ypos = tempYpos;
    followx = tempfollowx;
    followy = tempfollowy;
  }

  void display() {
    //draws creep on screen
    noStroke();
    fill(c);
    ellipse(xpos, ypos, 20, 20);
  }

  void follow() {
    //tells creep to follow mouse
    xpos = xpos + ( mouseX - xpos)/followx;
    ypos = ypos + ( mouseY - ypos)/followy;
  }
}
