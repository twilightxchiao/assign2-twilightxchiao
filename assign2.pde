PImage bgImg;
PImage soilImg;
PImage lifeImg;
PImage soldierImg;
PImage cabbageImg;
PImage titleImg;
PImage gameoverImg;
//groundhog
PImage groundhogIdleImg;
PImage groundhogDownImg;
PImage groundhogLeftImg;
PImage groundhogRightImg;
//button
PImage startNormalImg;
PImage startHoveredImg;
PImage restartNormalImg;
PImage restartHoveredImg;

int soldierX,soldierY,cabbageX,cabbageY;
int groundhogX = 320;
int groundhogY = 80;
int groundhogSpeed = 5;
int groundhogWidth = 80;
int soldierWidth = 80;
int cabbageWidth = 80;


int life = 2;



final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;

final int Idle =0;
final int Left =1;
final int Down =2;
final int Right =3;


int gameState = GAME_START;
int actState = Idle;


void setup() {
	size(640, 480, P2D);
  bgImg = loadImage("img/bg.jpg");
  soilImg = loadImage("img/soil.png");
  titleImg = loadImage("img/title.jpg");
  startNormalImg = loadImage("img/startNormal.png");
  startHoveredImg = loadImage("img/startHovered.png");
  groundhogIdleImg = loadImage("img/groundhogIdle.png");
  groundhogDownImg = loadImage("img/groundhogDown.png");
  groundhogLeftImg = loadImage("img/groundhogLeft.png");
  groundhogRightImg = loadImage("img/groundhogRight.png");
  lifeImg = loadImage("img/life.png");
  soldierImg = loadImage("img/soldier.png");
  cabbageImg = loadImage("img/cabbage.png");
  gameoverImg = loadImage("img/gameover.jpg");
  restartNormalImg = loadImage("img/restartNormal.png");
  restartHoveredImg = loadImage("img/restartHovered.png");
  
  
  //soldier
  soldierY = 160+floor(random(4))*80;
  
  
  //cabbage
  cabbageX = floor(random(8))*80;
  cabbageY = 160+floor(random(4))*80;
  
	// Enter Your Setup Code Here
}

void draw() {
  switch(gameState){
    case GAME_START:
      image(titleImg,0,0);
      if(mouseX>248 && mouseX<(248+144) && mouseY>360 && mouseY<(360+60)){
        image(startHoveredImg,248,360,144,60);
        if (mousePressed){
          gameState = GAME_RUN;
        }
      }
      else{
        image(startNormalImg,248,360,144,60);
      }
    
    break;
    
    case GAME_RUN:
       
      //bg
      image(bgImg,0,0);
      //soil
      image(soilImg,0,160);
      
      //grass
      noStroke();
      colorMode(RGB);
      fill(124, 204, 25);
      rect(0,145,640,15);
      
      //sun
      colorMode(RGB);
      stroke(255,255,0);
      strokeWeight(5);
      fill(253,184,19);
      ellipse(590,50,120,120);
      
      //groundhog

      switch(actState){
        case Idle:
          image(groundhogIdleImg,groundhogX,groundhogY);
          break;
        case Left:
          groundhogX -= groundhogSpeed;
            image(groundhogLeftImg,groundhogX,groundhogY);
          if(groundhogX %80 == 0){actState = Idle;}
          if(groundhogX < 0){ 
            groundhogX = 0;
            actState = Idle;
          }
          break;
        case Down:
          groundhogY += groundhogSpeed;
            image(groundhogDownImg,groundhogX,groundhogY);
         if(groundhogY %80 == 0){actState = Idle;}
          
          if(groundhogY > height-groundhogWidth){
              groundhogY=height-groundhogWidth;
              actState = Idle;
          }
          break;
        case Right:
          groundhogX += groundhogSpeed;
            image(groundhogRightImg,groundhogX,groundhogY);
          if(groundhogX %80 == 0){actState = Idle;}
          if(groundhogX > width-groundhogWidth){
            groundhogX = width-groundhogWidth;
            actState = Idle;
          }
          break;
      }
      //cabbage
      image(cabbageImg,cabbageX,cabbageY);      
      if(groundhogX+groundhogWidth > cabbageX && groundhogX < cabbageX+cabbageWidth && groundhogY+groundhogWidth > cabbageY &&  groundhogY < cabbageY+cabbageWidth){
        life ++;
        cabbageX = 0;
        cabbageY = 600; 
      }  

      
      //life
      if (life <= 0){
      gameState = GAME_LOSE;               
      }
      if (life == 1){
        image(lifeImg,10,10);              
      }
      if (life == 2){
        image(lifeImg,10,10);
        image(lifeImg,80,10);               
      }
      if (life == 3){
        image(lifeImg,10,10);
        image(lifeImg,80,10);
        image(lifeImg,150,10);       
      }
      
      //soldier
      if (groundhogX+groundhogWidth > soldierX-soldierWidth && groundhogX < soldierX && groundhogY+groundhogWidth > soldierY &&  groundhogY < soldierY+soldierWidth){
        life --;
        groundhogX = 320;
        groundhogY = 80; 
        actState = Idle;
      }
      soldierX = soldierX+5;
      soldierX %=640+80;
      image(soldierImg,soldierX-soldierWidth,soldierY);
       
    
      
    break;
  
    case GAME_LOSE:
      image(gameoverImg,0,0);
      life = 2;
      cabbageX = floor(random(8))*80;
      cabbageY = 160+floor(random(4))*80;
      soldierY = 160+floor(random(4))*80;
      soldierX = 0;
      if(mouseX>248 && mouseX<(248+144) && mouseY>360 && mouseY<(360+60)){
        image(restartHoveredImg,248,360,144,60);
        if (mousePressed){
          gameState = GAME_RUN;
        }
      }
      else{
        image(restartNormalImg,248,360,144,60);
      }
  
    break;
  
  }
}

void keyPressed(){
  if (key == CODED && gameState == GAME_RUN) {
    switch (keyCode) {
      case DOWN:
        if(groundhogX %80 == 0){
          actState = Down;
        }
        break;
      case LEFT:
        if(groundhogY %80 == 0 && groundhogX %80 == 0){
          actState = Left;
        }
        
        break;
      case RIGHT:
        if(groundhogY %80 == 0 && groundhogX %80 == 0){
          actState = Right;
        }
        
        break;
    }
   }
}

void keyReleased(){

}
