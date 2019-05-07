class Population
{
  float mutationRate;
  Rocket[] population;
  ArrayList<Rocket> matingPool;
  int generations;
  
  Population(float mutationRate, int popSize)
  {
    this.mutationRate = mutationRate;
    population = new Rocket[popSize];
    matingPool = new ArrayList<Rocket>();
    generations = 0;
    for(int i = 0; i < population.length; i++)
    {
      PVector position = new PVector(width/2, height+20);
      population[i] = new Rocket(position, new DNA());
    }
  }
  
  void fitness()
  {
    for(int i = 0; i < population.length; i++)
    {
      population[i].fitness();
    }
  }
  
  void selection()
  {
    matingPool.clear();
    for(int i = 0; i < population.length; i++)
    {
      int n = int(population[i].fitness * 100);
      for(int j = 0; j < n; j++)
      {
        matingPool.add(population[i]);
      }
    }
  }
  
  void reproduction()
  {
    for(int i = 0; i < population.length; i++)
    {
      int a = int(random(matingPool.size()));
      int b = int(random(matingPool.size()));
      
      /* make sure parents are unique */
      if(a == b)
      {
        while(a == b)
        {
          b = int(random(matingPool.size()));
        }
      }
      
      Rocket parentA = matingPool.get(a);
      Rocket parentB = matingPool.get(b);
      
      DNA child = parentA.getDNA().crossover(parentB.getDNA());
      child.mutate(mutationRate);
      
      PVector position = new PVector(width/2, height+20);
      
      population[i] = new Rocket(position, child);
    }
    generations++;
  }
  
  void live()
  {
    for(int i = 0; i < population.length; i++)
    {
      population[i].run();
    }
  }
  
  int getGenerations()
  {
    return generations;
  }
  
}
