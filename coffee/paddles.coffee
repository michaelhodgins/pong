class Paddle extends Entity
  constructor: ->
    super()
    @width = 20
    @height = 100
    @y = game.height / 2 - @height / 2
    @score = 0

    @speed = 15

  update: ->
    super()
    @y = Math.min(Math.max(@y, 0), game.height - @height)



class Player extends Paddle
  constructor: ->
    super()
    @x = 20

  update: ->
    super()
    if game.keyPressed.up
      @yVelocity = -@speed
    else if game.keyPressed.down
      @yVelocity = @speed
    else
      @yVelocity = 0



class Bot extends Paddle
  constructor: ->
    super()
    @speed = 5
    @x = game.width - @width - 20

  update: ->
    super()
    if @y < game.ball.y
      @yVelocity = @speed
    else if @y > game.ball.y
      @yVelocity = -@speed
