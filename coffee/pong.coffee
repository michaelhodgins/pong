canvas = $('#pong')[0]
game = new Game canvas
game.entities = [
  game.background = new Background()
  game.ball = new Ball()
  game.player = new Player()
  game.bot = new Bot()
]
game.start()

canvas.focus()
