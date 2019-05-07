final int LIFETIME = 500;

int lifeCounter;

Population population;

void setup()
{
  size(1200,600);
  lifeCounter = 0;
  float mutationRate = 0.01;
  population = new Population(mutationRate, 50);
}

void draw()
{
  background(255);
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
}
