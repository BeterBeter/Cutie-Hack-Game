class Node{
  private float x,y,distance,r;
  float s1,s2,i1,i2;
  float[][] points = new float[8][2];
  private boolean isWall,isPlayer,isTarget,verTP,horTP,isSwitch,switchWall,isPlayer2,turrentH,turrentV;
  Node tpNode;
  ArrayList<Node> switchWalls = new ArrayList<Node>();
  int turrentClock = 0;
  int turrentHealth = 50;
  Node(float x,float y){
    this.x = x;
    this.y = y;
    isWall = false;
    isPlayer = false;
    isTarget = false;
    if(x/nodeSize == 0 || y/nodeSize == 0 || x/nodeSize == width/nodeSize - 1 || y/nodeSize == height/nodeSize - 1){
      this.isWall = true;
    }
    s1 = -1;
    s2 = 1;
    i2 = this.y - ((this.x + nodeSize)*s2);
    i1 = (this.y) - ((this.x)*s1);
    r = 5;
    tpNode = null;
    verTP = false;
    horTP = false;
    isSwitch = false;
    switchWall = false;
    isPlayer2 = false;
  } 
  void VerTurrent(boolean b){
    turrentV = b;
  } 
  void HorTurrent(boolean b){
    turrentH = b;
  }
  void addWallToSwitch(Node wall){
    switchWalls.add(wall);
  }
  void setSwitch(boolean s){
     this.isSwitch = s; 
  }
  void setSwitchWall(boolean s){
     this.switchWall = s; 
  }
    void setVer(boolean v){
    this.verTP = v;
  }
  void setHor(boolean v){
    this.horTP = v;
  }
  void setPlayer2(boolean b){
     this.isPlayer2 = b; 
  }
  void setNode(Node node){
    this.tpNode = node;
    if(this.verTP){
      node.setVer(true);
    }else{
      node.setHor(true);
    }
    if(node.tpNode == null){
      node.setNode(this);
    }
    return;
  }
  void setWall(boolean isWall){
      this.isWall = isWall;
  }
  void setPlayer(boolean bool){
     this.isPlayer = bool; 
  }
  void setTarget(boolean bool){
     this.isTarget = bool; 
  }
  void display(){
    shoot();
    if(frameCount % 60 == 0){
      turrentClock+=1;
    }
    rectMode(CORNER);
    if(isWall){
        noStroke();
        fill(palette[0]);
    }
    else if(isPlayer || isPlayer2){
        noStroke();
        fill(palette[1]);
    }else if(isTarget){
        fill(palette[8]);noStroke();
    }else if(isSwitch){
      fill(palette[7]);
    }else if(switchWall){
      fill(palette[0]);
    }
    else if(verTP){
      fill(palette[3]);
      
    }else if(horTP){
      fill(palette[3]);
    }
    else if(turrentH || turrentV){
      fill(palette[9]);
    }else{
      fill(palette[4]);noStroke();
    }
    rect(x,y,nodeSize,nodeSize);
     if(verTP){
       fill(palette[0]);
       rect(this.x,this.y + 5,nodeSize,nodeSize-10);
     }else if(horTP){
        fill(palette[0]);
       rect(this.x + 5,this.y,nodeSize-10,nodeSize);
     }
      if(turrentH){
       fill(palette[9]);
       rect(this.x+nodeSize+ 5,this.y+nodeSize/2,nodeSize/3,nodeSize/3);
     }else if(turrentV){
       fill(palette[9]);
       rect(this.x+nodeSize/2 + 5,this.y+nodeSize,nodeSize/5,nodeSize/5);
     }
    if(isWall || switchWall || turrentH || turrentV){
       collide(); 
    }
    if(verTP || horTP){
      teleport();
    }
    if(gameState.equals("GAME")){
       turrent(); 
       if(turrentH && this.turrentHealth <= 0){
         turrentH = false;
       }
       else if(turrentV && this.turrentHealth <= 0){
         turrentV = false;
       }
       deleteTurrentBullets();
    }
    if(isTarget && gameState.equals("GAME")){
       for(int i = 0; i< bullets.size(); i++){
          if(!bullets.get(i).enemy && intersects(bullets.get(i).x,bullets.get(i).y)){
            gameState = "GAME-OVER";
            level++;
            playerScore += bullets.get(i).numBounces * 100;
          }
       }
    }
    if(isSwitch && gameState.equals("GAME")){
       for(int i = 0; i< bullets.size(); i++){
          if(intersects(bullets.get(i).x,bullets.get(i).y)){
            for(int j = 0 ; j < switchWalls.size(); j++){
                switchWalls.get(j).switchWall = false;
            }
            bullets.get(i).dead= true;
            isSwitch = false;
          }
       }
    }
  }
  boolean isLeftSide(float x, float y){
    return  x > this.x - r && x < this.x && y >= this.y && y <= this.y+nodeSize;
  }
  boolean isRightSide(float x, float y){
    return  x > this.x + nodeSize && x < this.x + nodeSize + r && y >= this.y && y <= this.y + nodeSize;
  }
  boolean isTop(float x, float y){
    return x >= this.x && x <= this.x + nodeSize && y > this.y - r && y < this.y;
  }
  boolean isBottom(float x, float y){
    return x >= this.x && x <= this.x + nodeSize && y < this.y + nodeSize + r && y > this.y + nodeSize;
  }
  boolean intersects(float x,float y){
    return isBottom(x,y)||isTop(x,y)||isLeftSide(x,y)||isRightSide(x,y) || x > this.x && x< this.x + nodeSize && y > this.y && y < this.y + nodeSize;
  }
  public boolean intersects(float x,float y,float r,float x2,float y2,float r2){
  return sq(x - x2) + sq(y - y2) < sq(r/2 + r2/2);
}
  void teleport(){
    for(int i = 0; i< bullets.size(); i++){
       if(verTP){
          if(isTop(bullets.get(i).x, bullets.get(i).y)){
            bullets.get(i).setX(tpNode.x + nodeSize/2);
            bullets.get(i).setY(tpNode.y + nodeSize +  5);
        }else if(isBottom( bullets.get(i).x, bullets.get(i).y)){
            bullets.get(i).setX(tpNode.x + nodeSize/2);
            bullets.get(i).setY(tpNode.y - 5);
        }else if(isLeftSide(bullets.get(i).x,bullets.get(i).y)){
         bullets.get(i).inverseRun();
       }else if(isRightSide(bullets.get(i).x,bullets.get(i).y)){
         bullets.get(i).inverseRun();
       }
       }else{
          if(isLeftSide(bullets.get(i).x, bullets.get(i).y)){
              bullets.get(i).setX(tpNode.x + nodeSize + 5);
              bullets.get(i).setY(tpNode.y + nodeSize/2);
          }else if(isRightSide( bullets.get(i).x, bullets.get(i).y)){
              bullets.get(i).setX(tpNode.x - 5);
              bullets.get(i).setY(tpNode.y +nodeSize/2);
          }else if(isTop(bullets.get(i).x,bullets.get(i).y)){
         bullets.get(i).inverseRise();
       }else if(isBottom(bullets.get(i).x,bullets.get(i).y)){
         bullets.get(i).inverseRise();
       }
       }
    }
  }
  
  void deleteTurrentBullets(){
      for(int i = 0; i< bullets.size(); i++){
        if(bullets.get(i).enemy && this.isWall){
           if(isLeftSide(bullets.get(i).x,bullets.get(i).y) || isRightSide(bullets.get(i).x,bullets.get(i).y) || isTop(bullets.get(i).x,bullets.get(i).y) || isBottom(bullets.get(i).x,bullets.get(i).y)){
             bullets.get(i).dead = true;
           }
        }
      }
  }
  
  void collide(){
    for(int i = 0; i< bullets.size(); i++){
      if(!bullets.get(i).enemy){
         if(isLeftSide(bullets.get(i).x,bullets.get(i).y)){
           bullets.get(i).inverseRun();
           if(turrentH || turrentV){
             this.turrentHealth -= 10;
           }
         }else if(isRightSide(bullets.get(i).x,bullets.get(i).y)){
           bullets.get(i).inverseRun();
          if(turrentH || turrentV){
             this.turrentHealth -= 10;
           }
         }
         else if(isTop(bullets.get(i).x,bullets.get(i).y)){
           bullets.get(i).inverseRise();
          if(turrentH || turrentV){
             this.turrentHealth -= 10;
           }
         }else if(isBottom(bullets.get(i).x,bullets.get(i).y)){
           bullets.get(i).inverseRise();
           if(turrentH || turrentV){
             this.turrentHealth -= 10;
           }
         }
      }
    }
  }
  
  void turrent(){
    if(turrentH && turrentClock % 2 == 0){
      bullets.add(new Bullet(this.x + nodeSize/2,this.y+ nodeSize/2 , r*2,this.x + nodeSize /2 + 50,this.y + nodeSize/2));
      turrentClock += 1;
    }
    else if(turrentV && turrentClock % 2 == 0){
      bullets.add(new Bullet(this.x + nodeSize/2,this.y+ nodeSize/2 , r*2,this.x + nodeSize /2,this.y + nodeSize/2 - 50));
      turrentClock +=1;
    }
  }
  
  void shoot(){
    if(isPlayer && mousePressed && mouseButton == LEFT && !gameState.equals("LEVELS")){
      bullets.add(new Bullet(this.x + nodeSize/2,this.y + nodeSize/2,r*2));
      if(!outOfMaps && gameState.equals("GAME")){
        bulletsUsed++;
      }
      mousePressed = false;
    }
    if(isPlayer2 && mousePressed && mouseButton == RIGHT && !gameState.equals("LEVELS")){
      bullets.add(new Bullet(this.x + nodeSize/2,this.y + nodeSize/2,r*2));
      if(!outOfMaps && gameState.equals("GAME")){
        bulletsUsed++;
      }
      mousePressed = false;
    }
  }
}
