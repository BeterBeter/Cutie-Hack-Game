Square[][] grid;
Square currTPNode,switchSquare;

//len 10
color[] palette = {#001219,#005f73,#0a9396,#94d2bd,#e9d8a6,#ee9b00,#ca6702,#bb3e03,#ae2012,#9b2226};

boolean switchMode;
void setup(){
  size(1200,810);
  grid = new Square[width/30][height/30];
  switchMode = false;
  switchSquare = null;
  currTPNode = null;
  for(int i = 0; i<grid.length; i++){
    for(int j = 0; j<grid[0].length; j++){
       grid[i][j] = new Square(i*30,j*30,30,30);
    }
  }
}
void draw(){
  if(switchMode){
     background(#E9D8A6); 
  }
  for(int i = 0; i<grid.length; i++){
    for(int j = 0; j<grid[0].length; j++){
      grid[i][j].display();
    }
  }
  if(keyPressed && key == ENTER){
    System.out.println("void loadMap(){");
    for(int i = 0; i<grid.length; i++){
      for(int j = 0; j<grid[0].length; j++){
        if(grid[i][j].isWall){
          if(i != 0 && j != 0 && i != 39 && j != 26){
            System.out.print("grid["+i+"]["+j+"].setWall(true);");
           }
        }else if(grid[i][j].isPlayer){
          System.out.print("grid["+i+"]["+j+"].setPlayer(true);");
        }else if(grid[i][j].isPlayer2){
          System.out.print("grid["+i+"]["+j+"].setPlayer2(true);");
        }
        else if(grid[i][j].isTarget){
          System.out.print("grid["+i+"]["+j+"].setTarget(true);");
        }else if(grid[i][j].verTP){
          System.out.print("grid["+i+"]["+j+"].setVer(true);");
          System.out.print("grid["+i+"]["+j+"].setNode(grid["+(int)grid[i][j].tpSquare.x/30 + "]["+(int)grid[i][j].tpSquare.y/30+"]);");
        }else if(grid[i][j].horTP){
          System.out.print("grid["+i+"]["+j+"].setHor(true);");
          System.out.print("grid["+i+"]["+j+"].setNode(grid["+(int)grid[i][j].tpSquare.x/30 + "]["+(int)grid[i][j].tpSquare.y/30+"]);");
        }else if(grid[i][j].turrentV){
          System.out.print("grid["+i+"]["+j+"].VerTurrent(true);");
        }else if(grid[i][j].turrentH){
          System.out.print("grid["+i+"]["+j+"].HorTurrent(true);");
        }
        else if(grid[i][j].isSwitch){
          System.out.print("grid["+i+"]["+j+"].setSwitch(true);");
          for(int h = 0; h < grid[i][j].switchWalls.size(); h++){
            System.out.print("grid["+(int)grid[i][j].switchWalls.get(h).x/30+"]["+(int)grid[i][j].switchWalls.get(h).y/30+"].setSwitchWall(true);");
            System.out.print("grid["+i+"]["+j+"].addWallToSwitch(grid["+(int)grid[i][j].switchWalls.get(h).x/30 + "]["+(int)grid[i][j].switchWalls.get(h).y/30+"]);");
          }
        }
      }
    }
    System.out.println("\n}");
    keyPressed = false;
  }
}
