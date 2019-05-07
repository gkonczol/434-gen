class Obstacle
{
  PVector location;
  float w,h;
  
  Obstacle(float x, float y, float w, float h)
  {
    location = new PVector(x,y);
    this.w = w;
    this.h = h;
  }
  
  boolean contains(PVector vector)
  {
    if(vector.x > location.x && vector.x < (location.x + w) && vector.y > location.y && vector.y < (location.y + h))
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  
  void display()
  {
    stroke(0);
    fill(175);
    strokeWeight(2);
    rectMode(CORNER);
    rect(location.x, location.y, w, h);
  }
}
