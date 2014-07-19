#Some browsers have the requestAnimationFrame function, but give it an experiment prefix.
window.requestAnimationFrame = window.requestAnimationFrame or window.mozRequestAnimationFrame or window.webkitRequestAnimationFrame or window.msRequestAnimationFrame

#get the game canvas
canvas = $('#pong')[0]

#make the game
game = new Game canvas

#add the game entities.
game.entities = [
  game.background = new Background()
  game.ball = new Ball()
  game.player = new Player()
  game.bot = new Bot()
]

#start the game
game.start()

#make sure that the game has focus so that the player doesn't have to click on it.
canvas.focus()
