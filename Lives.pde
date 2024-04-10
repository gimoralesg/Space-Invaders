class Lives {
  
  int lives;
  
  Lives(){
    lives = 3;
  }
  
  
  
  void display(){
    noStroke();
    fill(0,255,0);
    
    if(lives <= 0){
      fill(155);
    }
    rect(520,30,30,10);
    rect(520,28,25,10);
    rect(520,25,10,10);
    rect(520,20,5,5);
    
    if(lives == 1){
      fill(155);
    }
    rect(560,30,30,10);
    rect(560,28,25,10);
    rect(560,25,10,10);
    rect(560,20,5,5);
    
    if(lives == 2){
      fill(155);
    }
    rect(600,30,30,10);
    rect(600,28,25,10);
    rect(600,25,10,10);
    rect(600,20,5,5);
  }
}
