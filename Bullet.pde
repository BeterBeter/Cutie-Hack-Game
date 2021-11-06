class Bullet{
  private float x,y,rise,run,r;
  private float speed,distance;
  int numBounces;
  boolean enemy,dead;
  Bullet(float x, float y,float r){
    this.x = x;this.y = y;
    this.run = mouseX - this.x; this.rise = mouseY - this.y;
    this.r = r;
    speed = 4;
    this.distance = (float)Math.sqrt(Math.pow(mouseX-x,2) + Math.pow(mouseY-y,2));
    enemy = false;
    dead = false;
  }
  Bullet(float x, float y,float r,float x2, float y2){
    this.x = x;this.y = y;
    this.run = x2 - this.x; this.rise = y2 - this.y;
    this.r = r;
    speed = 4;
    this.distance = (float)Math.sqrt(Math.pow(x2-x,2) + Math.pow(y2-y,2));
    enemy = true;
    dead = false;
  }
  void setX(float x){
    this.x = x;
  }
  void setY(float y){
    this.y = y;
  }
  void inverseRise(){
    this.rise *= -1;
    numBounces++;
  }
  void inverseRun(){
    this.run *= -1;
    numBounces++;
  }
  void display(){
    if(enemy){
      fill(palette[9]);
    }else{fill(palette[2]);}
    ellipse(this.x,this.y,this.r,this.r);
    move();
    if(keyPressed && key == 't'){
        this.run = mouseX - this.x; this.rise = mouseY - this.y;
        this.distance = (float)Math.sqrt(Math.pow(mouseX-x,2) + Math.pow(mouseY-y,2));
    }
    collideWithEnemy();
  }
  void move(){
    this.x += run * (1.0/distance * speed);
    this.y += rise * (1.0/distance * speed);
  }
  void collideWithEnemy(){
     for(int i = 0 ; i < bullets.size(); i++){
        if(intersects(this.x,this.y,this.r,bullets.get(i).x,bullets.get(i).y,bullets.get(i).r)){
          if(!this.enemy && bullets.get(i).enemy){
            this.dead = true;
            bullets.get(i).dead = true;
            fill(#FFFFFF);
            ellipse(this.x,this.y,100,100);
          }
        }
     }
  }
  
}
