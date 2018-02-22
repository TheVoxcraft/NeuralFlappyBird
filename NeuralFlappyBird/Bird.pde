class Bird{
  
  float gravity = .5;
  float jump = 20;
  float terminalVel = 10;
  
  public PVector pos, acc, vel;
  boolean dead = false;
  int score = 0;
  int ID = round(random(1,10000));
  
  Network Brain = new Network();
  
  Bird(PVector sPos){
    pos = new PVector(0, 0);
    pos = sPos;
    
    acc = new PVector(0, 0);
    vel = new PVector(0, 0);
  }
  
  void update(){
    fill(255);
    stroke(255,200,200);
    //noStroke();
    if(dead){ fill(255,0,0);}
    
    if(!dead){ellipse(pos.x,pos.y, Control.size,Control.size);}
    
    updatePhy();
    addForce(new PVector(0,gravity)); //gravity
    
    for (int i=0;i<tubes.size();i++) {
      if(tubes.get(i).isColl(pos)) dead = true;
    }
    
    if(!dead){ updateBrain(); score += 1;}
    
    //debug();
  }
  
  void updatePhy(){
    vel.add(acc);
    pos.add(vel);
    if(vel.mag() > terminalVel ){
      vel.limit(terminalVel);
    }
    acc.mult(0);
    
    collCheck();
  }
  
  int brainUpdateRate = 7;
  void updateBrain(){
    if((frameCount % brainUpdateRate) == 0){
      float location = map(pos.y,0,height,-1,1);
      Tube c = Control.getClosestTube(pos);
      float toTube = map((c.pos.x-pos.x),0,width-200,-1,1);
      float aim = map(c.randOffset+(c.gap/2),0,width-200,-1,1);
      float[] inputs = {location, toTube, aim};
      float[] out = Brain.run(inputs);
      
      if(out[0] > 0){
        Jump();
      }
    }
  }
  
  void collCheck(){
    if(pos.y >= height){
      //dead = true;
      vel.mult(0);
    }
    if(pos.y < 0){
      //dead = true;
      vel.mult(0);
    }
    
  }
  
  void addForce(PVector f){
    acc.add(f);
    
  }
  
  int lastJump = 0;
  float jumpCooldown = 10; //miliseconds
  void Jump(){
    if((frameCount-lastJump) >= (jumpCooldown/16.6666)){
      if(!dead){
        addForce(new PVector(0,-jump));
        lastJump = frameCount;
      }
    }
  }
  
  
  void debug(){
    Tube c = Control.getClosestTube(pos);
    fill(18,255,18);
    stroke(18,20,255);
    text("Pos: "+pos.x+", "+pos.y, 20, 20);
    text("toTube: "+(c.pos.x-pos.x), 20, 35);
    text("Aim: "+c.randOffset+(c.gap/2), 20, 50);
    line(pos.x, pos.y, c.pos.x, c.pos.y);
    line(pos.x, pos.y, c.pos.x, c.randOffset+(c.gap/2));
  }
}