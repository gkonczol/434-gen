class DNA
{
  String target = "song lyricss";
  char[] genes = new char[12];
  float fitness;
  
  DNA()
  {
    for(int i = 0; i < genes.length; i++)
    {
      genes[i] = (char) random(32, 128);
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
}
