

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
  
  Invader(int x, int y){
    this.pos = new PVector(x, y);
    
    invaderWidth = 20;
    invaderHeight = 20;

    invaderimg0 = loadImage("img/invader.png");
    invaderimg1 = loadImage("img/invader1.png");
    invaderdead = loadImage("img/invaderexplosion.png");
 //<>//
    
    dead = false;
    

    velX = 0;
    velY = 0;
    moveRight();
    
  }
  
  void display(){
    fill(col);
    //rectMode(CENTER);
    imageMode(CENTER);
    
    if(dead){
      image(invaderdead, pos.x, pos.y);
    }else{   
      if(Math.round(frameCount/15 % 2) == 0){  
        image(invaderimg0, pos.x, pos.y);
      }else{
        image(invaderimg1, pos.x, pos.y);
      }
    }

    //rect(pos.x, pos.y, invaderWidth, invaderHeight);
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
    float diam = dist(pos.x, pos.y, player.pos.x, player.pos.y);
    return (diam < (invaderWidth + player.shipWidth) / 2 && diam < (invaderHeight + player.shipHeight) / 2);
  }
  
  void explode(){
    dead = true;
  }
}
