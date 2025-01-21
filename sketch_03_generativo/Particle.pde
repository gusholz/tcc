class Particle {
  PVector position;
  PVector velocity;
  float rectWidth;
  float rectHeight;
  boolean isVisible;
  float lifeSpan = 100;
  
  Particle() {
    position = new PVector(random(width), random(height));
    velocity = new PVector(0,0);
    rectWidth =  1;// random(1,3);
    rectHeight = 2;// random(1,4);
  }
  
  void updatePosition() {
    PVector acceleration = new PVector(0,0);
    float force = 1;
    
    acceleration.x = force * cos(flowfield[int(position.y/scale)][int(position.x/scale)]);
    acceleration.y = force * sin(flowfield[int(position.y/scale)][int(position.x/scale)]);
    velocity.add(acceleration);
    position.add(velocity);
    
    if (position.x > width && position.x < 0) {
      lifeSpan = 0;
    }
    
    if (position.y > height && position.x < 0) {
      lifeSpan = 0;
    }
    
    position.x = (position.x + width) % width;
    position.y = (position.y + height) % height;
    
    velocity.mult(0.6);
    lifeSpan -= .1;
  }
  
  boolean isAlive() {
    if (lifeSpan <= 0) {
      return false;
    } else {
      return true;
    }
  }
  
  void display() {
    rectMode(CENTER);
    fill(240 + lifeSpan, 100, 100, lifeSpan);
    noStroke();
    ellipse(position.x, position.y, rectWidth, rectHeight);
  }
}
