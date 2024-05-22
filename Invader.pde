

class Invader {
  PVector pos;
  int invaderWidth;
  int invaderHeight;
  int invaderSpacing;
  int numRows;
  int numCols;
  PImage invaderimg0, invaderimg1, invaderdead;
  color col = color(0,255,0);
  float left, right, top, bottom;
  float velX, velY;
  boolean dead;
  int deadtime;
  int explosionstartime;
  
  Invader(int x, int y){
    this.pos = new PVector(x, y);
    
    invaderWidth = 20;
    invaderHeight = 20;

    invaderimg0 = loadImage("img/invader.png");
    invaderimg1 = loadImage("img/invader1.png");
    invaderdead = loadImage("img/invaderexplosion.png");
    
    dead = false;
    deadtime = 300;

    velX = 0;
    velY = 0;
    moveRight();
    
  }
  
  void display(){
    fill(col);
    imageMode(CENTER);
    
    //println("dead = false");
    if(dead){
      if(millis() - explosionstartime < deadtime){
        image(invaderdead, pos.x, pos.y);
      }
      //println("a");
    }else{
      isAlive();
    } 
  }
  
  void updatePos() {
    pos.x += velX;
    pos.y += velY;   
  }
  void moveRight(){
    velX =+ 1; 
  }
  void moveLeft(){
    velX =- 1;
  }
  void moveDown(){
    pos.y += 10;
  }
  
  boolean hitPlayer(Ship player) {
    float diam = dist(pos.x, pos.y, player.pos.x, player.pos.y); //<>//
    return (diam < (invaderWidth + player.shipWidth) / 2 && diam < (invaderHeight + player.shipHeight) / 2);
  }
  
  void isAlive(){
    if(Math.round(frameCount/15 % 2) == 0){  
      image(invaderimg0, pos.x, pos.y);
    }else{
      image(invaderimg1, pos.x, pos.y);
    }
  }
  
  boolean isDeath(){
    if(dead && millis() - explosionstartime > deadtime){
      return true;
    }
    return false;
  }
   //<>//
  void explode(){
    explosionstartime = millis();
    dead = true;
    //println("dead = true");
  }
}
