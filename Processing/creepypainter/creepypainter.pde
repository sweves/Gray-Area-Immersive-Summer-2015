// create trippy paintings
// WITH CREEPER DOTS THAT HAVE MINDS OF THEIR OWN
//
//


//initialize creeper array and number of creepers
int countCreeps = 1;
ArrayList creepers;


void setup() {

  size(1200, 700);

  background(255);

  //Create an array to hold creepy painters and start with one on the screen
  creepers = new ArrayList();
  creepers.add(new Creep(color(random(0, 255), random(0, 255), random(0, 255)), mouseX, mouseY, random(0.1, 50.0), random(0.1, 50.0)));
}

void draw() {

  //drawing and animating each creep stored in the array
  for (int i = creepers.size ()-1; i >=0; i--) {
    Creep creep = (Creep) creepers.get(i);
    creep.display();
    creep.follow();
  }
}

void mousePressed() {
  //add another creep painter every time you click
  creepers.add(new Creep(color(random(0, 255), random(0, 255), random(0, 255)), mouseX, mouseY, random(0.1, 50.0), random(0.1, 50.0)));
}

void keyPressed() {

  //when space bar is pressed clear the screen and start with a new creep
  if (key == ' ') {

    for (int i = creepers.size ()-1; i >=0; i--) {
      //empty array
      creepers.remove(i);

      background(255);

      creepers.add(new Creep(color(random(0, 255), random(0, 255), random(0, 255)), mouseX, mouseY, random(0.1, 50.0), random(0.1, 50.0)));
    }
  }
}
