class Warper {

  PVector pos, vel;
  float warpAngle, warpRadius;
  boolean dying;

  Warper() {
    this.pos = new PVector(width+200+random(100), height/2+random(20));
    this.vel = new PVector(random(2, 6) * (random(2) < 1 ? -1 : 1), random(2, 6) * (random(2) < 1 ? -1 : 1));
    this.warpAngle = (random(2) < 1 ? -1 : 1) * random(PI, 2 * PI);
    this.warpRadius = 320;//random(300, 500);
    this.dying = false;
  }

  void update() {
    if (pos.x < warpRadius/8 || pos.x > width+warpRadius) {
      vel.x *= -1;
    }
    if (pos.y < warpRadius/8 || pos.y > height-warpRadius/8) {
      vel.y *= -1;
    }
    this.pos.add(vel);
    if (dying) {
      warpRadius = warpRadius/1.05;
      println(warpRadius);
    }
  }

  void die() {
    dying = true;
  }

  boolean isDead() {
    return (dying && warpRadius<10);
  }

  void warp(PVector p) {
    float fdist = pow(1 - min(1.0, p.copy().sub(pos).mag() / warpRadius), 5.0);
    if (fdist > 0.0) {
      p.sub(pos);
      p.rotate(fdist * warpAngle);
      p.add(pos);
    }
  }
}
