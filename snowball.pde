class snowball {

  float diameter;
  float area;
  float xcor;
  float ycor;
  float xspeed;
  float yspeed;
  PImage icon;
  PImage elsa;
  PImage explosion;
  boolean elsaon = false;
  boolean active = true;
  int explosiontimer = 0;
  float oldx;
  float oldy;

  snowball(float d, float x, float y) {
    diameter = d;
    area = pow(d/2, 2) * 3.1415;
    xcor = x;
    ycor = y;
    xspeed = 0;
    yspeed = 0;
    icon = loadImage("snowball.png");
    icon.loadPixels();
    elsa = loadImage("elsa.png");
    elsa.loadPixels();
    explosion = loadImage("explosion.png");
    explosion.loadPixels();
  }

  void draw() {
    //update coordinates and speed
    xcor += xspeed;
    ycor += yspeed;
    area += (pow(xspeed/2.0, 2) * pow(yspeed/2.0, 2));
    diameter = sqrt(area/3.1415) * 2;
    xspeed *= 0.95;
    yspeed *= 0.95;
    //circle outline
    stroke(200);
    noFill();
    ellipseMode(CENTER);
    ellipse(xcor, ycor, diameter, diameter);

    //snowball image
    icon.resize((int)diameter, (int)diameter);
    imageMode(CENTER);
    image(icon, xcor, ycor);
    icon.updatePixels();
    //ELSA
    if (elsaon) {
      elsa.resize((int)diameter, (int)diameter);
      imageMode(CENTER);
      image(elsa, xcor, ycor);
      elsa.updatePixels();
    }
    if (millis()-explosiontimer < 500) {
      image(explosion, oldx, oldy);
      explosion.updatePixels();
    }
  } 

  void increasesize(int i) {
    diameter += i;
  }

  boolean pressed() {
    if (dist(mouseX, mouseY, xcor, ycor) < diameter/2) return true;
    else return false;
  }

  //directly move the snowball
  void translate(float x, float y) {
    xspeed = 0;
    yspeed = 0;
    xcor = x;
    ycor = y;
  }

  //called when rolled, updates speed and direction relative to mouse movement and constrains them
  void move(float xs, float ys) {
    xspeed = xs;
    xspeed = constrain(xspeed, -10.0, 10.0);
    yspeed = ys;
    yspeed = constrain(yspeed, -10.0, 10.0);
  }

  void toggleelsaon() {
    elsaon = true;
    elsa = loadImage("elsa.png");
    elsa.loadPixels();
  }

  void toggleelsaoff() {
    elsaon = false;
  }
  
  void destroy() {
    explosion.resize((int)diameter, (int)diameter);
    imageMode(CENTER);
    explosiontimer = millis();
    oldx = xcor;
    oldy = ycor;
    xcor = width+diameter;
    ycor = height+diameter;
    active = false;
  }
  
  void silentdestroy() {
    xcor = width+diameter;
    ycor = height+diameter;
    active = false;
  } 
  
  boolean inbounds() {
    if (xcor-(diameter/2) >= width || xcor+(diameter/2) <= 0 || ycor-(diameter/2) >= height || ycor+(diameter/2) <= 0) {
      return false;
    }
    else return true;
  }
}

