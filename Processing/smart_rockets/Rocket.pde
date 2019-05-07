class Rocket {
  
  DNA dna;
  
  PVector position;
  PVector velocity;
  PVector acceleration;

  float size;
  float fitness;
  int geneCounter = 0;

  Rocket(PVector location, DNA dna) {
    acceleration = new PVector();
    velocity = new PVector();
    position = location.get();
    size = 4;
    this.dna = dna;
  }
  
  void run()
  {
    if(!targetHit())
    {
      applyForce(dna.genes[geneCounter]);
      geneCounter++;
      update();
    }
    display();
  }
  
  boolean targetHit()
  {
    float distance = PVector.dist(position, target);
    if(distance < 5)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  
  void fitness()
  {
    float distance = PVector.dist(position, target);
    fitness = pow(1.0/distance,2);
  }

  void applyForce(PVector f) {
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    float theta = velocity.heading2D() + PI/2;
    fill(200, 100);
    stroke(0);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);

    // Thrusters
    rectMode(CENTER);
    fill(0);
    rect(-size/2, size*2, size/2, size);
    rect(size/2, size*2, size/2, size);

    // Fuselage
    fill(175);
    beginShape(TRIANGLES);
    vertex(0, -size*2);
    vertex(-size, size*2);
    vertex(size, size*2);
    endShape();

    popMatrix();
  }
  
  DNA getDNA()
  {
    return dna;
  }

}
