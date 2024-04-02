class Ship {

  PVector pos;
  int lifespan; 
  int vel;
  int shipWidth;
  int shipHeight;
  color col = color(255);
  boolean isMovingLeft;
  boolean isMovingRight;

  Ship(int x, int y) {
    this.pos = new PVector(x, y);
    
    shipWidth = 40;
    shipHeight = 20;
    
    isMovingLeft = false;
    isMovingRight = false;
    
    vel = 3;
  }


  //funcs
  void display() {
    fill(col);
    noStroke();
    rectMode(CENTER);
    rect(pos.x,pos.y,30,10);
    rect(pos.x,pos.y-3,25,10);
    rect(pos.x,pos.y-5,10,10);
    rect(pos.x,pos.y-10,5,5);
    //rect(pos.x, pos.y, shipWidth, shipHeight);
  }
  
  void move() {
    if(isMovingLeft == true){
      pos.x -= vel;
    }
    if(isMovingRight == true){
      pos.x += vel;
    }
  }
  
  void checkWallColision(){
    if (pos.x - shipWidth/2 < 0) {
      pos.x = shipWidth/2;
    }
    if (pos.x + shipWidth/2 > width) {
      pos.x = width - shipWidth/2;
    }
  }
  
}
