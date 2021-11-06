class Button{
  private float x,y;
  private String name;
  private boolean clicked;
  int w = 50;
  int h = 20;
  color hue;
  public Button(String name,float x, float y,color hue) {
    super();
    this.name = name;
    this.x = x;
    this.y = y;
    this.clicked = false;
    this.hue = hue;
  }
  
  public Button(String name,float x, float y) {
    super();
    this.name = name;
    this.x = x;
    this.y = y;
    this.clicked = false;
    this.hue = #1A3916;
  }
  
  public Button(String name,float x, float y,int w,int h) {
    super();
    this.name = name;
    this.x = x;
    this.y = y;
    this.clicked = false;
    this.w = w;
    this.h = h;
    this.hue = #1A3916;
  }
  
  public Button(String name,float x, float y,int w,int h,color hue) {
    super();
    this.name = name;
    this.x = x;
    this.y = y;
    this.clicked = false;
    this.w = w;
    this.h = h;
    this.hue = hue;
  }
  
  void display(){
    drawButton();
  }
  
  void drawButton(){
    fill(hue);
    stroke(palette[9]);
    strokeWeight(2);
    
    rectMode(CENTER);
    rect(x,y,w,h,5);
    
    textSize(8+h/10);
    fill(palette[4]);
    textAlign(CENTER);
    text(name,x,y);
    highlight();
    
  }
  
  boolean mouseOver(){
    return mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 && mouseY <y+h/2;
  }
  public boolean isOver(float x,float y){
    if(x > this.x-w/2 && x < this.x+w/2 && y > this.y-h/2 && y <this.y+h/2){
      return true;
    }
    return false;
  }
  void highlight(){
    if(mouseOver()){
      fill(#FFFFFF,50);
      rectMode(CENTER);
      rect(x,y,w,h,5);
    }
  }
  
  public void setHue(color hue){
      this.hue = hue;
  } 
  
  public String getN() {
    return name;
  }
  public void setN(String name) {
    this.name = name;
  }
  public float getX() {
    return x;
  }
  public void setX(float x) {
    this.x = x;
  }
  public float getY() {
    return y;
  }
  public void setY(float y) {
    this.y = y;
  }
  public boolean isClicked() {
    return clicked;
  }
  public void setClicked(boolean clicked) {
    this.clicked = clicked;
  }
  @Override
  public String toString() {
    return "Button [x=" + x + ", y=" + y + ", clicked=" + clicked + "]";
  }  
}
