class Bullet{
  float x, y, vel;
  
  Bullet(float posx, float posy) {
    this.x = posx;
    this.y = posy;
    this.vel = 3;
  }
  
  //void update(){
  //  y -= vel; 
  //}
  void move(){
    y -= vel; 
  }
  void drop(){
    y += vel; 
  }
  
  void display() {
    fill(255);
    rectMode(CENTER);
    rect(x, y, 4, 4);
  }
  
  boolean offscreen() {
    return (y < 0);
  }
  
  boolean hitInvader(Invader inv) {
    float diam = dist(x, y, inv.pos.x, inv.pos.y);
    return (diam < inv.invaderWidth/2 && diam < inv.invaderHeight/2);
  }
  
  boolean hitPlayer(Ship player) {
    float diam = dist(x, y, player.pos.x, player.pos.y);
    return (diam < player.shipWidth/2 && diam < player.shipHeight/2);
  }
}
