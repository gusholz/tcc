import processing.sound.*;

int xCoordinate;
int yCoordinate;
int radius = 300;
int steps = 1000;
int counter = 0;
int iterationCount = 1;

AudioIn input;
Amplitude loudness;

void setup() {
  fullScreen();
  background(000000);
  // frameRate(16);
  
  input = new AudioIn(this, 0);

  input.start();
  input.play();

  loudness = new Amplitude(this);
  loudness.input(input);


  xCoordinate = width / 2;
  yCoordinate = height /2;
}

void draw() {                         
  float volume = loudness.analyze();
  int size = int(map(volume, 0, 0.5, 1, 300 / iterationCount));
  print("Volume:");
  print(volume);
  print("\n");
  
  
  color fillColor = determineColor(volume);
  
  fill(fillColor, 150);
  
  
  noStroke();  
  if(counter <= steps) {
    float theta = TWO_PI / steps * counter;
    float x = xCoordinate + radius * cos(theta)/ iterationCount;
    float y = yCoordinate + radius * sin(theta)/ iterationCount;
    circle(x,y,size);
    counter += 1;
  } else {
    iterationCount +=1;
    counter = 0;
  }
  
}

void mousePressed() {
  save("output.png"); 
  print("Saved");
  counter = 0;
  iterationCount = 1;
  background(000000);
}

color determineColor(float value) {
  float updatedValue = value * 10000;

  if (updatedValue >= 0 && updatedValue <= 100) {
    return color(255, 0, 0); // Vermelho puro
  } else if (updatedValue >= 101 && updatedValue <= 200) {
    return color(255, 165, 0); // Laranja
  } else if (updatedValue > 200 && updatedValue <= 300) {
    return color(255, 105, 180); // Rosa
  } else if (updatedValue > 300) {
    return color(128, 0, 0); // Bordô
  } else {
    return color(50, 50, 50); // Cinza escuro para valores negativos
  }
}
