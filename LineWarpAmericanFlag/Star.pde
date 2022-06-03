class Star {
  PVector pos, orig;
  float angle;

  Star(int x, int y) {
    orig = new PVector(x, y);
    angle=0;
    reset();
  }

  void reset() {
    pos = orig.copy();
  }

  void update(PVector o, float radius) {
    float fdist = pow(1 - min(1.0, pos.copy().sub(o).mag() / radius), 5.0);
    if (fdist > 0.0) {
      pos.sub(o);
      angle=fdist * PI/2;
      pos.rotate(fdist * PI/2);
      pos.add(o);
    }
  }

  void draw() {
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle);
    beginShape();
    vertex(+00/2.5, -44/2.5);
    vertex(+10/2.5, -13/2.5);
    vertex(+43/2.5, -13/2.5);
    vertex(+16/2.5, +07/2.5);
    vertex(+27/2.5, +38/2.5);
    vertex(+00/2.5, +20/2.5);
    vertex(-27/2.5, +38/2.5);
    vertex(-18/2.5, +07/2.5);
    vertex(-44/2.5, -13/2.5);
    vertex(-10/2.5, -13/2.5);  
    endShape(CLOSE);
    popMatrix();
  }
}
