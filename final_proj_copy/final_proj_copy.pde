int numberOfPoints = 9; //<>//
int numberOfPoints2 = 9;
Point[] points = new Point[numberOfPoints];
Circle[] circles = new Circle[numberOfPoints];
Point[] points2 = new Point[numberOfPoints2];
Circle[] circles2 = new Circle[numberOfPoints2];
Point[] points2D = new Point[numberOfPoints2];
Circle[] circles2D = new Circle[numberOfPoints2];
float[] fatEdgePos = new float[4];
color fatEdgeColor = color(0);
float[] fatEdgePosD = new float[4];
color fatEdgeColorD = color(0);
int tSize = 16;
int count1 = 0;
float phase = 0.0;
String intro1 = "Vertex coloring is when we assign a color to each vertex of a graph \nsuch that no neighboring vertices are the same color.\n(Hit the spacebar to continue.)";
String intro2 = "Vertex coloring has various real world applications.\nOne such application is in assigning frequencies to radio stations.\nVertices represent stations, edges are drawn between stations with \nintersecting broadcasting ranges, and colors represent frequencies.\n(Hit the spacebar to continue.)";
String instruction1 = "Let's construct such a graph ourselves.\nClick at "+numberOfPoints+" different places in the white area below \nto place radio stations on a map.";
String instruction2 = "Use the dials on the left to set the broadcasting range for each radio \nstation. Make sure some ranges are intersecting. \nHit the spacebar when ready to continue.";
String instruction3b = "Now, watch as edges are drawn between stations whose coverages\nintersect.";
String noIntersectsMsg = "Please make sure some stations have intersecting ranges.";
String missingRangeMsg = "Please make sure every station has a broadcasting range.";
String instruction4_a = "Now we can color this graph by assigning colors to vertices\nsuch that any two vertices that share an edge are different colors.\nHit the spacebar when ready to continue.";
String instruction4_b1 = "The vertex in your graph that has the most edges is vertex ";
String instruction4_b2 = "\nThat means the maximum degree, delta, of your graph is ";
String instruction4_b3 = ". A graph can \nbe colored with <=delta+1 colors.\nHit the spacebar to watch the vertex coloring happen.";
String instruction5 = "Now that all our vertices have a different color, we can assign \na different frequency to each color.\nHit the spacebar to continue.";
String instruction6 = "And now, no two radio stations that broadcast in the same area\nhave the same frequency.\nWe colored this graph using a standard greedy algorithm. However, \nthere are other heuristics we can employ to end up with a different graph.\n(Hit the spacebar to continue.)"; 
String instruction7 = "DSatur is a heuristic graph coloring algorithm in which the next vertex to be \ncolored is the non-colored vertex with the highest number of unique colors used by \nits neighbors. In this way, it prioritises vertices with fewer colors available to \nthem. This could result in fewer colors being used.";
String instruction8 = "Let's watch what happens when the graph you created is colored using DSatur\ninstead of the standard greedy algorithm.";
String instruction9 = "Now we can assign frequencies again. Hit the spacebar to continue.";
String instruction10 = "Great! Sometimes DSatur gives us a similar result as the standard greedy \nalgorithm, but other times it can really minimize the number of colors we use.\nWatch what happens when this next graph is colored by each algorithm.\n(Hit the spacebar to continue.)";
String instruction10b = "DSatur is a heuristic graph coloring algorithm in which the next vertex to be \ncolored is the non-colored vertex with the highest number of unique colors used by \nits neighbors. By prioritising vertices with fewer colors available to them, it could \nresult in fewer colors being used. Let's watch as a graph is colored first with the \nstandard greedy algor and then with the DSatur algo. Hit the spacebar to continue.";
String instruction12 = "As you can see, the greedy algorithm used 5 colors to color the graph, while \nDSatur only used 3. Check out the rest of this page for some other heuristic \ngraph coloring algorithms and findings. \nHit the spacebar to start over.";
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
int displayingPopup = 0;
color[] colors = {color(255, 40, 65),color(0, 116, 217),color(46, 204, 64),color(255, 133, 27),color(177, 13, 201),color(255, 205, 0),color(240, 18, 190),color(1, 255, 112),color(127, 219, 255)};
color beige = color(234,227,201);
boolean noIntersects = false;
boolean missingRange = false;
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
int waitTime = 600;
int dSaturColoredCircles = 0;
int[] saturationDegrees = new int[numberOfPoints];
int currentPointGreedy = 0;
int currentPointDSatur = 0;
int circleI2 = 0;
int circleI2D = 0;
int circleJ2 = 0;
int circleJ2D = 0;
int colorPhase2 = 0;
color[] availableColors2 = new int[5];
int colorChoice2 = 0;
int dSaturColoredCircles2 = 0;
int[] saturationDegrees2 = new int[numberOfPoints2];
int colorPhase2D = 0;
color[] availableColors2D = new int[5];
int colorChoice2D = 0;


void setup() {
  size(600, 600);
  background(beige);
  drawSidePanel();
  drawTopArea();
  drawMap();
  for (int i = 0; i < numberOfPoints; i++) {
    bxs[i] = width/40+10;
    bys[i] = height/4+30*(i+1)-7.5;
    int rndm = int(random(880,1080));
    if (rndm % 2 == 0) rndm ++;
    radioFrequencies[i] = float(rndm) / 10;
  }
  for (int i = 0; i < 5; i++) {
    availableColors2[i] = colors[i];
  }
  points2[0] = new Point(290,290);
  points2[1] = new Point(324,298);
  points2[2] = new Point(300,340);
  points2[3] = new Point(403,328);
  points2[4] = new Point(395,362);
  points2[5] = new Point(420,395);
  points2[6] = new Point(329,398);
  points2[7] = new Point(360,379);
  points2[8] = new Point(340,330);
  circles2[0] = new Circle(290,290);
  circles2[1] = new Circle(324,298);
  circles2[2] = new Circle(300,340);
  circles2[3] = new Circle(403,328);
  circles2[4] = new Circle(395,362);
  circles2[5] = new Circle(410,390);
  circles2[6] = new Circle(329,398);
  circles2[7] = new Circle(360,379);
  circles2[8] = new Circle(340,330);
  points2[0].addEdge(1);
  points2[0].addEdge(2);
  points2[1].addEdge(2);
  points2[1].addEdge(8);
  points2[2].addEdge(8);
  points2[3].addEdge(4);
  points2[3].addEdge(5);
  points2[3].addEdge(8);
  points2[4].addEdge(5);
  points2[4].addEdge(7);
  points2[5].addEdge(7);
  points2[6].addEdge(7);
  points2[7].addEdge(8);
  circles2[0].size = 53;
  circles2[1].size = 50;
  circles2[2].size = 62;
  circles2[3].size = 68;
  circles2[4].size = 40;
  circles2[5].size = 80;
  circles2[6].size = 61;
  circles2[7].size = 59;
  circles2[8].size = 72;
  for (int i = 0; i < numberOfPoints2; i++) {
    points2D[i] = new Point(points2[i].xpos+7*width/32,points2[i].ypos+7*height/32);
    circles2D[i] = new Circle(circles2[i].xPos+7*width/32,circles2[i].yPos+7*height/32);
    for (int j = 0; j < numberOfPoints2; j++) points2D[i].edges[j] = points2[i].edges[j];
    circles2D[i].size = circles2[i].size;
    points2[i].xpos += 7*width/32;
    circles2[i].xPos += 7*width/32;
    points2[i].ypos -= 5*height/32;
    circles2[i].yPos -= 5*height/32;
  }
  for (int i = 0; i < numberOfPoints2; i++) {
    for (int j = 0; j < numberOfPoints2; j++) {
      if (i != j && circles2[i].isIntersecting(circles2[j])) {
        circles2[i].setIntersecting(j);
        circles2D[i].setIntersecting(j);
      }
    }
  }
  mapSize = 5*width/16;
}

void draw() {
  if (phase == 0.0) {
    startDisplay();
    drawMap();
  }
  else if (phase == 0.1) intro1Display();
  else if (phase == 0.2) intro2Display();
  else if (phase == 0.3) {
    intro3Display();
    drawMap();
    drawSidePanel();
    stroke(0);
    strokeWeight(3);
    fill(255);
    rect(width/4,height/4,width/2,30,10);
    rect(width/4,height/4+40,width/2,30,10);
    fill(0);
    text("Start with standard greedy algorithm",width/4+5,height/4+21);
    text("Skip to DSatur heuristic algorithm",width/4+5,height/4+62);
    if (mouseX>width/4 && mouseX<3*width/4 && ((mouseY>height/4 && mouseY<height/4+30) || (mouseY>height/4+40 && mouseY<height/4+70))) cursor(HAND);
    else cursor(ARROW);
  }
  else if (phase == 1) instruction1Display();
  else if (phase == 2) {
    instruction2Display();
    drawSidePanel();
    drawKnobRanges();
    drawMap();
    drawPoints();
    drawCircles();
    for (int i = 0; i < numberOfPoints; i++) {
      displayKnobs(i);
    }
    if (missingRange) missingRangeMessage();
    else if (noIntersects) noIntersectsMessage();
  }
  else if (phase == 3) {
    instruction3bDisplay();
    drawEdges();
    drawFastForward();
  }
  else if (phase == 4) {
    waitTime = 600;
    drawMap();
    drawPoints();
    for (int i = 0; i < numberOfPoints; i++) {
      bxs[i] = width/40+10;
    }
    instruction4bDisplay(maxDegree, vertexMaxDegree);
  }
  else if (phase == 4.1) {
    if (circleI > numberOfPoints-1) {
      phase = 5;
      displayingPopup = 0;
    }
    else {
      displayingPopup = circleI;
      instruction4bDisplay(maxDegree, vertexMaxDegree);
      drawFastForward();
      drawMap();
      addColors();
      drawSidePanel();
      displayColorPopup(displayingPopup);
      drawPoints();
      for (int i = 0; i < numberOfPoints; i++) {
        bxs[i] = width/40+10;
        displayColorPicker(i);
      }
      if (fatEdgePos[0] != 0.0) drawFatEdge();
    }
  }
  else if (phase == 5) {
    waitTime = 600;
    instruction5Display();
    drawSidePanel();
    for (int i = 0; i < numberOfPoints; i++) {
      displayColorPicker(i);
    }
  }
  else if (phase == 6) {
    instruction6Display();
    drawSidePanel();
    drawMap();
    for (int i = 0; i < numberOfPoints; i++) {
      circles[i].setInterior(color(red(points[i].pColor), green(points[i].pColor), blue(points[i].pColor), 50));
      displayColorPicker(i);
    }
    drawCircles();
  }
  else if (phase == 7) {
    instruction7Display();
    drawSidePanel();
    drawMap();
    for (int i = 0; i < numberOfPoints; i++) {
      circles[i].setInterior(color(255, 0));
      circles[i].setColor(color(0));
      points[i].setColor(color(0));
    }
  }
  else if (phase == 8) {
    if (dSaturColoredCircles >= numberOfPoints) phase = 9;
    else {
      displayingPopup = circleI;
      instruction8Display();
      drawFastForward();
      drawMap();
      addColorsDSatur();
      drawSidePanel();
      displayColorPopup(displayingPopup);
      drawPoints();
      for (int i = 0; i < numberOfPoints; i++) {
        bxs[i] = width/40+10;
        displayColorPicker(i);
      }
      if (fatEdgePos[0] != 0.0) drawFatEdge();
    }
  }
  else if (phase == 9) {
    instruction9Display();
    drawSidePanel();
    for (int i = 0; i < numberOfPoints; i++) {
      displayColorPicker(i);
    }
  }
  else if (phase == 10) {
    instruction10Display();
    drawSidePanel();
    drawMap();
    for (int i = 0; i < numberOfPoints; i++) {
      displayColorPicker(i);
      circles[i].setInterior(color(red(points[i].pColor), green(points[i].pColor), blue(points[i].pColor), 50));
    }
    drawCircles();
  }
  else if (phase == 10.1) {
    instruction10BDisplay();
    drawSidePanel();
    drawMap();
  }
  else if (phase == 11) {
    if (dSaturColoredCircles2 >= numberOfPoints2) phase = 12;
    else {
      currentPointGreedy = circleI2;
      currentPointDSatur = circleI2D;
      instruction11Display();
      drawFastForward();
      drawMap();
      if (circleI2 < numberOfPoints) addColors2();
      else addColors2D();
      drawSidePanel();
      //displayColorPopup(displayingPopup);
      drawPoints2();
      drawPoints2D();
      for (int i = 0; i < numberOfPoints; i++) {
        bxs[i] = width/40+10;
        displayColorPicker2(i);
      }
      if (fatEdgePos[0] != 0.0 && circleI2 < numberOfPoints) drawFatEdge();
      if (fatEdgePosD[0] != 0.0 && circleI2 >= numberOfPoints) drawFatEdgeD();
    }
  }
  else if (phase == 12) {
    instruction12Display();
    drawSidePanel();
    drawMap();
    for (int i = 0; i < numberOfPoints; i++) {
      circles2[i].setInterior(color(red(points2[i].pColor), green(points2[i].pColor), blue(points2[i].pColor), 50));
      circles2D[i].setInterior(color(red(points2D[i].pColor), green(points2D[i].pColor), blue(points2D[i].pColor), 50));
      displayColorPicker2(i);
    }
    drawCircles2();
    drawCircles2D();
  }
}

// ~~~~ INSTRUCTIONS

void startDisplay() {
  drawTopArea();
  stroke(0);
  strokeWeight(3);
  fill(255);
  rect(width/4,height/40,width/2,50,10);
  fill(0);
  textSize(36);
  textAlign(CENTER);
  text("Click to begin", width/2, height/10-tSize/2);
  textAlign(LEFT);
  if (mouseX>width/4 && mouseX<3*width/4 && mouseY>height/40 && mouseY<height/40+50) cursor(HAND);
  else cursor(ARROW);
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

void intro3Display() {
  drawTopArea();
  fill(0);
  textSize(tSize);
  text("Select an option:", width/40, height/15-tSize/2);
}

void instruction1Display() {
  drawTopArea();
  drawSidePanel();
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
  +" , with "+delta+" edges."
  +instruction4_b2+delta
  +instruction4_b3,
  width/40, height/20-tSize/2);
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

void instruction7Display() {
  drawTopArea();
  fill(0);
  textSize(tSize);
  text(instruction7, width/40, height/20-tSize/2);
}

void instruction8Display() {
  drawTopArea();
  fill(0);
  textSize(tSize);
  text(instruction8, width/40, height/20-tSize/2);
}

void instruction9Display() {
  drawTopArea();
  fill(0);
  textSize(tSize);
  text(instruction9, width/40, height/15-tSize/2);
}

void instruction10Display() {
  drawTopArea();
  fill(0);
  textSize(tSize);
  text(instruction10, width/40, height/20-tSize/2);
}

void instruction10BDisplay() {
  drawTopArea();
  fill(0);
  textSize(tSize);
  text(instruction10b, width/40, height/20-tSize/2);
}

void instruction11Display() {
  drawTopArea();
  fill(0);
  textSize(tSize);
  text("Greedy: color vertices in order\nDSatur: color non-colored vertex with most colored neighbors", width/40, height/20-tSize/2);
}

void instruction12Display() {
  drawTopArea();
  fill(0);
  textSize(tSize);
  text(instruction12, width/40, height/20-tSize/2);
}

// ~~~~ DRAW

void drawPoints() {
  for (int i = 0; i < numberOfPoints; i++) points[i].display(i);
}

void drawCircles() {
  for (int i = 0; i < numberOfPoints; i++) circles[i].display();
}

void drawPoints2() {
  for (int i = 0; i < numberOfPoints2; i++) points2[i].display2(i);
}

void drawCircles2() {
  for (int i = 0; i < numberOfPoints2; i++) circles2[i].display();
}

void drawPoints2D() {
  for (int i = 0; i < numberOfPoints2; i++) points2D[i].display2D(i);
}

void drawCircles2D() {
  for (int i = 0; i < numberOfPoints2; i++) circles2D[i].display();
}

void drawMap() {
  if (phase < 1 || phase == 10.1) {
    noStroke();
    fill(beige);
    rect(width/4, height/4, 3*width/4, 3*height/4);
  }
  else if (phase < 2) {
    stroke(180);
    strokeWeight(2);
    fill(255);
    rect(width/4+(3*width/4-mapSize)/2, width/4+(3*width/4-mapSize)/2, mapSize, mapSize);
  } 
  else if (phase >= 11) {
    stroke(180);
    strokeWeight(2);
    fill(255);
    rect(5*width/8,height/4,3*width/8-2,3*height/8);
    rect(5*width/8,5*height/8,3*width/8-2,3*height/8-2);
    //rect(width/4,height/4,3*width/8-2,3*height/4-2);
    //rect(5*width/8,height/4,3*width/8-2,3*height/4-2);
  }
  else {
    stroke(180);
    strokeWeight(2);
    fill(255);
    rect(width/4, height/4, 3*width/4-2, 3*height/4-2);
  }
}

void drawSidePanel() {
  fill(beige);
  noStroke();  
  if (phase < 11) rect(0,height/4,width/4,3*height/4);
  else rect(0,height/4,5*width/8,3*height/4);
}

void drawTopArea() {
  fill(beige);
  noStroke();
  rect(0,0,width,height/4);
}

void drawFastForward() {
  fill(255);
  stroke(0);
  strokeWeight(3);
  rect(7*width/8-10,3*height/16,width/8,3*height/64,10);
  fill(0);
  textSize(tSize);
  text("Click and hold to fast forward:",width/2-5,7*height/32+3);
  text(">>",15*width/16-20,7*height/32+3);
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

void drawEdges() {
  if (circleI < numberOfPoints && circleJ < numberOfPoints) {
    if (circleI != circleJ && circles[circleI].intersecting[circleJ] && !points[circleJ].edges[circleI]) {
      if (time < 0) time = millis();
      // set circleI to red
      if (circlePhase == 0) {
        circles[circleI].setInterior(color(255,0,0,50));
        circlePhase = 1;
        time = -1;
      }
      // wait, set circleJ to red
      else if (circlePhase == 1 && millis() - time >= waitTime) {
        circles[circleJ].setInterior(color(255,0,0,50));
        circlePhase = 2;
        time = -1;
      } 
      // wait, add edge
      else if (circlePhase == 2 && millis() - time >= waitTime) {
        points[circleI].addEdge(circleJ);
        circlePhase = 3;
        time = -1;
      } 
      // wait, set circleJ to clear, j++ or circlePhase = 4
      else if (circlePhase == 3 && millis() - time >= waitTime) {
        circles[circleJ].setInterior(color(255,0));
        if (circleJ < numberOfPoints-1) {
          circleJ++;
          circlePhase = 1;
        }
        else circlePhase = 4;
        time = -1;
      } 
      // wait, set circleI to clear
      else if (circlePhase == 4 && millis() - time >= waitTime) {
        circles[circleI].setInterior(color(255,0));
        circles[circleI].setColor(0);
        circlePhase = 5;
        time = -1;
      }
      else if (circlePhase == 5 && millis() - time >= waitTime) {
        circleI++;
        circleJ = 0;
        circlePhase = 0;
        time = -1;
      }
    } else { // not intersecting or i==j
      if (time < 0) time = millis();
      if (circleJ >= numberOfPoints-1) {
        if (circles[circleI].outer == color(255,0,0)) {
          if (millis() - time >= waitTime) {
            circles[circleI].setInterior(color(255,0));
            circles[circleI].setColor(0);
            circleJ = 0;
            circleI++;
            circlePhase = 0;
            time = -1;
          } 
        } else {
          circleJ = 0;
            circleI++;
            circlePhase = 0;
            time = -1;
        }
      } else {
        circleJ++;
        if (circlePhase == 0) circlePhase = 0;
        else circlePhase = 1;
        time = -1;
      }
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
    if (colorPhase == 0 && millis() - time >= waitTime) {
      for (int i = 0; i < maxDegree+1; i++) {
        availableColors[i] = colors[i];
      }
      points[circleI].setColor(availableColors[colorChoice]);
      colorPhase = 1;
      time = -1;
    } else if (colorPhase == 1) {
      if (circleI != circleJ && circles[circleI].isIntersecting(circles[circleJ])) {
        if (millis() - time >= waitTime) {
          fatEdgePos[0] = points[circleI].xpos;
          fatEdgePos[1] = points[circleI].ypos;
          fatEdgePos[2] = points[circleJ].xpos;
          fatEdgePos[3] = points[circleJ].ypos;
          fatEdgeColor = points[circleJ].pColor;
          colorPhase = 2;
          time = -1;
        }
      } else {
        fatEdgePos[0] = 0.0;
        circleJ++;
        if (circleJ > numberOfPoints-1) {
          circleJ = 0;
          circleI++;
          colorPhase = 0;
        }
        time = -1;
      }
    } else if (colorPhase == 2 && millis() - time >= waitTime) {
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
        fatEdgePos[0] = 0.0;
        colorPhase = 1;
        circleJ++;
        if (circleJ > numberOfPoints-1) {
          circleJ = 0;
          circleI++;
          colorPhase = 0;
        }
        time = -1;
      }
    } else if (colorPhase == 3 && millis() - time >= waitTime) {
      fatEdgePos[0] = 0.0;
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
}

void addColorsDSatur() {
  if (circleI < numberOfPoints && circleJ < numberOfPoints && dSaturColoredCircles < numberOfPoints) {
    if (time < 0) time = millis();
    if (colorPhase == 0 && millis() - time >= waitTime) {
      for (int i = 0; i < maxDegree+1; i++) {
        availableColors[i] = colors[i];
      }
      points[circleI].setColor(availableColors[colorChoice]);
      colorPhase = 1;
      time = -1;
    } else if (colorPhase == 1) {
      if (circleI != circleJ && circles[circleI].isIntersecting(circles[circleJ])) {
        if (millis() - time >= waitTime) {
          fatEdgePos[0] = points[circleI].xpos;
          fatEdgePos[1] = points[circleI].ypos;
          fatEdgePos[2] = points[circleJ].xpos;
          fatEdgePos[3] = points[circleJ].ypos;
          fatEdgeColor = points[circleJ].pColor;
          colorPhase = 2;
          time = -1;
        }
      } else {
        fatEdgePos[0] = 0.0;
        circleJ++;
        if (circleJ > numberOfPoints-1) {
          circleJ = 0;
          circleI = findNextCircleI();
          colorPhase = 0;
          //colorChoice = 0;
          //dSaturColoredCircles++;
        }
        time = -1;
      }
    } else if (colorPhase == 2 && millis() - time >= waitTime) {
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
        fatEdgePos[0] = 0.0;
        colorPhase = 1;
        //saturationDegrees[circleJ]++;
        circleJ++;
        if (circleJ > numberOfPoints-1) {
          circleJ = 0;
          circleI = findNextCircleI();
          colorPhase = 0;
          //colorChoice = 0;
          //dSaturColoredCircles++;
        }
        time = -1;
      }
    } else if (colorPhase == 3 && millis() - time >= waitTime) {
      fatEdgePos[0] = 0.0;
      colorChoice = 0;
      colorPhase = 1;
      circleJ++;
      if (circleJ > numberOfPoints-1) {
        circleJ = 0;
        circleI = findNextCircleI();
        colorPhase = 0;
      }
    }
  }
}

int findNextCircleI() {
  for (int i = 0; i < numberOfPoints; i++) {
    saturationDegrees[i] = 0;
    for (int j = 0; j < numberOfPoints; j++) {
      if (i != j && circles[i].isIntersecting(circles[j])) {
        if (points[j].pColor != color(0)) saturationDegrees[i]++;
      }
    }
  }
  int maxDegSatur = 0;
  int nextCircleI = 0;
  while (points[nextCircleI].pColor != color(0) && nextCircleI < numberOfPoints-1) nextCircleI++;
  for (int i = 0; i < numberOfPoints; i++) {
    if (points[i].pColor == color(0) && saturationDegrees[i] > maxDegSatur) {
      maxDegSatur = saturationDegrees[i];
      nextCircleI = i;
    }
  }
  dSaturColoredCircles++;
  return nextCircleI;
}

void drawFatEdge() {
  strokeWeight(3);
  stroke(fatEdgeColor);
  line(fatEdgePos[0],fatEdgePos[1],fatEdgePos[2],fatEdgePos[3]);
}

void addColors2() {
  if (circleI2 < numberOfPoints2 && circleJ2 < numberOfPoints2) {
    if (time < 0) time = millis();
    if (colorPhase2 == 0 && millis() - time >= waitTime) {
      for (int i = 0; i < 5; i++) {
        availableColors2[i] = colors[i];
      }
      points2[circleI2].setColor(availableColors2[colorChoice2]);
      colorPhase2 = 1;
      time = -1;
    } else if (colorPhase2 == 1) {
      if (circleI2 != circleJ2 && circles2[circleI2].isIntersecting(circles2[circleJ2])) {
        if (millis() - time >= waitTime) {
          fatEdgePos[0] = points2[circleI2].xpos;
          fatEdgePos[1] = points2[circleI2].ypos;
          fatEdgePos[2] = points2[circleJ2].xpos;
          fatEdgePos[3] = points2[circleJ2].ypos;
          fatEdgeColor = points2[circleJ2].pColor;
          colorPhase2 = 2;
          time = -1;
        }
      } else {
        fatEdgePos[0] = 0.0;
        circleJ2++;
        if (circleJ2 > numberOfPoints2-1) {
          circleJ2 = 0;
          circleI2++;
          colorPhase2 = 0;
        }
        time = -1;
      }
    } else if (colorPhase2 == 2 && millis() - time >= waitTime) {
      if (points2[circleJ2].pColor != color(0)) {
        for (int i = 0; i < 5; i++) {
          if (availableColors2[i] == points2[circleJ2].pColor) {
            availableColors2[i] = color(0);
          }
        }
        while (availableColors2[colorChoice2] == color(0)) {
          colorChoice2++;
        }
        points2[circleI2].setColor(availableColors2[colorChoice2]);
        colorPhase2 = 3;
        time = -1;
      } else {
        fatEdgePos[0] = 0.0;
        colorPhase2 = 1;
        circleJ2++;
        if (circleJ2 > numberOfPoints2-1) {
          circleJ2 = 0;
          circleI2++;
          colorPhase2 = 0;
        }
        time = -1;
      }
    } else if (colorPhase2 == 3 && millis() - time >= waitTime) {
      fatEdgePos[0] = 0.0;
      colorChoice2 = 0;
      colorPhase2 = 1;
      circleJ2++;
      if (circleJ2 > numberOfPoints2-1) {
        circleJ2 = 0;
        circleI2++;
        colorPhase2 = 0;
      }
    }
  } 
}

void addColors2D() {
  if (circleI2D < numberOfPoints && circleJ2D < numberOfPoints && dSaturColoredCircles2 < numberOfPoints2) {
    if (time < 0) time = millis();
    if (colorPhase2D == 0 && millis() - time >= waitTime) {
      for (int i = 0; i < 5; i++) {
        availableColors2D[i] = colors[i];
      }
      points2D[circleI2D].setColor(availableColors2D[colorChoice2D]);
      colorPhase2D = 1;
      time = -1;
    } else if (colorPhase2D == 1) {
      if (circleI2D != circleJ2D && circles2D[circleI2D].isIntersecting(circles2D[circleJ2D])) {
        if (millis() - time >= waitTime) {
          fatEdgePosD[0] = points2D[circleI2D].xpos;
          fatEdgePosD[1] = points2D[circleI2D].ypos;
          fatEdgePosD[2] = points2D[circleJ2D].xpos;
          fatEdgePosD[3] = points2D[circleJ2D].ypos;
          fatEdgeColorD = points2D[circleJ2D].pColor;
          colorPhase2D = 2;
          time = -1;
        }
      } else {
        fatEdgePosD[0] = 0.0;
        circleJ2D++;
        if (circleJ2D > numberOfPoints2-1) {
          circleJ2D = 0;
          circleI2D = findNextCircleI2();
          colorPhase2D = 0;
          //colorChoice = 0;
          //dSaturColoredCircles++;
        }
        time = -1;
      }
    } else if (colorPhase2D == 2 && millis() - time >= waitTime) {
      if (points2D[circleJ2D].pColor != color(0)) {
        for (int i = 0; i < 5; i++) {
          if (availableColors2D[i] == points2D[circleJ2D].pColor) {
            availableColors2D[i] = color(0);
          }
        }
        while (availableColors2D[colorChoice2D] == color(0)) {
          colorChoice2D++;
        }
        points2D[circleI2D].setColor(availableColors2D[colorChoice2D]);
        colorPhase2D = 3;
        time = -1;
      } else {
        fatEdgePosD[0] = 0.0;
        colorPhase2D = 1;
        //saturationDegrees[circleJ]++;
        circleJ2D++;
        if (circleJ2D > numberOfPoints2-1) {
          circleJ2D = 0;
          circleI2D = findNextCircleI2();
          colorPhase2D = 0;
          //colorChoice = 0;
          //dSaturColoredCircles++;
        }
        time = -1;
      }
    } else if (colorPhase2D == 3 && millis() - time >= waitTime) {
      fatEdgePosD[0] = 0.0;
      colorChoice2D = 0;
      colorPhase2D = 1;
      circleJ2D++;
      if (circleJ2D > numberOfPoints2-1) {
        circleJ2D = 0;
        circleI2D = findNextCircleI2();
        colorPhase2D = 0;
      }
    }
  }
}

int findNextCircleI2() {
  for (int i = 0; i < numberOfPoints2; i++) {
    saturationDegrees2[i] = 0;
    for (int j = 0; j < numberOfPoints2; j++) {
      if (i != j && circles2D[i].isIntersecting(circles2D[j])) {
        if (points2D[j].pColor != color(0)) saturationDegrees2[i]++;
      }
    }
  }
  int maxDegSatur = 0;
  int nextCircleI = 0;
  while (points2D[nextCircleI].pColor != color(0) && nextCircleI < numberOfPoints2-1) nextCircleI++;
  for (int i = 0; i < numberOfPoints; i++) {
    if (points2D[i].pColor == color(0) && saturationDegrees2[i] > maxDegSatur) {
      maxDegSatur = saturationDegrees2[i];
      nextCircleI = i;
    }
  }
  dSaturColoredCircles2++;
  return nextCircleI;
}

void drawFatEdgeD() {
  strokeWeight(3);
  stroke(fatEdgeColorD);
  line(fatEdgePosD[0],fatEdgePosD[1],fatEdgePosD[2],fatEdgePosD[3]);
}

void displayColorPicker(int i) {
  stroke(0);
  strokeWeight(1);
  fill(0);
  textSize(tSize);
  text(i+1, width/40-10, height/4+30*(i+1)+6);
  if (points[i].pColor == color(0)) fill(color(255));
  else fill(points[i].pColor);
  if (phase == 4.1 || phase == 8) {
    if (i == displayingPopup) strokeWeight(3);
    ellipse(bxs[i]+boxSize/2, bys[i]+boxSize/2, boxSize, boxSize);
    fill(0);
  } else if ((phase >= 5 && phase <= 7) || phase >= 9) {
    ellipse(bxs[i]+boxSize/2, bys[i]+boxSize/2, boxSize, boxSize);
    String freq = "";
    for (int j = 0; j < numberOfPoints; j++) {
      if (points[i].pColor == colors[j]) freq = str(radioFrequencies[j]);
    }
    fill(0);
    text(freq,bxs[i]+boxSize*2,bys[i]+boxSize/2+5);
  }
}

void displayColorPicker2(int i) {
  stroke(0);
  strokeWeight(1);
  fill(0);
  textSize(tSize);
  text("Greedy",bxs[i]+boxSize/2,height/4+30);
  text("DSatur",bxs[i]+8*boxSize,height/4+30);
  text(i+1, width/40-10, height/4+30*(i+1)+40);
  if (points2[i].pColor == color(0)) fill(color(255));
  else fill(points2[i].pColor);
  if (phase == 11) {
    if (i == currentPointGreedy) strokeWeight(3);
    ellipse(bxs[i]+boxSize/2, bys[i]+boxSize/2+30, boxSize, boxSize);
    if (points2D[i].pColor == color(0)) fill(color(255));
    else fill(points2D[i].pColor);
    strokeWeight(1);
    if (i == currentPointDSatur) strokeWeight(3);
    ellipse(bxs[i]+8*boxSize, bys[i]+boxSize/2+30, boxSize, boxSize);
  } else if (phase == 12) {
    ellipse(bxs[i]+boxSize/2, bys[i]+boxSize/2+30, boxSize, boxSize);
    if (points2D[i].pColor == color(0)) fill(color(255));
    else fill(points2D[i].pColor);
    ellipse(bxs[i]+8*boxSize, bys[i]+boxSize/2+30, boxSize, boxSize);
    String freq = "";
    String freqD = "";
    for (int j = 0; j < numberOfPoints; j++) {
      if (points2[i].pColor == colors[j]) freq = str(radioFrequencies[j]);
      if (points2D[i].pColor == colors[j]) freqD = str(radioFrequencies[j]);
    }
    fill(0);
    text(freq,bxs[i]+boxSize*2,bys[i]+boxSize/2+35);
    text(freqD,bxs[i]+boxSize*9,bys[i]+boxSize/2+35);    
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
  text("Vertex " + (i+1), bxs[i], bys[numberOfPoints-1] + boxSize*3);
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

void findDelta() {
  for (int i = 0; i < numberOfPoints; i++) {
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
  for (int i = -7; i < 10; i++) {
    for (int j = -7; j < 8; j++) {
      if (get(mouseX+i,mouseY+j) != color(255)) return false;
    }
  }
  return insideBox;
}

// ~~~~ USER INTERACTION

void mouseClicked() {
  if (phase == 0.0 && mouseX > width/4 && mouseX < 3*width/4 && mouseY > height/40 && mouseY < height/40 + 50) {
    phase = 0.1;
    cursor(ARROW);
  }
  else if (phase == 0.3 && mouseX > width/4 && mouseX < 3*width/4 && mouseY > height/4 && mouseY < height/4 + 30) {
    drawMap();
    phase = 1;
    drawMap();
    cursor(ARROW);
  } else if (phase == 0.3 && mouseX > width/4 && mouseX < 3*width/4 && mouseY > height/4+40 && mouseY < height/4 + 70) {
    phase = 10.1;
    cursor(ARROW);
  }
  if (phase == 1 && checkPointOkay()) {
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
  else if ((phase == 3 || phase == 4.1 || phase == 8 || phase == 11) && mouseX>7*width/8-10 && mouseX<width-10 && mouseY>3*height/16 && mouseY<15*height/64) { 
    waitTime = 200;
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
  } else if ((phase == 3 || phase == 4.1 || phase == 8 || phase == 11) && mouseX>7*width/8-10 && mouseX<width-10 && mouseY>3*height/16 && mouseY<15*height/64) { 
    waitTime = 600;
  }
}

void keyReleased() {
  if (phase == 0.1 && key == ' ') phase = 0.2;
  else if (phase == 0.2 && key == ' ') phase = 0.3;
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
    phase = 4.1;
  }
  else if (phase == 5 && key == ' ') {
    phase = 6;
  }
  else if (phase == 6 && key == ' ') {
    phase = 7;
  }
  else if (phase == 7 && key == ' ') {
    colorChoice = 0;
    circleI = 0;
    circleJ = 0;
    for (int i = 0; i < maxDegree+1; i++) {
      availableColors[i] = colors[i];
    }
    phase = 8;
  }
  else if (phase == 9 && key == ' ') {
    phase = 10;
  }
  else if (phase == 10 && key == ' ') {
    phase = 11;
  }
  else if (phase == 10.1 && key == ' ') {
    phase = 11;
  }
  else if (phase == 12 && key == ' ') {
    circleI2 = 0;
    circleJ2 = 0;
    circleI2D = 0;
    circleJ2D = 0;
    colorPhase2 = 0;
    colorPhase2D = 0;
    colorChoice2 = 0;
    colorChoice2D = 0;
    for (int i = 0; i < numberOfPoints2; i++) {
      points2[i].pColor = color(0);
      points2D[i].pColor = color(0);
      saturationDegrees2[i] = 0;
    }
    currentPointGreedy = 0;
    currentPointDSatur = 0;
    dSaturColoredCircles = 0;
    dSaturColoredCircles2 = 0;
    waitTime = 600;
    phase = 0.3;
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
  void display2(int c) {
    strokeWeight(1);
    stroke(0);
    for (int i = 0; i < numberOfPoints; i++) {
      if (edges[i]) line(xpos,ypos,points2[i].xpos,points2[i].ypos);
    }
    fill(pColor);
    stroke(pColor);
    strokeWeight(9);
    point(xpos,ypos);
    textSize(12);
    text(c+1,xpos+4,ypos-2);
  }
  void display2D(int c) {
    strokeWeight(1);
    stroke(0);
    for (int i = 0; i < numberOfPoints; i++) {
      if (edges[i]) line(xpos,ypos,points2D[i].xpos,points2D[i].ypos);
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
