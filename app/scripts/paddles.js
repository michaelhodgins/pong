// Generated by CoffeeScript 1.7.1

/*
Paddle is an Entity that can only move vertically. It must be extended to give it
specific capabilities.
 */
var Bot, Paddle, Player,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Paddle = (function(_super) {
  __extends(Paddle, _super);


  /*
  Construct a Paddle
   */

  function Paddle() {
    Paddle.__super__.constructor.call(this);
    this.width = 20;
    this.height = 100;
    this.y = game.height / 2 - this.height / 2;
    this.score = 0;
    this.speed = 14;
  }


  /*
  Update the Paddle's position.
   */

  Paddle.prototype.update = function(steps) {
    Paddle.__super__.update.call(this, steps);
    return this.y = Math.min(Math.max(this.y, 0), game.height - this.height);
  };

  return Paddle;

})(Entity);


/*
Player is a Paddle that is operated by the keyboard.
 */

Player = (function(_super) {
  __extends(Player, _super);

  function Player() {
    Player.__super__.constructor.call(this);
    this.x = 20;
  }


  /*
  Update the player position passed on which keys are pressed, and it's current position.
   */

  Player.prototype.update = function(steps) {
    Player.__super__.update.call(this, steps);
    if (game.keyPressed.up && game.keyPressed.down) {
      return this.yVelocity = 0;
    } else if (game.keyPressed.up && this.y > 0) {
      return this.yVelocity = -this.speed;
    } else if (game.keyPressed.down && this.y < game.height - this.height) {
      return this.yVelocity = this.speed;
    } else {
      return this.yVelocity = 0;
    }
  };

  return Player;

})(Paddle);


/*
Bot is a Paddle that operated automatically
 */

Bot = (function(_super) {
  __extends(Bot, _super);


  /*
  Construct a Bot
   */

  function Bot() {
    Bot.__super__.constructor.call(this);
    this.speed = 5;
    this.x = game.width - this.width - 20;
  }


  /*
  Update the Bot's position based on the Ball's position.
   */

  Bot.prototype.update = function(steps) {
    Bot.__super__.update.call(this, steps);
    if (this.y < game.ball.y && this.y < (game.height - this.height)) {
      return this.yVelocity = Math.min(this.speed, game.ball.y - this.y);
    } else if (this.y + this.height > game.ball.y && this.y > 0) {
      return this.yVelocity = Math.max(-this.speed, game.ball.y - this.y);
    } else {
      return this.yVelocity = 0;
    }
  };

  return Bot;

})(Paddle);
