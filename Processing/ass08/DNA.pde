class DNA
{
  String target = "turn down for what";
  char[] genes = new char[18];
  float fitness;
  
  DNA()
  {
    for(int i = 0; i < genes.length; i++)
    {
      genes[i] = (char) random(32, 126);
    }
  }
  
  public void fitness()
  {
    int score = 0;
    for(int i = 0; i < genes.length; i++)
    {
      if(genes[i] == target.charAt(i))
      {
        score++;
      }
    }
    fitness = float(score)/target.length();
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
    }
    
    return child;
  }
  
  void mutate(float mutationRate)
  {
    for(int i = 0; i < genes.length; i++)
    {
      if(random(1) < mutationRate)
      {
        genes[i] = (char) random(32, 126);
      }
    }
  }
  
  String getPhrase()
  {
    return new String(genes);
  }
  
  String getTarget()
  {
    return target;
  }
}
