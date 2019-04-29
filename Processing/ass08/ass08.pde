DNA[] population = new DNA[100];

void setup()
{
  size(600,600);
  for (int i = 0; i < population.length; i++)
  {
    population[i] = new DNA();
  }
  for(DNA d : population)
  {
    for(char c : d.genes)
    {
      print(c);
    }
    println("");
  }
}

void draw()
{
  background(255);
  //if((frameCount % 0) == 0)
  //{
  //}
  for(int i = 0; i < population.length; i++)
  {
    population[i].fitness();
    println(population[i].fitness);
  }
}
