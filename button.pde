class button {

  int xcor;
  int ycor;
  int wid;
  int hei;
  int colr;
  int colg;
  int colb;
  String label;
  boolean active;

  button(int x, int y, int w, int h, int r, int g, int b, String l) {
    xcor = x;
    ycor = y;
    wid = w;
    hei = h;
    colr = r;
    colg = g;
    colb = b;
    label = l;
    active = false;
  }

  void draw() {
    if (active) fill(colr-50, colg-50, colb-50);
    else fill(colr, colg, colb);
    rectMode(CENTER);
    rect(xcor, ycor, wid, hei, 10);

    textAlign(CENTER);
    textSize(20);
    fill(255, 0, 0);
    text(label, xcor, ycor+10);
  }

  boolean pressed() {
    if (abs(mouseX-xcor) < wid/2 && abs(mouseY-ycor) < hei/2) return true;
    else return false;
  }

  void toggleon() {
    active = true;
  }

  void toggleoff() {
    active = false;
  }
}

