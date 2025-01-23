import processing.sound.*;

AudioIn input;
Amplitude loudness;
SoundFile sample;


int steps = 3500; // determine how long to draw the circle / values bigger than 5000 make the circle be too slow

// RUNTIME VARIABLES
int counter = 0;
int iterationCount = 1;
int xCoordinate;
int yCoordinate;
int radius;
// 

void setup() {
  fullScreen();
  background(#F2E9CE);
  
  input = new AudioIn(this, 0);

  input.start();
  sample = new SoundFile(this, "beat.aiff");
  sample.loop();

  loudness = new Amplitude(this);
  loudness.input(input);

  xCoordinate = width / 2;
  yCoordinate = height /2;
  
  radius = height / 2 - 200; 
}

void draw() {                         
  float volume = loudness.analyze();
  float maxSize = width / 2;
  float size = map(volume, 0, 0.5, 1, maxSize / iterationCount);
  
  strokeWeight(8);
  stroke(#F2E9CE);
  line(
    width / 2,
    height * 0.1, 
    width / 2 ,
    height * 0.9
  );
  line(
    width * 0.1,
    height/2, 
    width * 0.9,
    height/2
  );
  
  
  color strokeColor = determineColor(volume);
    
  strokeWeight(1.6);
  stroke(strokeColor);  
  
  if(counter > steps) {
    iterationCount +=1;
    counter = 0;
  } else {
    float theta = TWO_PI / steps * counter;
    float x = xCoordinate + radius * cos(theta)/ iterationCount;
    float y = yCoordinate + radius * sin(theta)/ iterationCount;

    beginShape(LINES);
    vertex(x,y);
    
    if (x < width / 2 && y < height / 2) {
      vertex(x - size, y - size);
    } else if(x < width / 2 && y > height /2) {
      vertex(x - size, y + size);
    } else if(x > width / 2 && y < height / 2 ) {
      vertex(x + size, y - size);
    } else {
      vertex(x + size, y + size);
    }
  
    endShape();
    
    counter += 1;
  }
}

void mousePressed() {
  save("final_output3.png"); 
  print("Saved");
  counter = 0;
  iterationCount = 1;
  background(#F2E9CE);
}

color determineColor(float value) {
  float updatedValue = value * 10000;

  if (updatedValue >= 0 && updatedValue <= 150) {
    return color(#0561D9); // azul pouco saturado
  } else if (updatedValue >= 151 && updatedValue <= 250) {
    return color(#0454F2); // azul mais saturado
  } else if (updatedValue > 250 && updatedValue <= 600) {
    return color(#8C2668); // roxo
  } else if (updatedValue > 600) {
    return color(#F20419); // laranja
  } else {
    return color(50, 50, 50); // cinza para valores negativos
  }
}
