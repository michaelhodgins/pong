// Generated by CoffeeScript 1.7.1
var Ball,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Ball = (function(_super) {
  __extends(Ball, _super);

  function Ball() {
    Ball.__super__.constructor.call(this);
    this.width = 20;
    this.height = 20;
    this.velocityShare = 4;
    this.velocityBounce = 0.2;
    this.velocity = 0;
    this.vector = 0;
    this.reset();
  }

  Ball.prototype.update = function(steps) {
    var hitter, spin;
    Ball.__super__.update.call(this, steps);
    if (this.y >= game.height - this.height) {
      this.y = game.height - this.height;
      this.bounce(270);
    } else if (this.y < 0) {
      this.y = 0;
      this.bounce(90);
    }
    if (this.x > game.width) {
      game.player.score++;
      this.reset();
    }
    if (this.x < 0) {
      game.bot.score++;
      this.reset();
    }
    if (this.intersect(game.bot)) {
      hitter = game.bot;
      this.x = game.bot.x - this.width;
      this.bounce(180);
    } else if (this.intersect(game.player)) {
      this.x = game.player.x + game.player.width;
      hitter = game.player;
      this.bounce(360);
    }
    if (hitter) {
      spin = hitter.yVelocity * 1.5;
      this.velocity += 0.2;
      if (hitter.yVelocity > 0) {
        this.vector -= spin;
      } else if (hitter.yVelocity < 0) {
        this.vector += spin;
      }
    }
    this.yVelocity = this.calcYVelocity();
    return this.xVelocity = this.calcXVelocity();
  };

  Ball.prototype.bounce = function(normal) {
    var m, o;
    console.log("bounce");
    o = this.vector - 180 - normal;
    m = normal - o;
    if (m < 0) {
      m += 360;
    } else if (m > 360) {
      m -= 360;
    }
    return this.vector = m;
  };

  Ball.prototype.calcYVelocity = function() {
    return this.velocity * Math.sin(this.degreesToRadians(this.vector));
  };

  Ball.prototype.calcXVelocity = function() {
    return this.velocity * Math.cos(this.degreesToRadians(this.vector));
  };

  Ball.prototype.reset = function() {
    var maxVector, maxVelocity, minVector, minVelocity, randVector, randVelocity;
    this.x = game.width / 2 - this.width;
    this.y = game.height / 2 - this.height;
    minVelocity = -6;
    maxVelocity = 6;
    randVelocity = Math.random() > 0.5 ? maxVelocity : minVelocity;
    minVector = -25;
    maxVector = 25;
    randVector = Math.floor(Math.random() * (maxVector - minVector + 1) + minVector);
    this.velocity = randVelocity;
    this.vector = 0 + randVector;
    if (this.velocity < 0) {
      this.velocity = -this.velocity;
      this.vector += 180;
    }
    this.yVelocity = this.calcYVelocity();
    return this.xVelocity = this.calcXVelocity();
  };

  return Ball;

})(Entity);
