snowball[] snowballs = new snowball[99];
button[] buttons = new button[3];
//which snowball is being acted on
int activesnowball = 0;
//is snowball in active mode
boolean active = false;
//drag speed
float dragspeed = 0;
//frame
int frame = 1;
//number of existing snowballs
int numsb;
//double click tester for creating snowballs
boolean createsnowball = false;
int createsnowballtimer = 0;
//smallest snowball
int smallestsb = 0;

void setup() {
  size(600,800);
  orientation(PORTRAIT);
  numsb = 0;
  //for (int i=0; i<snowballs.length; i++) snowballs[i] = new snowball(40, random(0, width), random(0, height));
  buttons[0] = new button(80, 40, 160, 80, 255, 255, 0, "roll");
  buttons[0].toggleon();
  buttons[1] = new button(width-80, 40, 160, 80, 255, 255, 0, "build");
  buttons[2] = new button(width/2, 40, 160, 80, 255, 255, 0, "destroy");
}

void draw() {
  background(255);
  for (int i=0; i<numsb; i++) {
    if (!snowballs[i].inbounds()) snowballs[i].silentdestroy(); 
    snowballs[i].draw();
  }
  buttons[0].draw();
  buttons[1].draw();
  buttons[2].draw();

  //timer for creating snowballs by double clicking
  if (millis() - createsnowballtimer >= 500) createsnowball = false;
}

void mousePressed() {
  //"roll" mode button clicked
  if (buttons[0].pressed()) {
    frame = 1;
    buttons[0].toggleon();
    buttons[1].toggleoff();
    buttons[2].toggleoff();
    if (smallestsb<numsb) snowballs[smallestsb].toggleelsaoff();
  }
  //"build" mode button clicked
  if (buttons[1].pressed()) {
    frame = 2;
    buttons[0].toggleoff();
    buttons[1].toggleon();
    buttons[2].toggleoff();
    //find the smallest snowball
    float tempd = 2147483647;
    for (int i=0; i<numsb; i++) {
      if (snowballs[i].diameter < tempd && snowballs[i].active) {
        tempd = snowballs[i].diameter;
        smallestsb = i;
      }
    }
  }
  //"destroy" mode button clicked
  if (buttons[2].pressed()) {
    frame = 3;
    buttons[0].toggleoff();
    buttons[1].toggleoff();
    buttons[2].toggleon();
  }
  for (int i=numsb-1; i>=0; i--) {
    if (snowballs[i].pressed()) {
      //snowball being pressed on (in priority of most recently created) becomes active
      active = true;
      activesnowball = i;
      break;
    } else active = false;
  }
  //create snowball by double clicking
  if (!active) {
    if (createsnowball) {
      snowballs[numsb] = new snowball(40, mouseX, mouseY);
      createsnowball = false;
      numsb++;
    } else {
      createsnowball = true;
      createsnowballtimer = millis();
    }
  }
  //"destroy" mode
  if (frame == 3 && active) snowballs[activesnowball].destroy();
}

void mouseReleased() {
  active = false;
}

void mouseDragged() {
  //"roll" mode
  if (frame == 1) {
    if (active) {
      //active turns off when mouse strays from snowball
      if (!snowballs[activesnowball].pressed()) {
        active = false;
      }
      dragspeed = dist(pmouseX, pmouseY, mouseX, mouseY);
      //snowball will roll relative to mouse speed when mouse speed reaches a certain threshold
      //active turned off to prevent more than one roll
      if (dragspeed >= 5) {
        snowballs[activesnowball].move((mouseX-pmouseX), (mouseY-pmouseY));
        active = false;
      }
    }
  }
  //"build" mode
  if (frame == 2) {
    if (active) {
      snowballs[activesnowball].translate(mouseX, mouseY);
      if (activesnowball == smallestsb) snowballs[smallestsb].toggleelsaon();
    }
  }
}

