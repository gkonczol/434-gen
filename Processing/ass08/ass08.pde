DNA[] population = new DNA[100];
float mutationRate;
String target;

void setup()
{
  size(600,600);
  
  mutationRate = 0.01;
  DNA targetGetter = new DNA();
  target = targetGetter.getTarget(); 
  
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
    //println(population[i].fitness);
    println(population[i].getPhrase());
  }
  
  ArrayList<DNA> matingPool = new ArrayList<DNA>();
  
  for(int i = 0; i < population.length; i++)
  {
    int n = int(population[i].fitness * 100);
    for(int j = 0; j < n; j++)
    {
      matingPool.add(population[i]);
    }
  }
  
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
    
    DNA parentA = matingPool.get(a);
    DNA parentB = matingPool.get(b);
    
    DNA child = parentA.crossover(parentB);
    child.mutate(mutationRate);
    
    population[i] = child;
  }
  
  for(int i = 0; i < population.length; i++)
  {
    if(target.equals(population[i].getPhrase()))
    {
      exit();
    }
  }
}
