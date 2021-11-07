class Square{
  float x,y;
  int w,h;
  boolean isWall,isPlayer,isTarget,horTP,verTP,isSwitch,switchWall,isPlayer2,turrentH,turrentV;
  Square tpSquare;
  ArrayList<Square> switchWalls = new ArrayList<Square>();
  Square(float x,float y,int w,int h){
    this.x= x;this.y = y;
    this.w =w; this.h = h;
    isWall = false;
    if(x/30 == 0 || y/30 == 0 || x/30 == 39 || y/30 == 26){
      this.isWall = true;
    }
    horTP = false;
    verTP = false;
    isSwitch = false;
    tpSquare = null;
    isPlayer2 = false;
    turrentH = false; turrentV = false;
  }
  void setVer(boolean v){
    this.verTP = v;
  }
  void setWall(boolean b){
     this.isWall =  b;
  }
    void setPlayer(boolean b){
     this.isPlayer =  b;
  }
  void setTarget(boolean b){
     this.isTarget =  b;
  }
  void setHor(boolean v){
    this.horTP = v;
  }
  void addWallToSwitch(Square wall){
    this.switchWalls.add(wall);
  }
  void setNode(Square node){
    this.tpSquare = node;
    if(this.verTP){
      node.setVer(true);
    }else{
      node.setHor(true);
    }
    if(node.tpSquare == null){
      node.setNode(this);
    }
    System.out.println(this);
    return;
  }
  void display(){
    rectMode(CORNER);
    if(isWall){
        strokeWeight(1);
        stroke(0);
        fill(palette[0]);
    }
    else if(isPlayer){
        strokeWeight(1);
        stroke(0);
        fill(palette[1]);
    }else if(isPlayer2){
      strokeWeight(1);
      stroke(0);
      fill(palette[1]);
    }else if(isTarget){
        fill(palette[8]);
    }else if(verTP){
      fill(palette[3]);
    }else if(horTP){
      fill(palette[3]);
    }else if(isSwitch){
      fill(palette[7]);
    }else if(switchWall){
      fill(palette[0]);
    }
    else if(turrentH || turrentV){
      fill(palette[9]);
    }
    else{
      if(switchMode){
        fill(palette[5]);
      }else{
        fill(palette[4]);
      }
    }
     rect(x,y,w,h);
     if(verTP){
       fill(palette[0]);
       rect(this.x,this.y + 5,30,20);
     }else if(horTP){
        fill(palette[0]);
       rect(this.x + 5,this.y,20,30);
     }
     //textAlign(CENTER);
     //fill(0);
     //text((int)x/30 + "," + (int)y/30,this.x+15,this.y+15);
    if(mouseOver()){
      fill(#FFFFFF,50);
      rect(x,y,30,30);
    }
    if(mouseOver() && mousePressed){
      if(mouseButton == RIGHT){
        isPlayer = true;
      }else if(!switchMode){
        isWall = true;
      }
      if(mouseButton == LEFT && switchMode){
        switchWall = true;
        switchSquare.addWallToSwitch(this);
      }
    }
    if(mouseOver() && keyPressed){
      if(key == 'e' || key == 'E'){
        isTarget = true;
      }else if(keyCode == LEFT){
        //this = new Square(this.x,this.y,30,30);
        if(isSwitch){
          this.switchWalls.clear();
        }
        isTarget = false;
        isPlayer = false;
        isPlayer2 = false;
        isWall = false;
        horTP = false;
        verTP = false;
        turrentV = false;
        turrentH = false;
        isSwitch = false;
        switchWall = false;
        tpSquare = null;
      }else if(key == 'w' || key == 'W'){
        this.verTP = true;
        if(currTPNode == null){
          currTPNode = this;
        }else{
          currTPNode.setNode(this);
          currTPNode = null;
        }
        keyPressed = false;
      }else if(key == 'a' || key == 'A'){
        this.horTP = true;
        if(currTPNode == null){
          currTPNode = this;
        }else{
          currTPNode.setNode(this);
          currTPNode = null;
        }
        keyPressed = false;
      }else if(key == 's' || key == 'S'){
        isSwitch = true;
        switchMode = true;
        switchSquare = this;
      }else if(key == 'd' || key == 'D'){
        switchMode = false;
        switchSquare = null;
      } else if(key == '1'){
        isPlayer2 = true;
      }else if(key == 't' || key == 'T'){
        turrentH = true;
      }
      else if(key == 'y' || key == 'Y'){
        turrentV = true;
      }
    }
  }
  String toString(){
    return "node[" + this.x/30 +"][" + this.y/30 +"]\nTPnode[" + tpSquare.x/30 + "][" + tpSquare.y/30 +"]";
  }
  float getX(){
    return this.x;
  }float getY(){
    return this.y;
  }
  boolean mouseOver(){
    return mouseX >= x && mouseX <= x+30 && mouseY >= y &&mouseY <= y+30;
  }
}
