DNA[] population;
int totalPopulation;
float mutationRate;
String target;
int generations;

void setup()
{
  size(1200,600);
  
  mutationRate = 0.01;
  totalPopulation = 1000;
  
  DNA targetGetter = new DNA();
  target = targetGetter.getTarget(); 
  
  population = new DNA[totalPopulation];
  
  for (int i = 0; i < population.length; i++)
  {
    population[i] = new DNA();
  }
  
  generations = 1;
}

void draw()
{
  background(255);
  textSize(12);
  fill(20);
  
  /* calculate fitness */
  for(int i = 0; i < population.length; i++)
  {
    population[i].fitness();
    //println(population[i].getPhrase());
  }
  
  ArrayList<DNA> matingPool = new ArrayList<DNA>();
  
  /* add to mating pool */
  for(int i = 0; i < population.length; i++)
  {
    int n = int(population[i].fitness * 100);
    for(int j = 0; j < n; j++)
    {
      matingPool.add(population[i]);
    }
  }
  
  /* reproduce */
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
  generations++;
  String strTG = "Total generations: " + generations;
  text(strTG, 10, 10);
  
  text("Phrases in current generation:", 700, 10);
  int cgypos = 20;
  for(int i = 0; i < population.length; i++)
  {
    cgypos += 12;
    text(population[i].getPhrase(), 700, cgypos);
  }
  
  text("Phrases in current generation:", 900, 10);
  
  noLoop();
  for(int i = 0; i < population.length; i++)
  {
    if(target.equals(population[i].getPhrase()))
    {
      String strPF = "Phrase found after " + generations + " generations";
      textSize(18);
      text(strPF, 200, 20);
      noLoop();
    }
  }
}
