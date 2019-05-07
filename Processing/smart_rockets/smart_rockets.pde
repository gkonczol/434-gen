final int LIFETIME = 500;

int lifeCounter;

Population population;

PVector target;

void setup()
{
  size(1200,600);
  
  lifeCounter = 0;
  
  float mutationRate = 0.01;
  population = new Population(mutationRate, 50);
  target = new PVector(width/2, 10);
}

void draw()
{
  background(255);
  
  fill(0);
  ellipse(target.x, target.y, 10, 10);
  
  if(lifeCounter < LIFETIME)
  {
    population.live();
    lifeCounter++;
  }
  else
  {
    lifeCounter = 0;
    population.fitness();
    population.selection();
    population.reproduction();
  }
  
  fill(0);
  text("Generation: " + population.getGenerations(), 10, 12);
  text("Cycles left: " + (LIFETIME - lifeCounter), 10, 24);
}
