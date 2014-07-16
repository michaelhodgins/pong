// Generated by CoffeeScript 1.7.1
var Background;

Background = (function() {
  function Background() {}

  Background.prototype.draw = function(context) {
    context.fillStyle = '#000';
    context.fillRect(0, 0, game.width, game.height);
    context.fillStyle = '#fff';
    context.font = '40px monospace';
    context.fillText(game.player.score, game.width * 3 / 8, 50);
    return context.fillText(game.bot.score, game.width * 5 / 8, 50);
  };

  return Background;

})();