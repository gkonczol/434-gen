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
  
  frameRate(2);
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
  }
  
  /* calculate average fitness of population */
  float avgFitness;
  float totalFitness = 0;
  for(int i = 0; i < population.length; i++)
  {
    totalFitness += population[i].fitness;
  }
  avgFitness = totalFitness / population.length;
  
  /* calculate best phrase of population */
  float bestPhraseValue = population[0].fitness;
  int bestPhraseIndex = 0;
  String bestPhrase;
  for(int i = 0; i < population.length; i++)
  {
    if(population[i].fitness > bestPhraseValue)
    {
      bestPhraseValue = population[i].fitness;
      bestPhraseIndex = i;
    }
  }
  bestPhrase = population[bestPhraseIndex].getPhrase();
  
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
  text("Total generations: " + generations, 10, 10);
  
  text("Phrases in generation " + generations + ":", 700, 10);
  int cgypos = 20;
  for(int i = 0; i < population.length; i++)
  {
    cgypos += 12;
    text(population[i].getPhrase(), 700, cgypos);
  }
  
  int nypos = 10;
  text("Population size: " + totalPopulation, 900, nypos);
  nypos += 12;
  
  text("Average fitness: " + avgFitness, 900, nypos);
  nypos += 12;
  
  text("Best phrase in generation:", 900, nypos);
  nypos += 12;
  text(bestPhrase, 900, nypos);
  nypos += 12;
  
  for(int i = 0; i < population.length; i++)
  {
    if(target.equals(population[i].getPhrase()))
    {
      textSize(18);
      text("Phrase found after " + generations + " generations", 200, 20);
      noLoop();
    }
  }
}
