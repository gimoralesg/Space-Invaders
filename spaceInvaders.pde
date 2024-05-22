import processing.sound.*;
 
Ship player;
PImage img;
SoundFile backgroundMusic, playershoot, playerExplosion, playerDead, invaderDead, victory;
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
  
  //Sound
  playershoot = new SoundFile(this, "audio/PlayerShootSound.wav");
  playerExplosion = new SoundFile(this, "audio/PlayerExplosionSound.wav");
  playerDead = new SoundFile(this, "audio/playerdead1.wav");
  invaderDead = new SoundFile(this, "audio/invaderkilled.wav");
  victory = new SoundFile(this, "audio/victory.wav");
  backgroundMusic = new SoundFile(this, "audio/backgroundMusic.wav");
  backgroundMusic.loop();
  
  //img
  //explosionPlayerIMG = loadImage("img/playerexplosion.png");
  
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
  text("Score: " + score, 20,30);
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
  InvaderPlayerColision();
  
  checkGameWon();
}


void displayInvaders() {
  for (Invader invader : invaders) {
    invader.updatePos();
    invader.display();
  }
}


void displayBullets() {
  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet bul = bullets.get(i);
    bul.move();
    bul.display();

    if (bul.offscreen()) { // bullet fuera de la pantalla
      bullets.remove(i);
    } else {
      // Comprobar colisión con invaders
      for (int j = invaders.size() - 1; j >= 0; j--) {
        Invader inv = invaders.get(j);
        if (bul.hitInvader(inv)) {
          inv.explode();
          invaderDead.play();
          bullets.remove(i);
          score += 10;
          break;
        }
      }
    }
  }

  // Remove invaders
  for (int j = invaders.size() - 1; j >= 0; j--) {
    Invader inv = invaders.get(j);
    if (inv.isDeath()) {
      invaders.remove(j);
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
        player.explode();
        playerExplosion.play();
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

void InvaderPlayerColision(){
 for (Invader inv : invaders) {
    if (inv.hitPlayer(player)) {
      playerHit();
      break; 
    }
  }
}


void playerHit(){  
  playerLives.lives --;

  if(playerLives.lives <= 0){
    playerDead.play();
    backgroundMusic.pause();
    fill(0,255,0);
    textSize(40);
    textAlign(CENTER);
    text("Game Over", width/2, height/2);
    textSize(12);
    text("Presiona 'r' para reiniciar", width/2, height/2 + 50);
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
    playershoot.play();
    bullets.add(bul);
    
  }
  if(keyCode == 'R' ||  keyCode == 'r' ){
    System.out.print("Reset"); 
    loop();
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


void checkGameWon() {
  if (invaders.isEmpty()) {
    if(backgroundMusic.isPlaying()){
      backgroundMusic.pause();
    }
    fill(0,255,0);
    textSize(40);
    textAlign(CENTER);
    victory.play();
    backgroundMusic.pause();
    text("GANASTE!!!", width/2, height/2 - 20);
    textSize(12);
    text("Presiona R para volver a jugar", width/2, height/2 + 20);
    noLoop();
    resetGame();
  }
}

void resetGame() {
  //loop();
  textAlign(LEFT);
  playerLives.lives = 3;
  player = new Ship(width/2 , height - 40);
  invaders.clear();
  bullets.clear();
  invaderBullets.clear();
  score = 0;
  lastInvaderShot = 0;
  backgroundMusic.loop();
 
  
  for(int i=0; i<11; i++){
    for(int j=0; j<3; j++){
      invaders.add(new Invader(i*50+50,j*40+60));
    }
  }
}
