ArrayList<Tube> tubes = new ArrayList<Tube>();
ArrayList<Bird> birds = new ArrayList<Bird>();
Controller Control = new Controller();

int maxBirds = 200;

void setup(){
  size(800,800);
  frameRate(12000);
  randomSeed(0);
  
  Control.init();
}


void draw(){
  background(#AAFBFF);
  Control.update();
  
}