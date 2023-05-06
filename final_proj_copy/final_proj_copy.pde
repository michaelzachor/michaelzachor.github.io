int numberOfPoints = 9; //<>//
Point[] points = new Point[numberOfPoints];
Circle[] circles = new Circle[numberOfPoints];
int tSize = 16;

int count1 = 0;
float phase = 0.0;
String intro1 = "Vertex coloring is when we assign a color to each vertex of a graph \nsuch that no neighboring vertices are the same color.\n(Hit the spacebar to continue.)";
String intro2 = "Vertex coloring has various real world applications.\nOne such application is in assigning frequencies to radio stations.\nVertices represent stations, edges are drawn between stations with \nintersecting broadcasting ranges, and colors represent frequencies.\n(Hit the spacebar to continue.)";
String instruction1 = "Let's construct such a graph ourselves.\nClick at "+numberOfPoints+" different places in the white area below \nto place radio stations on a map.";
String instruction2 = "Use the dials on the left to set the broadcasting range for each radio \nstation. Make sure some ranges are intersecting. \nHit the spacebar when ready to continue.";
String instruction3 = "In order to construct our graph, we draw edges between stations whose \ncoverages intersect. Click points to draw edges between them.\nThe station you have selected has a red interior, and stations outlined in \nred are missing an edge to another intersecting station.";
String instruction3b = "Now, watch as edges are drawn between stations whose coverages\nintersect.";
String notIntersectingMsg = "Those two points are not intersecting. Try a different pair.";
String noIntersectsMsg = "Please make sure some stations have intersecting ranges.";
String missingRangeMsg = "Please make sure every station has a broadcasting range.";
String instruction4_a = "Now we can color this graph by assigning colors to vertices\nsuch that any two vertices that share an edge are different colors.\nHit the spacebar when ready to continue.";
String instruction4_b1 = "The vertex in your graph that has the most edges is vertex ";
String instruction4_b2 = "\nThat means the maximum degree, delta, of your graph is ";
String instruction4_b3 = ". A graph can \nbe colored with <=delta+1 colors.\nHit the spacebar to watch the vertex coloring happen.";
String wrongColor = "A neighboring vertex already has that color. \nPlease choose a different color.";
String stillBlackPointsMsg = "Please make sure all points are colored.";
String instruction5 = "Now that all our vertices have a different color, we can assign \na different frequency to each color.\nHit the spacebar to continue.";
String instruction6 = "And now, no two radio stations that broadcast in the same area\nhave the same frequency.\nThanks for participating!"; 
float[] bxs = new float[numberOfPoints];
float[] poxs = new float[numberOfPoints];
float[] bys = new float[numberOfPoints];
float[] poys = new float[numberOfPoints];
int boxSize = 20;
int popupSizeX = 80;
int popupSizeY = 0;
boolean[] overBoxes = new boolean[numberOfPoints];
boolean[] lockeds = new boolean[numberOfPoints];
float[] xOffsets = new float[numberOfPoints];
int pointPending = -1;
boolean notIntersecting = false;
int displayingPopup = 0;
color[] colors = {color(255, 40, 65),color(255, 205, 0),color(0, 116, 217),color(46, 204, 64),color(255, 133, 27),color(177, 13, 201),color(240, 18, 190),color(1, 255, 112),color(127, 219, 255)};
int colorPicker = 0;
int colorBox = -1;
boolean cantDoThatColor = false;
color beige = color(234,227,201);
color lightBeige = color(245,245,221);
boolean noIntersects = false;
boolean missingRange = false;
boolean stillBlackPoints = false;
float[] radioFrequencies = new float[numberOfPoints];
int maxDegree = 0;
int vertexMaxDegree = -1;
int mapSize;
int pressedKnob = -1;
int time = -1;
int circlePhase = 0; 
int circleI = 0;
int circleJ = 0;
int colorPhase = 0;
color[] availableColors;
int colorChoice = 0;

void setup() {
  size(600, 600);
  background(beige);
  drawSidePanel();
  drawTopArea();
  //drawMapArea();
  drawMap();
  for (int i = 0; i < numberOfPoints; i++) {
    bxs[i] = width/40+10;
    bys[i] = height/4+30*(i+1)-7.5;
    int rndm = int(random(880,1080));
    if (rndm % 2 == 0) rndm ++;
    radioFrequencies[i] = float(rndm) / 10;
    //println(radioFrequencies[0]);
  }
  mapSize = 5*width/16;
}

void draw() {
  if (phase == 0.0) startDisplay();
  if (phase == 0.1) intro1Display();
  else if (phase == 0.2) intro2Display();
  else if (phase == 1) instruction1Display();
  else if (phase == 2) {
    instruction2Display();
    drawSidePanel();
    drawKnobRanges();
    drawMap();
    drawPoints();
    drawCircles();
    //drawMapInside();
    for (int i = 0; i < numberOfPoints; i++) {
      displayKnobs(i);
    }
    if (missingRange) missingRangeMessage();
    else if (noIntersects) noIntersectsMessage();
  }
  else if (phase == 3) {
    instruction3bDisplay();
    drawEdges();
  }
  else if (phase == 3.1) {
    instruction3Display();
    //drawMapArea();
    drawMap();
    drawPoints();
    drawCircles();
    if (notIntersecting) notIntersectingMessage();
  }
  else if (phase == 4) {
    drawMap();
    drawPoints();
    for (int i = 0; i < numberOfPoints; i++) {
      bxs[i] = width/40+10;
    }
    instruction4bDisplay(maxDegree, vertexMaxDegree);
  }
  else if (phase == 4.1) {
    if (circleI > numberOfPoints-1) phase = 5;
    else {
      displayingPopup = circleI;
      instruction4bDisplay(maxDegree, vertexMaxDegree);
      addColors();
      drawMap();
      drawSidePanel();
      displayColorPopup(displayingPopup);
      drawPoints();
      for (int i = 0; i < numberOfPoints; i++) {
        bxs[i] = width/40+10;
        displayColorPicker(i);
      }
    }
  }
  //else if (phase == 4.1) {
  //  instruction4bDisplay(maxDegree, vertexMaxDegree);
  //  //drawMapArea();
  //  drawMap();
  //  drawSidePanel();
  //  if (cantDoThatColor) wrongColorMessage();
  //  if (stillBlackPoints) stillBlackPointsMessage();
  //  displayColorPopup(displayingPopup);
  //  drawPoints();
  //  for (int i = 0; i < numberOfPoints; i++) {
  //    bxs[i] = width/40+10;
  //    displayColorPicker(i);
  //  }
  //  boolean handCursor = false;
  //  for (int i = 0; i < numberOfPoints; i++) {
  //    if ((mouseX>bxs[i] && mouseX<bxs[i]+boxSize*5
  //    && mouseY>bys[i] && mouseY<bys[i]+boxSize) ||
  //    (mouseX>poxs[i] && mouseX<poxs[i]+boxSize
  //    && mouseY>poys[i] && mouseY<poys[i]+boxSize)) {
  //      handCursor = true;
  //    }
  //  }
  //  if (handCursor) cursor(HAND);
  //  else cursor(POINT);
  //}
  else if (phase == 5) {
    instruction5Display();
    drawSidePanel();
    for (int i = 0; i < numberOfPoints; i++) {
      displayColorPicker(i);
    }
  }
  else if (phase == 6) {
    instruction6Display();
    drawSidePanel();
    //drawMapArea();
    drawMap();
    for (int i = 0; i < numberOfPoints; i++) {
      circles[i].setInterior(color(red(points[i].pColor), green(points[i].pColor), blue(points[i].pColor), 50));
      displayColorPicker(i);
    }
    drawCircles();
  }
}

// ~~~~ INSTRUCTIONS

void startDisplay() {
  drawTopArea();
  fill(0);
  textSize(48);
  text("Click to begin.", width/40, height/10-tSize/2);
}

void intro1Display() {
  drawTopArea();
  fill(0);
  textSize(tSize);
  text(intro1, width/40, height/10-tSize/2);
}

void intro2Display() {
  drawTopArea();
  fill(0);
  textSize(tSize);
  text(intro2, width/40, height/15-tSize/2);
}

void instruction1Display() {
  drawTopArea();
  drawSidePanel();
  //image(img4,width/4,width/4,3*width/4,3*width/4);
  //drawMap();
  fill(0);
  textSize(tSize);
  text(instruction1, width/40, height/10-tSize/2);
}

void instruction2Display() {
  drawTopArea();
  fill(0);
  textSize(tSize);
  text(instruction2, width/40, height/10-tSize/2);
}

void instruction3bDisplay() {
  drawTopArea();
  drawSidePanel();
  fill(0);
  textSize(tSize);
  text(instruction3b, width/40, height/10-tSize*2);
}

void instruction3Display() {
  drawTopArea();
  drawSidePanel();
  fill(0);
  textSize(tSize);
  text(instruction3, width/40, height/10-tSize*2);
}

void notIntersectingMessage() {
  fill(255,0,0);
  textSize(tSize);
  text(notIntersectingMsg, width/40, height/4+-tSize/2);
}

void noIntersectsMessage() {
  fill(255,0,0);
  textSize(tSize);
  text(noIntersectsMsg, width/40, height/4+-tSize/2);
}

void missingRangeMessage() {
  fill(255,0,0);
  textSize(tSize);
  text(missingRangeMsg, width/40, height/4-tSize/2);
}

void instruction4Display() {
  drawTopArea();
  fill(0);
  textSize(tSize);
  text(instruction4_a, width/40, height/20-tSize/2);
}

void instruction4bDisplay(int delta, int deltaVertex) {
  drawTopArea();
  fill(0);
  textSize(tSize);
  text(instruction4_b1+deltaVertex
  +" ,with "+delta+" edges."
  +instruction4_b2+delta
  +instruction4_b3,
  width/40, height/20-tSize/2);
}

void wrongColorMessage() {
  fill(255,0,0);
  text(wrongColor, width/40, height/4-tSize*2);
}

void stillBlackPointsMessage() {
  fill(255,0,0);
  text(stillBlackPointsMsg, width/40, height/4-tSize/2);
}

void instruction5Display() {
  drawTopArea();
  fill(0);
  textSize(tSize);
  text(instruction5, width/40, height/15-tSize/2);
}

void instruction6Display() {
  drawTopArea();
  fill(0);
  textSize(tSize);
  text(instruction6, width/40, height/20-tSize/2);
}

// ~~~~ DRAW

//void drawMapArea() {
//  stroke(120);
//  strokeWeight(2);
//  fill(255);
//  rect(width/4, height/4, 3*width/4, 3*height/4);
//}

//void drawMapSurroundings() {
//  stroke(120);
//  strokeWeight(2);
//  fill(123,181,78);
//  rect(width/4,width/4,3*width/4,3*width/4);
//  image(img4, width/4+2,width/4+2,3*width/4-2,3*width/4-2);
//}

//void drawMapInside() {
//  noStroke();
//  fill(123,181,78);
//  polygon(5*width/8, 5*width/8, 5*width/16, 6);
//}

void drawPoints() {
  for (int i = 0; i < numberOfPoints; i++) points[i].display(i);
}

void drawCircles() {
  for (int i = 0; i < numberOfPoints; i++) circles[i].display();
}

void drawMap() {
  if (phase < 1) {
    fill(beige);
    rect(width/4, height/4, 3*width/4, 3*height/4);
  }
  else if (phase < 2) {
    stroke(180);
    strokeWeight(2);
    //fill(180);
    //rect(width/4, height/4, 3*width/4, 3*height/4);
    // println((width/4+(3*width/4-mapSize)/2), mapSize);
    fill(255);
    rect(width/4+(3*width/4-mapSize)/2, width/4+(3*width/4-mapSize)/2, mapSize, mapSize);
  }    
  else {
    stroke(180);
    strokeWeight(2);
    fill(255);
    rect(width/4, height/4, 3*width/4, 3*height/4);
  }
}

void drawSidePanel() {
  fill(beige);
  noStroke();
  rect(0,height/4,width/4,3*height/4);
}

void drawTopArea() {
  fill(beige);
  noStroke();
  rect(0,0,width,height/4);
}

void drawKnobRanges() {
   fill(0);
   stroke(0);
   for (int i = 0; i < numberOfPoints; i++) {
     textSize(tSize);
     text(i+1, width/40-10, height/4+30*(i+1)+7);
     rect(width/40+20, height/4+30*(i+1), 80, 5);  
   }
}

void displayKnobs(int i) {
  if (mouseX > bxs[i] && mouseX < bxs[i]+boxSize && 
        mouseY > bys[i] && mouseY < bys[i]+boxSize) {
    overBoxes[i] = true;  
    if(!lockeds[i]) { 
      stroke(100, 0, 200); 
      fill(255);
    } 
  } else {
    stroke(0);
    fill(255);
    overBoxes[i] = false;
  }
  rect(bxs[i], bys[i], boxSize, boxSize);
}

void displayEdge(int pointPending, int p) {
  line(points[pointPending].xpos, points[pointPending].ypos, points[p].xpos, points[p].ypos);
}

void drawEdges() {
  if (circleI < numberOfPoints && circleJ < numberOfPoints) {
    if (circleI != circleJ && circles[circleI].intersecting[circleJ] && !points[circleJ].edges[circleI]) {
      if (time < 0) time = millis();
      if (circlePhase == 0 && millis() - time >= 600) {
        circles[circleI].setInterior(color(255,0,0,50));
        circlePhase = 1;
        time = -1;
      } else if (circlePhase == 1 && millis() - time >= 600) {
        circles[circleJ].setInterior(color(255,0,0,50));
        circlePhase = 2;
        time = -1;
      } else if (circlePhase == 2 && millis() - time >= 600) {
        points[circleI].addEdge(circleJ);
        circlePhase = 3;
        time = -1;
      } else if (circlePhase == 3 && millis() - time >= 600) {
        circles[circleJ].setInterior(color(255,0));
        circlePhase = 4;
        time = -1;
      } else if (circlePhase == 4 && millis() - time >= 600) {
        if (circleJ < numberOfPoints-1) {
          circleJ++;
          circlePhase = 1;
        } else if (circleI < numberOfPoints-1) {
          circleJ = 0;
          circles[circleI].setInterior(color(255,0));
          circles[circleI].setColor(0);
          circleI++;
          circlePhase = 1;
        }
        time = -1;
      }
    } else {
      if (circleJ < numberOfPoints) {
        circleJ++;
        circlePhase = 0;
      } 
      if (circleI < numberOfPoints && circleJ == 9) {
        circles[circleI].setInterior(color(255,0));
        circles[circleI].setColor(0);
        circleJ = 0;
        circleI++;
        circlePhase = 0;
      }
      time = -1;
    }
    drawMap();
    drawPoints();
    drawCircles();
  } else {
    findDelta();
    phase = 4;
    circleI = 0;
    circleJ = 0;
  }
}

void addColors() {
  if (circleI < numberOfPoints && circleJ < numberOfPoints) {
    if (time < 0) time = millis();
    if (colorPhase == 0 && millis() - time >= 600) {
      for (int i = 0; i < maxDegree+1; i++) {
        availableColors[i] = colors[i];
      }
      points[circleI].setColor(availableColors[colorChoice]);
      colorPhase = 1;
      time = -1;
    } else if (colorPhase == 1) {
      if (circleI != circleJ && circles[circleI].isIntersecting(circles[circleJ])) {
        if (millis() - time >= 600) {
          // println("check",circleI,circleJ);
          strokeWeight(3);
          stroke(points[circleJ].pColor);
          line(points[circleI].xpos, points[circleI].ypos, points[circleJ].xpos, points[circleJ].ypos); // actually set edgeWeight to 3 in Point.
          colorPhase = 2;
          time = -1;
        }
      } else {
        circleJ++;
        if (circleJ > numberOfPoints-1) {
          circleJ = 0;
          circleI++;
          colorPhase = 0;
        }
        time = -1;
      }
    } else if (colorPhase == 2 && millis() - time >= 600) {
      // println("check2", circleI, circleJ);
      if (points[circleJ].pColor != color(0)) {
        for (int i = 0; i < maxDegree+1; i++) {
          if (availableColors[i] == points[circleJ].pColor) {
            availableColors[i] = color(0);
          }
        }
        while (availableColors[colorChoice] == color(0)) {
          colorChoice++;
        }
        points[circleI].setColor(availableColors[colorChoice]);
        colorPhase = 3;
        time = -1;
      } else {
        colorPhase = 1;
        circleJ++;
        if (circleJ > numberOfPoints-1) {
          circleJ = 0;
          circleI++;
          colorPhase = 0;
        }
        time = -1;
      }
    } else if (colorPhase == 3 && millis() - time >= 600) {
      colorChoice = 0;
      colorPhase = 1;
      circleJ++;
      if (circleJ > numberOfPoints-1) {
        circleJ = 0;
        circleI++;
        colorPhase = 0;
      }
    }
  } 
  //else phase = 5;
    
}

void drawEdge(int i, int j) {
  if (time < 0) time = millis();
  // println("t:",time);
  int edgeComplete = 0;
  while (edgeComplete < 2) {
    //circles[i].setInterior(color(255,0,0,50));
    circles[j].setInterior(color(255,0,0,50));
    drawMap();
    drawPoints();
    drawCircles();
    if (millis()-time == 1000) {
      // println("1s");
      points[i].addEdge(j);
      drawMap();
      drawPoints();
      drawCircles();
      edgeComplete++;
    } else if (millis()-time == 2000) {
      // println("2s");
      circles[j].setInterior(color(255,0));
      edgeComplete ++;
    }
  }
  time = -1;
}

void displayColorPicker(int i) {
  stroke(0);
  strokeWeight(1);
  fill(0);
  textSize(tSize);
  text(i+1, width/40-10, height/4+30*(i+1)+5);
  if (points[i].pColor == color(0)) fill (color(255));
  else fill(points[i].pColor);
  if (phase == 4.1) {
    if (i == displayingPopup) strokeWeight(3);
    rect(bxs[i], bys[i], boxSize*5, boxSize, 10);
    fill(0);
    if (points[i].pColor == color(0)) text("select color",bxs[i]+5,bys[i]+15);
  } else if (phase >= 5) {
    ellipse(bxs[i]+boxSize/2, bys[i]+boxSize/2, boxSize, boxSize);
    float freq = 0.0;
    for (int j = 0; j < numberOfPoints; j++) {
      if (points[i].pColor == colors[j]) freq = radioFrequencies[j];
    }
    fill(0);
    //String[] freqString = split(str(freq), '.');
    //text(freqString[0]+'.'+split(freqString[1],'0')[0], bxs[i]+boxSize*2, bys[i]+boxSize/2+5);
    text(freq,bxs[i]+boxSize*2,bys[i]+boxSize/2+5);
  }
}

void displayColorPopup(int i) {
  int deltaPlus1 = maxDegree+1;
  popupSizeY = 5+25*(int((deltaPlus1-1)/3+1));
  displayingPopup = i;
  stroke(0);
  strokeWeight(1);
  fill(255);
  rect(bxs[i], bys[numberOfPoints-1] + boxSize*3+10, popupSizeX, popupSizeY);
  float yColor = bys[numberOfPoints-1] + boxSize*3+15;
  for (int j = 0; j < deltaPlus1; j++) {
    if (j == 3) yColor += boxSize + 5;
    if (j == 6) yColor += boxSize + 5;
    fill(colors[j]);
    if (points[i].pColor == colors[j]) strokeWeight(3);
    else strokeWeight(1);
    poxs[j] = bxs[j]+5+(5+boxSize)*(j%3);
    poys[j] = yColor;
    rect(poxs[j],yColor,boxSize,boxSize);
  }
  fill(0);
  text("Select a color \nfor vertex: " + (i+1), bxs[i], bys[numberOfPoints-1] + boxSize*2);
}

void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

// ~~~~CHECK

int whichSlider() {
  for (int i = 0; i < numberOfPoints; i++) {
    if (overBoxes[i]) return i;
  }
  return -1;
}

int whichPoint() {
  for (int i = 0; i < numberOfPoints; i++) {
    if (mouseX>points[i].xpos-8 && mouseX<points[i].xpos+8 
    && mouseY>points[i].ypos-8 && mouseY<points[i].ypos+8) {
      return i;
    }
  }
  return -1;
}

int whichColorPicker() {
  for (int i = 0; i < numberOfPoints; i++) {
    if (mouseX>bxs[i] && mouseX<bxs[i]+boxSize*5
    && mouseY>bys[i] && mouseY<bys[i]+boxSize) colorPicker = i;
  }
  return colorPicker;
}

int whichColorBox() {
  float yColor = bys[numberOfPoints-1] + boxSize*3+15;
  for (int j = 0; j < numberOfPoints; j++) {
    if (j == 3) yColor += boxSize + 5;
    if (j == 6) yColor += boxSize + 5;
    if (mouseX>bxs[j]+5+(5+boxSize)*(j%3) && mouseX<bxs[j]+5+(5+boxSize)*(j%3)+boxSize
    && mouseY>yColor && mouseY<yColor+boxSize) return j;
  }
  return -1;
}

void findDelta() {
  for (int i = 0; i < numberOfPoints; i++) {
    //// println(circles[i].degree);
    if (circles[i].degree > maxDegree) {
      maxDegree = circles[i].degree;
      vertexMaxDegree = i;
    }
  }
  vertexMaxDegree++;
  availableColors = new color[maxDegree+1];
  for (int i = 0; i < maxDegree+1; i++) {
    availableColors[i] = colors[i];
  }
}

boolean checkPointOkay() {
  boolean insideBox = mouseX > width/4+(3*width/4-mapSize)/2 && mouseX < width/4+(3*width/4-mapSize)/2+mapSize && mouseY > width/4+(3*width/4-mapSize)/2 && mouseY < width/4+(3*width/4-mapSize)/2+mapSize;
  //boolean notOnOtherPoint = true;
  for (int i = -8; i < 5; i++) {
    for (int j = -8; j < 5; j++) {
      if (get(mouseX+i,mouseY+j) != color(255)) return false;
      //if (!notOnOtherPoint) notOnOtherPoint = get(mouseX+i,mouseY+j) != color(255);
    }
  }
  return insideBox;
}

// ~~~~ USER INTERACTION

void mouseClicked() {
  if (phase == 0.0) phase = 0.1;
  if (phase == 1 && checkPointOkay()) { //  && get(mouseX,mouseY) != get(width/4+5,height/4+5)
    stroke(0);
    fill(0);
    strokeWeight(9);
    point(mouseX, mouseY);
    textSize(12);
    text(count1+1,mouseX+4,mouseY-2);
    points[count1] = new Point(mouseX, mouseY);
    circles[count1] = new Circle(mouseX, mouseY);
    count1++;
    if (count1 == numberOfPoints) phase = 2;
  }
  if (phase == 3) {
    notIntersecting = false;
    int p = whichPoint();
    // not a point
    if (p < 0) return;
    // first point
    if (pointPending == -1) {
      pointPending = p;
      circles[pointPending].setInterior(color(255,0,0,50));
    }
    // same point
    else if (pointPending == p) {
      circles[pointPending].setInterior(color(255,0));
      pointPending = -1;
    }
    // second point
    else {
      if (circles[pointPending].isIntersecting(circles[p])) {
        stroke(0);
        strokeWeight(1);
        displayEdge(pointPending, p);
        points[pointPending].addEdge(p);
        circles[pointPending].intersecting[p] = false;
        circles[p].intersecting[pointPending] = false;
        boolean noIntersects1 = true;
        boolean noIntersects2 = true;
        for (int i = 0; i < numberOfPoints; i++) {
          if (circles[pointPending].intersecting[i] == true && pointPending != i) noIntersects1 = false;
          if (circles[p].intersecting[i] == true && p != i) noIntersects2 = false;
        }
        if (noIntersects1) circles[pointPending].setColor(color(0));
        if (noIntersects2) circles[p].setColor(color(0));
      } else {
        notIntersecting = true;
      }
      circles[pointPending].setInterior(color(255,0));
      pointPending = -1;
    }
    boolean toPhase4 = true;
    for (int i = 0; i < numberOfPoints; i++) {
      if (circles[i].outer != color(0)) toPhase4 = false;
    }
    if (toPhase4) phase = 4;
  }
  if (phase == 4.1) {
    int cp = whichColorPicker();
    int cb = whichColorBox();
    if (cp < 0 && cb < 0) return;
    stillBlackPoints = false;
    if (cp >= 0) displayColorPopup(cp);
    if (cb < 0) return;
    cantDoThatColor = false;
    for (int i = 0; i < numberOfPoints; i++) {
      if (i != cp && circles[i].isIntersecting(circles[cp]) && points[i].pColor == colors[cb]) {
        cantDoThatColor = true;
      }
    }
    if (cantDoThatColor) {
      wrongColorMessage();
      return;
    }
    else points[cp].pColor = colors[cb];
  }
}

void mousePressed() {
  if (phase == 2) {
    int c = whichSlider();
    if (c >= 0) {
      pressedKnob = c;
      lockeds[c] = true;
    } else if (pressedKnob >= 0) {
      lockeds[pressedKnob] = true;
    }
    if (pressedKnob >= 0) {
      if (c < 0 && !lockeds[pressedKnob]) return;
      fill(255);
      xOffsets[c] = mouseX-bxs[c];
    }
  } 
}

void mouseDragged() {
  if (phase == 2) {
    drawMap();
    for (int i = 0; i < numberOfPoints; i++) {
      points[i].display(i);
      circles[i].display();
    }
    int c = whichSlider();
    if (c >= 0) {
      pressedKnob = c;
      lockeds[c] = true;
    } else if (pressedKnob >= 0) {
      lockeds[pressedKnob] = true;
    }
    if (pressedKnob >= 0) {
      if (c < 0 && !lockeds[pressedKnob]) return;
      //if (c < 0) return;
      fill(255);
      bxs[pressedKnob] = mouseX-xOffsets[pressedKnob];
      if (bxs[pressedKnob] > width/40+80) bxs[pressedKnob] = width/40+80;
      if (bxs[pressedKnob] < width/40+10) bxs[pressedKnob] = width/40+10;
      float circleSize = (bxs[pressedKnob] - (width/40+10))*2;
      circles[pressedKnob].size = circleSize;
      circles[pressedKnob].display();
    }
  }
}

void mouseReleased() {
  if (phase == 2) {
    for (int i = 0; i < numberOfPoints; i++) lockeds[i] = false;
    pressedKnob = -1;
  }
}

void keyReleased() {
  if (phase == 0.1 && key == ' ') phase = 0.2;
  else if (phase == 0.2 && key == ' ') {
    phase = 1;
    drawMap();
    //noStroke();
    //fill(123,181,78);
    //rect(width/4,width/4,3*width/4,3*width/4);
    //drawMapSurroundings();
  }
  else if (phase == 2 && key == ' ') {
    missingRange = false;
    noIntersects = true;
    for (int i = 0; i < numberOfPoints; i++) {
      for (int j = 0; j < numberOfPoints; j++) {
        if (i != j && circles[i].isIntersecting(circles[j])) noIntersects = false;
      }
      if (circles[i].size == 0) missingRange = true;
    }
    if (missingRange) missingRangeMessage();
    else if (noIntersects) noIntersectsMessage();
    else {
      for (int i = 0; i < numberOfPoints; i++) {
        for (int j = 0; j < numberOfPoints; j++) {
          if (i != j && circles[i].isIntersecting(circles[j])) {
            circles[i].setIntersecting(j);
            circles[i].setColor(color(255,0,0));
          }
        }
      }
      phase = 3;
    }
  }
  else if (phase == 4 && key == ' ') {
    //findDelta();
    phase = 4.1;
  } 
  //else if (phase == 4.1 && key == ' ') {
  //  cantDoThatColor = false;
  //  stillBlackPoints = false;
  //  for (int i = 0; i < numberOfPoints; i++) {
  //    if (points[i].pColor == color(0)) stillBlackPoints = true;
  //  }
  //  if (!stillBlackPoints) phase = 5;
  //}
  else if (phase == 5 && key == ' ') {
    phase = 6;
  }
}

// ~~~~ CLASSES

class Point { 
  float xpos, ypos; 
  color pColor = color(0);
  boolean[] edges = new boolean[numberOfPoints];
  Point (float x, float y) {  
    xpos = x; 
    ypos = y;
  } 
  void display(int c) {
    strokeWeight(1);
    stroke(0);
    for (int i = 0; i < numberOfPoints; i++) {
      if (edges[i]) line(xpos,ypos,points[i].xpos,points[i].ypos);
    }
    fill(pColor);
    stroke(pColor);
    strokeWeight(9);
    point(xpos,ypos);
    textSize(12);
    text(c+1,xpos+4,ypos-2);
  }
  void setColor(color c) {
    pColor = c;
  }
  void addEdge(int p) {
    edges[p] = true;
  }
} 

class Circle {
  float xPos, yPos, size;
  color outer = color(0);
  color inner = color(255,0);
  boolean[] intersecting = new boolean[numberOfPoints];
  int degree = 0;
  Circle (float x, float y) {
    xPos = x;
    yPos = y;
    size = 0;
  }
  void display() {
    fill(inner);
    stroke(outer);
    strokeWeight(1);
    ellipse(xPos, yPos, size, size);
  }
  void setColor(color c) {
    outer = c;
  }
  void setInterior(color c) {
    inner = c;
  } 
  void setIntersecting(int c) {
    intersecting[c] = true;
    degree++;
  }
  boolean isIntersecting(Circle c) {
    return dist(xPos, yPos, c.xPos, c.yPos) < size/2 + c.size/2;
  }
}
