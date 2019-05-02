Rocket rocket;

final int LIFETIME = 100;


void setup()
{
  size(1200,600);
  rocket = new Rocket(new PVector(100,200));
}

void draw()
{
  background(255);
  rocket.update();
  rocket.display();
}

/*
void keyPressed()
{
  if(keyCode == RIGHT){
    rocket.applyForce(new PVector(1,0));
  }
  if(keyCode == LEFT){
    rocket.applyForce(new PVector(-1,0));
  }
  if(keyCode == UP){
    rocket.applyForce(new PVector(0,-1));
  }
  if(keyCode == DOWN){
    rocket.applyForce(new PVector(0,1));
  }
}
*/
