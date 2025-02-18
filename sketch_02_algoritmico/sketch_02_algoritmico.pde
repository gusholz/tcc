// Sound Library Import
import processing.sound.*;

// SOUND VARIABLES
BeatDetector beatDetector;
Amplitude amplitude;
SoundFile sample;
//

final int steps = 2400; 
// Determines the number of steps to finish a circle
// Greater values make the circle be drawn slower
// Smaller values make the circle be drawn faster

// RUNTIME VARIABLES
int counter = 0;
int circleCount = 1;
//
// Circle Variables
int xCoordinate;
int yCoordinate;
int circleRadius;
//

// COLORS
color lowSaturationBlue = #0561D9;
color mediumSaturationBlue = #0454F2;
color purple = #8C2668;
color orange = #F20419;
color gray = #808080;
//

void setup() {
  // Determines the output resolution
  fullScreen();
  
  // Determines the output background color
  background(#F2E9CE);
  
  // Sets the color mode to Hue Saturation Brightness
  colorMode(HSB, 360, 200, 100);

  // Instantiates a SoundFile, an Amplitude reader and a Beat Detector
  sample = new SoundFile(this, "nujabesBeat.wav");
  amplitude = new Amplitude(this);
  beatDetector = new BeatDetector(this);

  // Chanells the sample as the input source of the Amplitude and BeatDetector
  beatDetector.input(sample);
  amplitude.input(sample);

  // Play the selected sample
  sample.play();
  
  setCircleProperties();
}

void draw() {                         
  if (counter > steps) {
    // Whenever counter is greater than the steps,
    // circleCount is incremented and counter is reinitiated
    circleCount += 1;
    counter = 0;
    return;
  } 
  
  float soundAmplitude = amplitude.analyze();
  
  float maxLineSize = width / 12;  
  float theta = TWO_PI / steps * counter;
  float x = xCoordinate + circleRadius * cos(theta) / circleCount;
  float y = yCoordinate + circleRadius * sin(theta) / circleCount;
  float multiplier = getBeatMultiplier();
    
  float lineSize = map(
    soundAmplitude, 
    -1, 
    1, 
    1, 
    maxLineSize / circleCount) * multiplier;
  
  PVector secondVertex = determineSecondVertex(x,y,lineSize);
  
  color strokeValue = determineColor(soundAmplitude);
  strokeWeight(1.2);
  stroke(strokeValue, 50);

  beginShape(LINES);
  vertex(x, y);
  vertex(secondVertex.x, secondVertex.y);  
  endShape();

  counter += 1;
}

color determineColor(float value) {
  float updatedValue = value * 1000;

  if (updatedValue >= 0 && updatedValue <= 250) {
    return lowSaturationBlue;
  } else if (updatedValue >= 251 && updatedValue <= 500) {
    return mediumSaturationBlue;
  } else if (updatedValue > 500 && updatedValue <= 750) {
    return purple;
  }
  
  return orange;
}

void setCircleProperties() {
  xCoordinate = width / 2;
  yCoordinate = height / 2;
  circleRadius = height / 2 - 200; 
}

float getBeatMultiplier() {
  boolean isBeat = beatDetector.isBeat();
  float multiplier;
  if (isBeat) {
    multiplier = 3;
  } else {
    multiplier = 1;
  }
  
  return multiplier;
}

PVector determineSecondVertex(float x, float y, float lineSize) {
  PVector secondVertex;
  
  if (x < width / 2 && y < height / 2) {
    secondVertex = new PVector(x - lineSize, y - lineSize);
  } else if (x < width / 2 && y > height / 2) {
    secondVertex = new PVector(x - lineSize, y + lineSize);
  } else if (x > width / 2 && y < height / 2) {
    secondVertex = new PVector(x + lineSize, y - lineSize);
  } else {
    secondVertex = new PVector(x + lineSize, y + lineSize);
  }
  
  return secondVertex;
}

void mousePressed() {
  save("final_output_7.png"); 
  print("Saved");
  noLoop();
}
