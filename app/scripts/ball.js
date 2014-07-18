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
    this.velocityBounce = 1.05;
    this.velocity = 0;
    this.vector = 0;
    this.reset();
  }

  Ball.prototype.update = function(steps) {
    var hitter;
    Ball.__super__.update.call(this, steps);
    if (this.y > game.height - this.height || this.y < 0) {
      this.yVelocity *= -1;
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
    } else if (this.intersect(game.player)) {
      hitter = game.player;
    }
    if (hitter) {
      this.xVelocity *= -this.velocityBounce;
      if (hitter.yVelocity) {
        this.yVelocity *= -this.velocityBounce;
        return this.yVelocity += hitter.yVelocity / this.velocityShare;
      }
    }
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
    minVelocity = -5;
    maxVelocity = 5;
    randVelocity = Math.random() > 0.5 ? maxVelocity : minVelocity;
    minVector = -25;
    maxVector = 25;
    randVector = Math.floor(Math.random() * (maxVector - minVector + 1) + minVector);
    this.velocity = randVelocity;
    this.vector = randVector;
    this.yVelocity = this.calcYVelocity();
    return this.xVelocity = this.calcXVelocity();
  };

  return Ball;

})(Entity);
