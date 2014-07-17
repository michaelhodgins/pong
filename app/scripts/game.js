// Generated by CoffeeScript 1.7.1
var Game;

Game = (function() {
  Game.prototype.fps = 60;

  function Game(canvas, fps) {
    this.canvas = canvas;
    this.fps = fps != null ? fps : 60;
    this.context = this.canvas.getContext('2d');
    this.width = this.canvas.width;
    this.height = this.canvas.height;
    this.entities = [];
    this.desiredStep = 1000 / this.fps;
    window.requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame || window.webkitRequestAnimationFrame || window.msRequestAnimationFrame;
    this.keyPressed = {};
    $(this.canvas).on('keydown keyup', (function(_this) {
      return function(event) {
        var keyName;
        keyName = Game.keys[event.which];
        if (keyName) {
          _this.keyPressed[keyName] = event.type === 'keydown';
          return event.preventDefault();
        }
      };
    })(this));
  }

  Game.prototype.start = function() {
    this.recordUpdate();
    return this.frame((function(_this) {
      return function() {
        return _this.loop();
      };
    })(this));
  };

  Game.prototype.frame = function(callFrame) {
    var interval;
    if (window.requestAnimationFrame && false) {
      return window.requestAnimationFrame((function(_this) {
        return function() {
          callFrame();
          return _this.frame(callFrame);
        };
      })(this));
    } else {
      interval = 1000 / this.fps;
      return setInterval(function() {
        return callFrame();
      }, interval);
    }
  };

  Game.prototype.loop = function() {
    var startTime, steps, timePassed;
    startTime = new Date().getTime();
    timePassed = startTime - this.lastUpdate;
    steps = this.desiredStep / timePassed;
    this.update(steps);
    this.draw();
    return this.recordUpdate();
  };

  Game.prototype.update = function() {
    var entity, _i, _len, _ref, _results;
    _ref = this.entities;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      entity = _ref[_i];
      if (entity.update) {
        _results.push(entity.update());
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };

  Game.prototype.draw = function() {
    var entity, _i, _len, _ref, _results;
    _ref = this.entities;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      entity = _ref[_i];
      if (entity.draw) {
        _results.push(entity.draw(this.context));
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };

  Game.prototype.recordUpdate = function() {
    return this.lastUpdate = new Date().getTime();
  };

  Game.keys = {
    32: 'space',
    37: 'left',
    38: 'up',
    39: 'right',
    40: 'down'
  };

  return Game;

})();
