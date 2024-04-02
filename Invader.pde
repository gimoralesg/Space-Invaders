PImage img1, img2;
class Invader {
  PVector pos;
  int invaderWidth;
  int invaderHeight;
  int invaderSpacing;
  int numRows;
  int numCols;
  color col = color(0,255,0);
  float left, right, top, bottom;
  boolean removed;
  float velX, velY;
  
  Invader(int x, int y){
    this.pos = new PVector(x, y);
    
    invaderWidth = 20;
    invaderHeight = 20;

    img1 = loadImage("img/invader.png");
    img2 = loadImage("img/invader1.png");
 //<>//
    
    removed = false;
    

    velX = 0;
    velY = 0;
    moveRight();
    
  }
  
  void display(){
    fill(col);
    //rectMode(CENTER);
    imageMode(CENTER);
    
    if(Math.round(frameCount/15 % 2) == 0){  
      image(img1, pos.x, pos.y);
    }else{
      image(img2, pos.x, pos.y);
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
}
