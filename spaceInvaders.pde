//nave
Ship player;
//sesion visual
//https://www.youtube.com/watch?v=biN3v3ef-Y0&t=246s
//https://www.youtube.com/watch?v=_k_yRbUeVxY
//https://www.youtube.com/watch?v=LnUFoviIQIM
//https://www.youtube.com/watch?v=4JzDttgdILQ&t=7397s
//chatgpt, snake en p5 editor
//https://classroom.google.com/c/NjI4NTcwMDQ1MTUw

ArrayList

//invader
int numInvaders = 9;
int invaderWidth = 30;
int invaderHeight = 30;
int invaderSpeed = 3;
int[] invaderX = new int[numInvaders];
int[] invaderY = new int[numInvaders];



void setup() {
  size(800, 700);

  //pos nave
  player = new Ship(width / 2, height - 40);
}

void draw() {
  background(0);
  player.render();
}

void keyPressed(){
  if(keyCode == LEFT){
    player.dir(-5);
  }else if(keyCode == RIGHT){
    player.dir(5);
  }
}


void invader() {
  fill(0, 255, 0);
  for (int i = 0; i < numInvaders; i++) {
    rect(invaderX[i], invaderY[i], invaderWidth, invaderHeight);
  }
}




class Ship {

  PVector pos, vel;
  int lifespan;
  int shipWidth = 40;
  int shipHeight = 20;
  color col = color(255);

  Ship(float x, float y) {
    this.pos = new PVector(x, y);
  }

  void dir(int dx) {
    pos.x += dx;
    //if (x != -this.vel.x || y != -this.vel.y) {
      //this.vel.x = x;
      //this.vel.y = y;
    //}
  }

  void render() {
    fill(col);
    rectMode(CENTER);
    rect(pos.x, pos.y, shipWidth, shipHeight);
  }
}


class Invader {
  PVector pos;
  int invaderWidth = 20;
  int invaderHeight = 20;
  color col = color(0,255,0);
  
  Invader(float x, float y){
    this.pos = new PVector(x, y);
  }
  
  void render(){
    fill(col);
    rectMode(CENTER);
    rect(pos.x, pos.y, invaderWidth, invaderHeight);
  }
  
  void dir(float dx, float dy){
    pos.x += dx;
    pos.y += dy;
  }
}




//movimiento
void naveMove() {
  if (keyPressed) {
    if (keyCode == LEFT) {
      //naveX -= naveSpeed;
    } else if (keyCode == RIGHT) {
      //naveX += naveSpeed;
    }
  }
  //limitador
  //naveX = constrain(naveX, 20, width - naveWidth/2);
}

void invaderMove() {
  for (int i=0; i<numInvaders; i++) {
    invaderX[i] += invaderSpeed;

    //if(invaderX[i] > width - invaderWidth || invaderX[i] < 0){
    //invaderSpeed *= -1;
    //for(int j=0; j < numInvaders; j++){
    //invaderY[j] += 10;
    //}
    //}
  }
}
