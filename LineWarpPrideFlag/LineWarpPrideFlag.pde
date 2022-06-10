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

color pride[] = { #750787, #004dff, #008026, #ffed00, #ff8c00, #e40303 };
int n = 1;
ArrayList<Stripe> stripes = new ArrayList<Stripe>();
ArrayList<Warper> warpers = new ArrayList<Warper>();

final int YN = 32, XN = 300;
float yinc, xinc;

void setup() {
  size(1200, 660, P3D);
  yinc = 1.0 * height / YN;
  xinc = 1.0 * width / XN;
  smooth(8);
  //Warpers
  for (int i = 0; i < n; i++) {
    warpers.add(new Warper());
  }
  //Stripes
  final int stripeHeight = height/pride.length;
  stripes.add(new Stripe(pride[0], 0, int(stripeHeight*4)));//first stripe is bigger
  for (int i = 1; i < pride.length; i++) {
    stripes.add(new Stripe(pride[i], i*stripeHeight+stripeHeight, int(stripeHeight*2)));
  }
}

int col=0;

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
  for (Stripe s : stripes) {
    s.reset();
    for (Warper w : warpers) {
      s.warp(w);
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
