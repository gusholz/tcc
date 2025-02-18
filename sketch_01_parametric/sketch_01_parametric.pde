// PARAMETERS / INPUTS
  final int frameSize = 3;
  // Minimum value = 1 / Maximum Value = 3
  // determines the frame size
  // 1 => Large sized frame
  // 2 => Medium sized frame
  // 3 => Small sized frame

  
  final int maxIteration = 6;
  // Minimum value = 1
  // determines the number of iterations of the drawing process:
  // Greater values make the output more convoluted
  // Smaller values make the output more sparce
  
  
  final int maxLineIterationCount = 100; 
  // Minimum value = 5 / Maximum Value = 120
  // determines the number of lines drawn on each odd cycle iteration
  // Greater values make the output more convoluted
  // Smaller values make the output more sparce
  
    
  final float cantorExpoent = 1.13;
  // The most important input of the system
  // numbers greater than 1 make the frame be expanded by the difference to 1 on each cycle iteration
  // while numbers smaller than 1 make the frame be reduced by the difference to 1 on each cycle iteration
  // example:
  // cantorExpoent = 0.94 --> Make the frame be reduced by 6% on each cycle iteration
  // cantorExpoent = 1.42 --> Make the frame be expanded by 42% on each cycle iteration

//

// RUNTIME VARIABLES
  int iterationCount = 1;
  boolean iterationEnded = false;
  JSONObject json;
//

// FRAME POINTS
  PVector CORNER_POINT_LEFT_UP;
  PVector CORNER_POINT_RIGHT_UP;
  PVector CORNER_POINT_LEFT_DOWN;
  PVector CORNER_POINT_RIGHT_DOWN;
  PVector FRAME;
//

void setup() {
  // Determines the output resolution
  fullScreen();
  
  // Determines the output background color
  background(#282828);
  
  // Determines the speed of the code execution / Doesn't change the final output
  frameRate(4); 
  
  setFramePoints();
  setFrameSize();
}

void draw() {
  if(iterationEnded) {
    print("Drawing loop ended");
    noLoop(); // End code execution
  }
   
  float sizeFactor  = setNewSizeFactor(cantorExpoent, iterationCount);
  
  float newRectWidth = FRAME.x * sizeFactor;
  float newRectHeight = FRAME.y * sizeFactor;
  
  float strokeFactor = setNewStrokeWeight(sizeFactor);
  print("New stroke factor: ");
  print(strokeFactor);
  strokeWeight(strokeFactor);
  
  // condition to check if the iterationCount is a pair or odd number
  boolean isOdd = iterationCount % 2 != 0; 
  
  drawShapes(
    isOdd, 
    newRectWidth,
    newRectHeight
  );

  if (iterationCount >= maxIteration) {
    iterationEnded = true;
  }
  
  iterationCount++;
}

float setNewStrokeWeight(float base) {
  float result = pow(
    base,
    iterationCount - 1
  );
  
  if (result > 1) {
    return result / 3;
  } else {
    return result * 3;
  }
}

float setNewSizeFactor(float base, int iterationCount) {
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

void setFrameSize() {
  float x = CORNER_POINT_RIGHT_UP.x - CORNER_POINT_LEFT_UP.x;
  float y = CORNER_POINT_LEFT_DOWN.y - CORNER_POINT_LEFT_UP.y;
  FRAME = new PVector(x,y);
}

void drawShapes(boolean isOdd, float rectWidth, float rectHeight) {
  noFill();
  
  // Determines the foreground color
  stroke(#FAFAFA);    
  
  if(isOdd) {
    rect(
      CORNER_POINT_LEFT_UP.x,
      CORNER_POINT_LEFT_UP.y,
      rectWidth,
      rectHeight
    );
    
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
      CORNER_POINT_RIGHT_DOWN.x,
      CORNER_POINT_RIGHT_DOWN.y,
      rectWidth * -1, 
      rectHeight * -1 
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
  print("Saved output  ");
  String outputString = 
    "final_output_" + 
    frameSize + "_" + 
    maxIteration + "_" + 
    maxLineIterationCount + "_" + 
    cantorExpoent + "_"  +
    ".png";
    
  save(outputString); 
}
