class DNA
{
  PVector[] genes;
  float maxforce = 0.1;
  
  DNA()
  {
    genes = new PVector[LIFETIME];
    for(int i = 0; i < genes.length; i++)
    {
      genes[i] = PVector.random2D();
      genes[i].mult(random(0, maxforce));
    }
  }
  
  DNA crossover(DNA partner)
  {
    DNA child = new DNA();
    
    int coinValue = int(random(0, 1));
    
    for(int i = 0; i < genes.length; i++)
    {
      if(coinValue == 1)
      {
        child.genes[i] = genes[i];
      }
      else
      {
        child.genes[i] = partner.genes[i];
      }
      coinValue = int(random(0, 1));
    }
    
    return child;
  }
  
  void mutate(float mutationRate)
  {
    for(int i = 0; i < genes.length; i++)
    {
      if(random(1) < mutationRate)
      {
        genes[i] = PVector.random2D();
        genes[i].mult(random(0, maxforce));
      }
    }
  }
  
}
