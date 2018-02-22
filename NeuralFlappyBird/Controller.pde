class Controller{
  float size = 50;
  float maxInterval = 3.5;
  float interval = 3.5;
  
  int gen = 0;
  float avgScore = 0;
  
  void init(){
    for(int i=0; i<maxBirds; i++){
      birds.add(new Bird(new PVector(200,200)));
    }
  
  }
  
  void update(){
    if((frameCount % (interval*60)) == 0){
      tubes.add(new Tube(width));
    }
    
    for (int i=0;i<tubes.size();i++) {
      tubes.get(i).update();
    }
    if((frameCount+1 % 40000)==0){
      restart();println("Restart");
    }
    for(int i=0; i<birds.size(); i++){
      birds.get(i).update();
    }
    
    fill(18,18,255);text("Generation: "+gen,20,35);text("Framerate: "+round(frameRate),20,80);text("Avg Score: "+avgScore,20,50);text("Birds: "+birds.size(),20,65);
    checker();
  }
  
  Tube getClosestTube(PVector pos){
    Tube close = new Tube(0);
    float clst = width;
    
    for (int i=0;i<tubes.size();i++) {
      float px = tubes.get(i).pos.x;
      float l = px - pos.x;
      if(l >= 0){
        if(l < clst) clst = px;
      }
    }
    
    for (int i=0;i<tubes.size();i++) {
      float px = tubes.get(i).pos.x;
      if(clst == px){
        close = tubes.get(i);
      }
    }
    
    return close;
  }
  
  
  void checker(){
    if((frameCount % 60) == 0) {
      boolean alldead = true;
      for(int i=0; i<birds.size(); i++){
        if(!birds.get(i).dead){
          alldead = false;
        }
      }
      if(alldead){
        restart();
      }
    }
  }
  
  void restart(){
    gen += 1;
    int avg = 0;
    for(int i=0;i<birds.size();i++){avg += birds.get(i).score;}
    avgScore = (avg/maxBirds);
    interval = maxInterval;
    
    Bird[] sorted = sortBirds();
    birds = new ArrayList<Bird>();
    for(int i=0; i<maxBirds/2; i++){
      int start = round(maxBirds/2)-1;
      birds.add(sorted[i+start]);
      //print(birds.get(i).score+",");
    }//println("...");
    for(int i=0; i<birds.size(); i++){birds.get(i).Brain = birds.get(i).Brain.Reproduce();}
    for(int i=0; i<(maxBirds/2); i++){
      Bird b = new Bird(new PVector(200,200));
      birds.add(b);
    }
    for(int i=0; i<birds.size(); i++){
      birds.get(i).dead = false;
      birds.get(i).score = 0; //<>//
      birds.get(i).pos = new PVector(200,200);
    }
    tubes = new ArrayList<Tube>();
  }

// 54,23,98,34,52,61,67
// 23,
Bird[] sortBirds(){
  Bird[] s = new Bird[birds.size()];
  int[] scores = new int[birds.size()];
  int[] IDs = new int[birds.size()];
  for(int i=0; i<birds.size(); i++){
    scores[i] = birds.get(i).score;
  }
  scores = reverse(sort(scores));
  for(int i=0; i<birds.size(); i++){
    for(int j=0; j<birds.size(); j++){
      boolean Dupe = false;
      for(int l=0; l<birds.size(); l++){
        if(birds.get(j).ID == IDs[l]) Dupe = true;
      }
      //if(!Dupe) print("NOT");
      if((scores[i] == birds.get(j).score) && (!Dupe)){
        s[i] = birds.get(j);
        //print(s[i].score+","); 
      }
    }
  }
  //println(".");  
  return s;
}
/*Bird[] sortBirds(){
  Bird[] s = new Bird[birds.size()];
  for(int j=0; j<birds.size(); j++){
    
    int lowestVal = 100000000;
    int lowestID = 0;
    int[] IDs = new int[birds.size()];
    boolean Dupe = false;
    for(int i=0; i<birds.size(); i++){
      IDs[i] = 0;
    }
    for(int i=0; i<birds.size(); i++){
      for(int l=0; l<birds.size(); l++){
        if(birds.get(i).ID == IDs[l]) Dupe = true;
      }
    }
    for(int i=0; i<birds.size(); i++){
      if((birds.get(i).score < lowestVal) && (!Dupe)) lowestID = birds.get(i).ID;
    }
    for(int i=0; i<birds.size(); i++){
      if(lowestID == birds.get(i).ID) s[j] = birds.get(i);
    }
    
  }
  return s;
}
*/
}