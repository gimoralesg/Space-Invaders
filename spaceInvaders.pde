//- game over invader toca a jugador
//- efectos de sonido
//- game Win message

Ship player;
PImage invaderImg;
PFont arcadeClassic;
Lives playerLives = new Lives();
ArrayList<Invader> invaders = new ArrayList<Invader>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<Bullet> invaderBullets = new ArrayList<Bullet>();
int invaderShotInterval = 1500; // tiempo para disparos de los invaders
int lastInvaderShot = 0; // Tiempo de ultimo disparo de invader
int score=0;


void setup() {
  size(640, 480);
  
  //Font
  arcadeClassic = createFont("space_invaders.ttf",64);
  textFont(arcadeClassic);  
  
  //pos nave
  player = new Ship(width/2 , height - 40);
  
  //img = loadImage("img/imvader");
  
  for(int i=0; i<11; i++){
    for(int j=0; j<3; j++){
      invaders.add(new Invader(i*50+50,j*40+60));
    }
  }
}

void draw() {
  background(0);
  
  
  //score
  fill(255);
  textSize(20);
  text("Score: " + score, 10,20);
  //text("FPS: " + frameRate, 200, 20);
            
  //Ship
  player.display();
  player.move();
  player.checkWallColision();
  playerLives.display();
  
  //Invaders
  moveInvaders();
  displayInvaders();

  //stroke(0); 
  //strokeWeight(1);

  displayBullets();  
  invaderGenerarBullets();
}










void displayInvaders() {
  for (Invader invader : invaders) {
    invader.updatePos();
    invader.display();
  }
}


void displayBullets(){
  for (int i = bullets.size()-1; i >= 0; i--) {
    Bullet bul = bullets.get(i);
    bul.move();
    bul.display();
    
    if (bul.offscreen()) {//bullet fuera de la pantalla
      bullets.remove(i);
    } else {
      // Comprobar colisión con invaders
      for (int j = invaders.size()-1; j >= 0; j--) {
        Invader inv = invaders.get(j);
        if (bul.hitInvader(inv)) {
          invaders.remove(j);
          bullets.remove(i);
          score += 10;
          break;
        }
      }
    }
  }
}


void invaderGenerarBullets(){
  for (int i = invaderBullets.size()-1; i >= 0; i--) {
    Bullet bul = invaderBullets.get(i);
    bul.drop();
    bul.display();
    
    if (bul.offscreen()) {
      invaderBullets.remove(i);//remover bullet si sale de pantalla
    } else {
      if(bul.hitPlayer(player)){
        invaderBullets.remove(i);//si impacta jugador reiniciar
        println("muerto");
        playerHit();
        break;
      }
    }
  }
  // Invader bullets aleatorios
  genRandBullets();

}


void moveInvaders(){
  boolean colisionRight = false;
  boolean colisionLeft = false;
  for (Invader inv : invaders) {
    if (inv.pos.x + inv.velX   > width) {  //pared derecha
      colisionRight=true;
      break;
    }
    if (inv.pos.x + inv.velX < 0) {  // pared izquierda
      colisionLeft=true;
      break;
    }
  }

  if (colisionRight == true) {
    for (Invader inv : invaders) {
      inv.moveLeft();
      inv.moveDown();
    }
  }

  if (colisionLeft == true) {
    for (Invader inv : invaders) {
      inv.moveRight();
      inv.moveDown();
    }
  }
}

void playerHit(){
  
  playerLives.lives --;

  if(playerLives.lives <= 0){
    fill(0,255,0);
    textSize(40);
    textAlign(CENTER);
    text("Game Over", width/2, height/2);
    noLoop();
    resetGame();
  } 
}

void genRandBullets(){
  if (millis() - lastInvaderShot > invaderShotInterval) {
    println(millis());
    int invaderIndex = int(random(invaders.size())); 
    Invader inv = invaders.get(invaderIndex); //selecciona random invader
      
 
    Bullet bul = new Bullet(inv.pos.x, inv.pos.y + inv.invaderHeight/2);
    invaderBullets.add(bul);
    lastInvaderShot = millis();
  }
}

//----------------------------

void keyPressed(){
  if(keyCode == LEFT){
    player.isMovingLeft = true;
  }
  if(keyCode == RIGHT){
    player.isMovingRight = true;
  } 
  if (key == ' ') {
    Bullet bul = new Bullet(player.pos.x, player.pos.y - player.shipHeight/2);
    bullets.add(bul);
  }
  if(keyCode == 'R'){
    System.out.print("Reset"); 
    loop();
    //resetGame();
  }
  
}


void keyReleased(){
  if(keyCode == LEFT){
    player.isMovingLeft = false;
  }
  if(keyCode == RIGHT){
    player.isMovingRight = false;
  } 
}


void resetGame() {
  //loop();
  playerLives.lives = 3;
  player = new Ship(width/2 , height - 40);
  invaders.clear();
  bullets.clear();
  invaderBullets.clear();
  score = 0;
  lastInvaderShot = 0;
 
  
  for(int i=0; i<11; i++){
    for(int j=0; j<3; j++){
      invaders.add(new Invader(i*50+50,j*40+60));
    }
  }
}
