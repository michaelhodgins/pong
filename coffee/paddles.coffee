###
Paddle is an Entity that can only move vertically. It must be extended to give it
specific capabilities.
###
class Paddle extends Entity
  ###
  Construct a Paddle
  ###
  constructor: ->
    super()
    @width = 20
    @height = 100
    @y = game.height / 2 - @height / 2
    @score = 0

    @speed = 14

  ###
  Update the Paddle's position.
  ###
  update: (steps) ->
    super steps
    @y = Math.min(Math.max(@y, 0), game.height - @height)


###
Player is a Paddle that is operated by the keyboard.
###
class Player extends Paddle
  constructor: ->
    super()
    @x = 20

  ###
  Update the player position passed on which keys are pressed, and it's current position.
  ###
  update: (steps) ->
    super steps
    #if both up and down are pressed, don't move the paddle
    if game.keyPressed.up and game.keyPressed.down
      @yVelocity = 0
    #move up
    else if game.keyPressed.up and @y > 0
      @yVelocity = -@speed
    #move down
    else if game.keyPressed.down and @y < game.height - @height
      @yVelocity = @speed
    #no key is pressed, so don't move
    else
      @yVelocity = 0


###
Bot is a Paddle that operated automatically
###
class Bot extends Paddle
  ###
  Construct a Bot
  ###
  constructor: ->
    super()
    @speed = 5
    @x = game.width - @width - 20

  ###
  Update the Bot's position based on the Ball's position.
  ###
  update: (steps) ->
    super steps
    #if the bot is above the ball, move down, but only if the paddle isn't already at the bottom
    if @y < game.ball.y and @y < (game.height - @height)
      @yVelocity = Math.min @speed, game.ball.y - @y
    # if the bot is below the ball move up, but only if the paddle isn't already at the top
    else if @y + @height > game.ball.y and @y > 0
      @yVelocity = Math.max -@speed, game.ball.y - @y
    else
      @yVelocity = 0
