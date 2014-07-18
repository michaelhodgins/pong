// Generated by CoffeeScript 1.7.1
var canvas, game;

window.requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame || window.webkitRequestAnimationFrame || window.msRequestAnimationFrame;

canvas = $('#pong')[0];

game = new Game(canvas);

game.entities = [game.background = new Background(), game.ball = new Ball(), game.player = new Player(), game.bot = new Bot()];

game.start();

canvas.focus();
