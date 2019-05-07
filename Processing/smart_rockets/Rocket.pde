class Rocket {
  
  DNA dna;
  
  PVector position;
  PVector velocity;
  PVector acceleration;

  float size;
  float fitness;
  int geneCounter = 0;
  
  float recordDistance;
  int finishTime;
  
  boolean stopped = false;

  Rocket(PVector location, DNA dna) {
    acceleration = new PVector();
    velocity = new PVector();
    position = location.get();
    size = 4;
    this.dna = dna;
    finishTime = 0;
    recordDistance = 20000000;
  }
  
  void run(ArrayList<Obstacle> obstacles)
  {
    if(!targetHit() && !stopped)
    {
      applyForce(dna.genes[geneCounter]);
      geneCounter++;
      update();
      obstacles(obstacles);
    }
    display();
  }
  
  boolean targetHit()
  {
    float distance = PVector.dist(position, target);
    if(distance < recordDistance)
    {
      recordDistance = distance;
    }
    if(distance < 5)
    {
      stopped = true;
      return true;
    }
    else
    {
      finishTime++;
      return false;
    }
  }
  
  void fitness()
  {
    if(recordDistance < 1) recordDistance = 1;
    fitness = pow(1.0/(finishTime*recordDistance),2);
    if(stopped)
    {
      fitness *= 0.01;
    }
    if(targetHit())
    {
      fitness *= 2;
    }
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
  
  float getFitness()
  {
    return fitness;
  }
  
  void obstacles(ArrayList<Obstacle> obstacles)
  {
    for(Obstacle obstacle : obstacles)
    {
      if(obstacle.contains(position))
      {
        stopped = true;
      }
    }
  }

}
