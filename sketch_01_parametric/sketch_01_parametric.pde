// CONSTANTS
  int pointInterval = 8;
// 

// VARIABLES / INPUTS / PARAMETERS
  int frameSize = 1 ; // Min Value > 1 / Max Value = 3 / inversely proportional
  int counter = 0;
  int secondCounter = 0;
//

// FRAME POINTS
  PVector CORNER_POINT_LEFT_UP;
  PVector CORNER_POINT_RIGHT_UP;
  PVector CORNER_POINT_LEFT_DOWN;
  PVector CORNER_POINT_RIGHT_DOWN;
//

void setup() {
  // size(1920,1080);
  fullScreen();
  background(30);
  smooth(3);  
  // frameRate(4);
  
  // FRAME POINTS
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
  //
}

void draw() {
  noFill();
  stroke(#FAFAFA);  

  // Frame
  rect(
    CORNER_POINT_LEFT_UP.x, 
    CORNER_POINT_LEFT_UP.y, 
    width - ( width / 8 * frameSize ) - width / 8 * frameSize, 
    height - (height / 8 * frameSize) - height / 8 * frameSize
  );
  //
  
  // First Line Segments
  line(
    CORNER_POINT_LEFT_DOWN.x, 
    CORNER_POINT_LEFT_DOWN.y, 
    width/2, 
    height/2 - counter 
  );
  
  line(
    CORNER_POINT_RIGHT_DOWN.x, 
    CORNER_POINT_RIGHT_DOWN.y,
    width/2, 
    height/2 - counter
  );
  //
  
  // Second Line Segments
  line(
    CORNER_POINT_LEFT_UP.x, 
    CORNER_POINT_LEFT_UP.y, 
    width/2, 
    height/2 + counter 
  );
  
  line(
    CORNER_POINT_RIGHT_UP.x, 
    CORNER_POINT_RIGHT_UP.y,
    width/2, 
    height/2 + counter
  );
  //
  
  // LINE COUNTER CONDITIONAL
   if (height / 2 - counter >  height / 8 * frameSize) {
    counter += 27; // Only multiples of 3
  //  
  }
  
  if (width / 8 + secondCounter < width - 3 * width / 8 * frameSize) {
    secondCounter += 21;
  }
}



void mouseMoved() {
  
}



void mousePressed() {
  save("output5.png"); 
  print("Saved");
}
