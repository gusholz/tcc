// PARAMETERS / INPUTS
  int frameSize = 2 ; // Min Value = 1 / Max Value = 3 / inversely proportional
  int maxIteration = 20; // Min value = 1 / Max Value <= 20
  int maxLineIterationCount = 50; // Min value >= 40 / Max Value = 120
  float cantorExpoent = 2.3 / 2.4; // Expoents greater than 1 make the frame be expanded, while values lower than 1 make they be reduced
//

// RUNTIME VARIABLES
  int iterationCount = 1;
  boolean iterationEnded = false;
//

// FRAME POINTS
  PVector CORNER_POINT_LEFT_UP;
  PVector CORNER_POINT_RIGHT_UP;
  PVector CORNER_POINT_LEFT_DOWN;
  PVector CORNER_POINT_RIGHT_DOWN;
//

void setup() {
  fullScreen();
  background(#282828);
  frameRate(3); // Changes only the speed of the code execution
  
  setFramePoints();
}

void draw() {
  if(iterationEnded) {
    print("Drawing loop ended");
    noLoop(); // End code execution
  }
   
  noFill();
  stroke(#FAFAFA);    
  float sizeFactor;
  sizeFactor = determineSizeFactor(iterationCount, cantorExpoent);
  float rectWidth = (CORNER_POINT_RIGHT_UP.x - CORNER_POINT_LEFT_UP.x) * sizeFactor;
  float rectHeight = (CORNER_POINT_RIGHT_DOWN.y - CORNER_POINT_RIGHT_UP.y) * sizeFactor;
  
  float strokeFactor = map(
    sizeFactor, 
    1, 
    pow(2/3, maxIteration), 
    8, 
    1
  );
  strokeWeight(strokeFactor);
  
  boolean isOdd = iterationCount % 2 != 0; // condition to check if the iterationCount is a pair or odd number
  drawShapes(
    isOdd, 
    rectWidth,
    rectHeight
  );

  if (iterationCount >= maxIteration) {
    iterationEnded = true;
  }
  
  iterationCount++;
}

// Function based on the Cantor Set, where on each iteration, a fixed amount of a value is taken off
float determineSizeFactor(int iterationCount, float base) {
  float result;
  if (iterationCount == 1) {
    result = 1;
    return result;
  }
  
  result = pow(
    base,
    iterationCount - 1 // expoent
  );
  
  return result;
}

void setFramePoints() {
  CORNER_POINT_LEFT_UP = new PVector(
    width / 8 * frameSize,  // X
    height / 8 * frameSize // Y
  );
  
  CORNER_POINT_RIGHT_UP = new PVector( 
    width - ( width / 8 * frameSize ), // X
    height /   8 * frameSize // Y
  );
  
  CORNER_POINT_LEFT_DOWN = new PVector(
    width / 8 * frameSize, // X
    height - (height / 8 * frameSize) // Y
  );
  
  CORNER_POINT_RIGHT_DOWN = new PVector( 
    width - ( width / 8 * frameSize ), // X
    height - (height / 8 * frameSize) // Y
  );
}

void drawShapes(boolean isOdd, float rectWidth, float rectHeight) {
  if(isOdd) {
    rect(
      CORNER_POINT_LEFT_UP.x, // x1
      CORNER_POINT_LEFT_UP.y, // y1
      rectWidth, // width
      rectHeight // height
    );
    
    // NUMBERS BETWEEN 50 AND 120 WORK FOR MAX_ITERATION_COUNT
    for(int i = 1; i < maxLineIterationCount / 2; i+= 5) {
      strokeWeight(0.8);
      line(
        CORNER_POINT_LEFT_UP.x + rectWidth - i * 4 / iterationCount,
        CORNER_POINT_LEFT_UP.y + rectHeight,
        CORNER_POINT_LEFT_UP.x + rectWidth - i * 4 / iterationCount,
        CORNER_POINT_RIGHT_UP.y
      );
    }
    
    float circleSize = width * 0.5 / frameSize * pow(2.0/3.0,float(iterationCount));

    strokeWeight(1.8);
    circle(
      CORNER_POINT_LEFT_UP.x + rectWidth - circleSize / 2,
      CORNER_POINT_LEFT_UP.y + rectHeight - circleSize / 2,
      circleSize
    );
  } else {
    rect(
      CORNER_POINT_RIGHT_DOWN.x, // x2
      CORNER_POINT_RIGHT_DOWN.y, // y2
      rectWidth * -1, // width
      rectHeight * -1 // height
    );
    strokeWeight(0.8);
    for(int i = 0; i < maxLineIterationCount; i+= 5) {
      line(
        CORNER_POINT_RIGHT_DOWN.x - rectWidth + i * 4 / iterationCount,
        CORNER_POINT_RIGHT_DOWN.y - rectHeight,
        CORNER_POINT_RIGHT_DOWN.x - rectWidth + i * 4 / iterationCount,
        CORNER_POINT_RIGHT_DOWN.y
      );
    }
  }
}

void mousePressed() {
  save("final_output.png"); 
  print("Saved");
}
