import java.util.Random;

int wordsGenerated = 0;

void setup()
{
  size(600,600);
  background(0);
}

void draw()
{
  StringBuilder sb = new StringBuilder(3);
  for(int j = 0; j < 3; j++)
  {
    Random randomGenerator = new Random();
    int numForChar = randomGenerator.nextInt(26) + 97;
    char c = (char)numForChar;
    sb.append(c);
  }
  
  textSize(100);
  fill(random(0, 255));
  text(sb.toString(), random(0,width), random(0,height));
  
  wordsGenerated++;
  if("cat".equals(sb.toString()))
  {
    println("Cat found");
    println(wordsGenerated + " words generated");
    exit();
  }
}
