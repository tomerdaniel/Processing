class Stripe {
  color c;
  int y, h;
  ArrayList<PVector> ps;

  Stripe(color c, int y, int h) {
    this.c=c;
    this.y=y;
    this.h=h;
    this.ps = new ArrayList<PVector>();
  }

  void reset() {//reset stripe to be a straight line
    this.ps = new ArrayList<PVector>();
    for (int xi = -65; xi < XN; xi++) {
      float x = xi * xinc + xinc / 2;
      ps.add(new PVector(x, y));
    }
  }

  void warp(Warper w) {//apply warper on this stripe
    for (PVector p : ps) {
      w.warp(p);
    }
  }

  void draw() {//draw this stripe
    stroke(c);
    strokeWeight(h);
    noFill();
    beginShape(POINTS);
    for (PVector p : ps) {
      vertex(p.x, p.y);
    }
    endShape();
  }
}
