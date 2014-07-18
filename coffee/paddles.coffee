class Paddle extends Entity
  constructor: ->
    super()
    @width = 20
    @height = 100
    @y = game.height / 2 - @height / 2
    @score = 0

    @speed = 14

  update: (steps) ->
    super steps
    @y = Math.min(Math.max(@y, 0), game.height - @height)



class Player extends Paddle
  constructor: ->
    super()
    @x = 20

  update: (steps) ->
    super steps
    if game.keyPressed.up and game.keyPressed.down
      @yVelocity = 0
    else if game.keyPressed.up and @y > 0
      @yVelocity = -@speed
    else if game.keyPressed.down and @y < game.height - @height
      @yVelocity = @speed
    else
      @yVelocity = 0



class Bot extends Paddle
  constructor: ->
    super()
    @speed = 5
    @x = game.width - @width - 20

  update: (steps) ->
    super steps
    #if the bot is above the ball, move down, but only if the paddle isn't already at the bottom
    if @y + (@height / 2) < game.ball.y and @y < (game.height - @height)
      @yVelocity = Math.min @speed, game.ball.y - @y
    # if the bot is below the ball move up, but only if the paddle isn't already at the top
    else if @y + (@height / 2) > game.ball.y and @y > 0
      @yVelocity = Math.max -@speed, game.ball.y - @y
    else
      @yVelocity = 0