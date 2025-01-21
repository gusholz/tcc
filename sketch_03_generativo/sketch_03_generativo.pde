float scale = 10;
int rows, columns;
float[][] flowfield;

Particle[] swarm;
int swarmSize = 12400;

void setup() {
  fullScreen();
  colorMode(HSB, 360, 100, 100);
  
  swarm = new Particle[swarmSize];
  for(int i = 0; i< swarmSize; i++) {
    swarm[i] = new Particle();
  }
  
  rows = int(height/scale);
  columns = int(width/scale);
  flowfield = new float[rows][columns];
  
  generateFlowField();
  // generateFlowfieldPattern();
  
  background(#282828);
}

void draw() {
  // drawFlowfield();
  // illustrateFlowfield();
  // background(0);
  
  for(int i = 0; i< swarmSize; i++) {
    swarm[i].display();
    swarm[i].updatePosition();
  }
}

void drawFlowfield() {
  stroke(0,0,100);
  for(int i = 0; i< rows; i++){
    for(int j = 0; j< columns; j++) {
      pushMatrix();
      translate(j * scale, i * scale);
      rotate(flowfield[i][j]);
      
      // flowfield[i][j] is equivalent to a specific angle
      float strokeValue = map(flowfield[i][j], 0, 2 * PI, 0, 360);
      stroke(strokeValue, 100, 100);
      line(0,0, scale * 0.5, 0);
      popMatrix();
    }
  }
}

void illustrateFlowfield() {
  float x, y;
  float newXvalue, newYvalue;
  int c = 0;
  x = random(width);
  y = random(height);
  
  do {
    float angle = flowfield[int(y/scale)][int(x/scale)];
    newXvalue = x + scale * cos(angle);
    newYvalue = y + scale * sin(angle);
    stroke(
      map(angle, 0, 2 * PI, 0, 360),
      map(angle, 0, 2* PI, 0, 100),
      map(angle, 0, 2* PI, 0, 100)  
      );
    line(x,y, newXvalue, newYvalue);
    x = newXvalue;
    y = newYvalue;
    c++;
  } while(c < 20 && x > 0 && x < width && y > 0 && y < height);
}

void generateFlowField() {
  float noiseScale = 0.01;
  for(int i = 0; i < rows; i++) {
    for(int j = 0; j < columns; j++) {
      flowfield[i][j] = map(
        noise(i * noiseScale, j * noiseScale),
        0, 
        1,
        0, 
        2 * PI
      );
    }
  }
}

void generateFlowfieldPattern() {
  for(int i = 0; i < rows; i++) {
    for(int j = 0; j < columns; j++) {
      float value = sin(i * 0.1) + cos(j * 0.2);
      flowfield[i][j] = map(value, -2, 2, 0, 2 * PI);
    }
  }
}

void mousePressed() {
  save("final_output6.png"); 
  print("Saved");
}
