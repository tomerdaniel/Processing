//MIT License

//Copyright (c) 2022 Brian Fearn
//Modified by Tomer Daniel, based on https://github.com/Brian-Fearn/Processing/blob/main/LineWarp/LineWarp.pde

//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:

//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.

//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.


int n = 1;
ArrayList<Star> stars = new ArrayList<Star>();
ArrayList<Warper> warpers = new ArrayList<Warper>();

final int STARS_WIDTH = 480, STARS_HEIGHT = 348;
final int YN = 32, XN = 300;
float yinc, xinc;

void setup() {
  size(1200, 640, P3D);
  yinc = 1.0 * height / YN;
  xinc = 1.0 * width / XN;
  smooth(8);
  //Warpers
  for (int i = 0; i < n; i++) {
    warpers.add(new Warper());
  }
  //Stars
  for (int i=0; i<6; i++) {
    for (int j=0; j<5; j++) {
      stars.add(new Star(45+i*STARS_WIDTH/6, 35+j*STARS_HEIGHT/5));
    }
  }
  for (int i=0; i<5; i++) {
    for (int j=0; j<4; j++) {
      stars.add(new Star(40+45+i*STARS_WIDTH/6, 32+35+j*STARS_HEIGHT/5));
    }
  }
}

void draw() {
  background(#F2F2F2);
  for (int i=0; i<warpers.size(); i++) {
    Warper w = warpers.get(i);
    w.update();
    if (w.isDead()) {
      warpers.remove(i);
      i--;
    }
  }

  if (mousePressed && warpers.size()>0) {//force one warper to mouse, when mouse is down
    warpers.get(0).pos = new PVector(mouseX, mouseY);
  }
  //Stripes
  stroke(#A61C35);
  strokeWeight(48);
  noFill();
  for (int yi = 0; yi < YN + 20; yi+=5) {
    float y = 14+yi * yinc + yinc / 2;
    beginShape(POINTS);
    for (int xi = -65; xi < XN + 65; xi++) {
      float x = xi * xinc + xinc / 2;
      PVector p = new PVector(x, y);
      for (Warper w : warpers) {
        w.warp(p);
      }
      vertex(p.x, p.y);
    }
    endShape();
  }
  //Stars
  noStroke();
  fill(#3C3E73);
  rect(0, 0, STARS_WIDTH, STARS_HEIGHT);
  fill(#F2F2F2);
  for (Star s : stars) {
    s.reset();
    for (Warper w : warpers) {
      s.update(w.pos, w.warpRadius);
    }
    s.draw();
  }
  //  println(frameRate);
}

void keyPressed() {
  switch (key) {
  case '-': //send kill signal to one warper (the first)
    if (warpers.size()>0) 
      warpers.get(0).die();
    break;
  case '+': //spawn a new warper
    warpers.add(new Warper());
    break;
  }
}
