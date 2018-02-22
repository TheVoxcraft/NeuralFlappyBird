class Tube{
  
  float gap = 350;
  float tWidth = 40;
  float tubeSpeed = 2;
  
  PVector pos;
  float randOffset;
  
  Tube(float x){
    pos = new PVector(0, 0);
    pos = new PVector(x,0);
    randOffset = round(random(50,height-gap));
  }
  
  void update(){
    fill(#6EDB4B);
    noStroke();
    rect(pos.x,0, tWidth, randOffset);
    rect(pos.x,randOffset+gap, tWidth, height-(randOffset+gap));
    
    pos.x -= tubeSpeed;
  }
  
  boolean isColl(PVector p){
    boolean touch = false;
    
    if(p.x>=pos.x && p.x < (pos.x+tWidth)){
      touch = true;
    }
    
    if(p.x>=pos.x && p.x < (pos.x+tWidth)){
      if(p.y>randOffset && p.y < (randOffset+gap)){
        touch = false;
      }
    }
    
    return touch;
  }


}