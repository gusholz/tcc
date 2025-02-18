float scale = 10;
int rows, columns;
float[][] flowfield;

Particle[] swarm;
int swarmSize = 6200;

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
  
  background(#282828);
}

void draw() {
  // background(0);
  
  for(int i = 0; i< swarmSize; i++) {
    swarm[i].display();
    swarm[i].updatePosition();
  }
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

void mousePressed() {
  save("final_output6.png"); 
  print("Saved");
}
