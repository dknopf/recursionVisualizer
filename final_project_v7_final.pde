import controlP5.*;
import processing.pdf.*;

ControlP5 cp5;

int recursionLevel = 3;
boolean strokeRand = false;
color newColor;
color growRecurColor = #e3d1e6;
color shrinkRecurColor = #fcba03;
color baseColor = 60;

int wid = 800;
int hei = 800;
color[][] colorMatrix;
int currBox = 0;
boolean isMousePressed = false;
int ringsFromCenter = 1;
int numBoxes;
boolean rainbow = false; //rainbow or recursion

int clickedBoxX;
int clickedBoxY;


int[] numRings = new int[1];
int[] currRing = new int[1];
color[] rectColor = new color[1];
color[] growRectColor = new color[1];
String[] rectMode = new String[1];
int[] rectCenterX = new int[1];
int[] rectCenterY = new int[1];

int lastMillis = 0;

//Export button
//Blend colors

void settings() {
  size(wid, hei);
  
}

void setup() {
  background(255);
  colorMatrix = createNewMatrix();
  beginRecord(PDF, "recursionVisualizer.pdf");
  cp5 = new ControlP5(this);
  
  cp5.addToggle("rainbow")
     .setPosition(40,750)
     .setSize(50,20)
     .setValue(false)
     .setMode(ControlP5.SWITCH)
     ;
     
    cp5.addButton("moreRecursion")
     .setValue(recursionLevel)
     .setPosition(500,750)
     .updateSize()
     ;
     
    cp5.addButton("lessRecursion")
     .setValue(recursionLevel)
     .setPosition(600,750)
     .updateSize()
     ;
     
   cp5.addButton("PDF")
     .setValue(recursionLevel)
     .setPosition(700,750)
     .updateSize()
     ;
}

void topLevelDraw(){
  
  //println("starting top level draw");
  currBox = 0;
  numBoxes = int(pow(2,recursionLevel));
  drawLoop(0, 0, recursionLevel, 0, 0, width, height);
  
}




color[][] createMatrix(color[][] matrix) {
  
  println("length of rows is:", pow(2,recursionLevel), "when recursionLevel is:", recursionLevel);
  color[][] colorArray = new color[int(pow(2,recursionLevel))][int(pow(2,recursionLevel))];
  for (int i =0; i < pow(2,recursionLevel); i++){
      for (int j =0; j < int(pow(2,recursionLevel)); j++){
        colorArray[i][j] = matrix[i][j];
  }
  }
  
  //color[][] colorArray = new color[int(pow(2,recursionLevel-1))][int(pow(2,recursionLevel))];
  //for (int i =0; i < pow(2,recursionLevel); i++){
  //    for (int j =0; j < pow(2,recursionLevel-1); j++){
  //      colorArray[j][i] = 255;
  //}
  //}
  return colorArray;
}


color[][] createNewMatrix() {
  
  println("length of rows is:", pow(2,recursionLevel), "when recursionLevel is:", recursionLevel);
  color[][] colorArray = new color[int(pow(2,recursionLevel))][int(pow(2,recursionLevel))];
  for (int i =0; i < pow(2,recursionLevel); i++){
      for (int j =0; j < int(pow(2,recursionLevel)); j++){
        colorArray[i][j] = baseColor;
  }
  }
  
  //color[][] colorArray = new color[int(pow(2,recursionLevel-1))][int(pow(2,recursionLevel))];
  //for (int i =0; i < pow(2,recursionLevel); i++){
  //    for (int j =0; j < pow(2,recursionLevel-1); j++){
  //      colorArray[j][i] = 255;
  //}
  //}
  return colorArray;
}


void drawLoop(int row, int col, int i, int originX, int originY, int w, int h) {
  
  
    if (i == 0) {
      //println("row:", row, "col:", col);
      newColor = colorMatrix[row][col];
      fill(newColor);
      //stroke(newColor);
      square(originX, originY, h);
    }
  
    else {
    
    
    row = row * 2;
    col = col * 2;
    drawLoop(row, col, i - 1, originX, originY, w/2, h/2);
    drawLoop(row + 1, col, i - 1, originX + w/2, originY, w/2, h/2);
    drawLoop(row + 1, col + 1, i - 1, originX + w/2, originY + h/2, w/2, h/2);
    drawLoop(row, col + 1, i - 1, originX , originY + h/2, w/2, h/2);
    
    
    }
    
    
}


int[] pointToMatrixEntry(int x, int y) {
  float xBoxNum = x/(width/pow(2,recursionLevel));
  float yBoxNum = y/(height/pow(2,recursionLevel));
  //println("x box num:", xBoxNum, "yBoxNUm:", yBoxNum);
  
  
  
  if ((int(xBoxNum) + int(yBoxNum)) %2 == 0) {
    
    
  }
  
  int[] result = {0,0};
  return result;
  
  //  println("X box num is:", mouseX/(width/pow(2,recursionLevel-1)), "Y box num is:", mouseY/(height/pow(2,recursionLevel-1)));
  //println("Matrix position is: [2*floor(xBoxNum)][yBoxNum] and [2*floor(xBoxNum) + 1][yBoxNum]");
  
}



void drawBaseShape(int originX, int originY, int w, int h){
  //println("currBox is:", currBox);
  //Draw the individual triangles
  float currPosition = sqrt(currBox);
  //println("currPosition is:", currPosition);
  newColor = colorMatrix[int(currPosition/pow(2,recursionLevel))][int(currPosition/pow(2,recursionLevel))];
  newColor = color(random(255), random(255), random(255));
  //if (mode == "rainbow") {
  //  println("in color mode is rainbow");
  //  newColor = color(random(255), random(255), random(255));
  //}
  
  
  fill(newColor);
  stroke(newColor);
  square(originX, originY, h);
  newColor = color(random(255), random(255), random(255));
  fill(newColor);
  stroke(newColor);
  square(originX + w, originY, h);
  newColor = color(random(255), random(255), random(255));
  fill(newColor);
  stroke(newColor);
  square(originX, originY + h, h);
  newColor = color(random(255), random(255), random(255));
  fill(newColor);
  stroke(newColor);
  square(originX + w, originY + h, h);
}


void draw(){
  int i = 1;
  int xBoxNum = int(mouseX/(width/pow(2,recursionLevel)));
  int yBoxNum = int(mouseY/(height/pow(2,recursionLevel)));
  


  
  if (millis() - lastMillis > 200) {
    lastMillis = millis();
     if (isMousePressed == true){
        //println("mouse is pressed");
        background(255);
        if (rainbow) {
          newColor = color(random(255), random(255), random(255));
        }
        else {
          newColor = growRecurColor;
        }
        if (rainbow) {
          colorRing(ringsFromCenter, xBoxNum, yBoxNum, newColor);
        }
        colorRing(ringsFromCenter, clickedBoxX, clickedBoxY, newColor);
        ringsFromCenter += 1;
        numRings[numRings.length-1] += 1;
        
        //delay(200);
        //topLevelDraw();
        i += 1;
      }
    updateExistingRects();
    topLevelDraw();
  }
  
}

void updateExistingRects(){
  for (int rectNum = 1; rectNum < numRings.length; rectNum++) {

    if (rectMode[rectNum] == "down"){
          if (rainbow) {
            colorRing(currRing[rectNum], rectCenterX[rectNum], rectCenterY[rectNum], growRectColor[rectNum]);
          }
          else {
            colorRing(currRing[rectNum], rectCenterX[rectNum], rectCenterY[rectNum], growRecurColor);
          }
      
      colorRing(currRing[rectNum]-1, rectCenterX[rectNum], rectCenterY[rectNum], shrinkRecurColor);
      
      if (currRing[rectNum] < 0) {
        rectMode[rectNum] = "up";
        currRing[rectNum] = 0;
      }
      currRing[rectNum] -= 1;
    }
    if (rectMode[rectNum] == "up") {
      if (rainbow) {
            
            colorRing(currRing[rectNum], rectCenterX[rectNum], rectCenterY[rectNum], color(random(255), random(255), random(255)));  
        }
          
          else {
            colorRing(currRing[rectNum], rectCenterX[rectNum], rectCenterY[rectNum], rectColor[rectNum]);
            
          }
      
      currRing[rectNum] += 1;
      if (currRing[rectNum] > numRings[rectNum]) {
        rectMode[rectNum] = "done";
      }
      
    }
  }
  
}


void colorRing(int ringsFromCenter, int xBoxNum, int yBoxNum, color myColor) {
  //println("yBoxNum:", yBoxNum, "ringsFromCenter:", ringsFromCenter);
  int i = yBoxNum - ringsFromCenter;
  //println("numBoxes is:", numBoxes);
  
  
  while (i <= yBoxNum + ringsFromCenter && i >=0 && i < numBoxes){
    //println("i is:", i, "in the top of the i loop in colorRing");
    if (i == yBoxNum + ringsFromCenter || i == yBoxNum - ringsFromCenter) {
      int j = xBoxNum - ringsFromCenter;
      while (j >=0 && j < numBoxes && j <= xBoxNum + ringsFromCenter ) {
        //print("i:", i, "j:", j);
        colorMatrix[j][i] = myColor;
        j += 1;
      }
    }
    else {
      if (i >=0 && i < numBoxes && (xBoxNum - ringsFromCenter) >=0 && (xBoxNum - ringsFromCenter) < numBoxes && (xBoxNum + ringsFromCenter) >=0 && (xBoxNum + ringsFromCenter) < numBoxes) {
      colorMatrix[xBoxNum - ringsFromCenter][i] = myColor;
      colorMatrix[xBoxNum + ringsFromCenter][i] = myColor;
      }
    }
    i += 1;
    
    
  }
  
}

void myMousePressed() {
  background(255);
  
  //println("x:", mouseX, " y:", mouseY, "recursionLevel:", recursionLevel);
  //println(pow(2,recursionLevel-1));
  //int xBoxNum = int(mouseX/(width/pow(2,recursionLevel)));
  //int yBoxNum = int(mouseY/(height/pow(2,recursionLevel)));
  //println("X box num is:", mouseX/(width/pow(2,recursionLevel)), "Y box num is:", mouseY/(height/pow(2,recursionLevel)));
  //println("Matrix position is: [2*floor(xBoxNum)][yBoxNum] and [2*floor(xBoxNum) + 1][yBoxNum]");
  //pointToMatrixEntry(mouseX,mouseY);
  
  //colorMatrix = createMatrix(colorMatrix);
  colorMatrix[clickedBoxX][clickedBoxY] = 255;
  
  //stroke(random(255), random(255), random(255));
  topLevelDraw();
  
}


public void moreRecursion() {
  recursionLevel += 1;
  colorMatrix = createNewMatrix();
  resetGlobal();
  topLevelDraw();
}

public void lessRecursion() {
    recursionLevel -= 1;
    colorMatrix = createNewMatrix();
    resetGlobal();
    topLevelDraw();
}

public void PDF(){
  println("in PDF save");
  endRecord();
  //delay(100);
  
  beginRecord(PDF, "recursionVisualizer-####.pdf");
}


void keyPressed(){
  println(key);
  if (key == 'p') {
    recursionLevel += 1;
    colorMatrix = createNewMatrix();
    resetGlobal();
    topLevelDraw();
  }
  else if (key == 'm') {
    recursionLevel -= 1;
    colorMatrix = createNewMatrix();
    resetGlobal();
    topLevelDraw();
  }
  
}

void resetGlobal() {
  numRings = new int[1];
  currRing = new int[1];
  rectColor = new color[1];
  rectMode = new String[1];
  rectCenterX = new int[1];
  rectCenterY = new int[1];
}

void mousePressed(){
  println("in mouse pressed");
  isMousePressed = true;
  int xBoxNum = int(mouseX/(width/pow(2,recursionLevel)));
  int yBoxNum = int(mouseY/(height/pow(2,recursionLevel)));
  clickedBoxX = xBoxNum;
  clickedBoxY = yBoxNum;
 
}

void mouseReleased(){
  println("in mouse RELEASEDDDDDDDD");
  numRings = append(numRings, ringsFromCenter);
  currRing = append(currRing, ringsFromCenter);
  rectColor = append(rectColor, color(random(255), random(255), random(255)));
  growRectColor = append(growRectColor, color(random(255), random(255), random(255)));
  rectMode = append(rectMode, "down");
  rectCenterX = append(rectCenterX, clickedBoxX);
  rectCenterY = append(rectCenterY, clickedBoxY);
  isMousePressed = false;
  ringsFromCenter = 1;
}

//Boxes = 2^level-1
//lvl 4 = 8 boxes
//lvl 5 = 16 boxes
