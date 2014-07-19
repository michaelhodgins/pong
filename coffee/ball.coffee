###
The Ball class is an Entity.
###
class Ball extends Entity

  ###
  Construct a ball
  ###
  constructor: ->
    super()
    @width = 20
    @height = 20
    @velocityShare = 1.3
    @velocityBounce = 0.2
    @velocity = 0
    @vector = 0
    @reset()

  ###
  Update the ball by the given number of steps.
  ###
  update: (steps) ->
    super steps

    #if the ball has reached the top or bottom on the game area, bounce it
    if @y >= game.height - @height
      @y = game.height - @height
      @bounce 270 #270 is the perpendicular angle to the bottom of the game area
    else if @y < 0
      @y = 0
      @bounce 90 #90 is perpendicular to the top

    #has someone scored?
    if @x > game.width
      game.player.score++
      @reset()
    if @x < 0
      game.bot.score++
      @reset()

    #has the bot hit the ball?
    if @intersect game.bot
      hitter = game.bot
      @x = game.bot.x - @width
      @bounce 180 #180 is perpendicular to the bot paddle.
    #has the player hit the ball?
    else if @intersect game.player
      @x = game.player.x + game.player.width
      hitter = game.player
      @bounce 360 #360 is perpendicular to the player paddle.

    if hitter
      #speed up the ball each time it is hit
      @velocity += @velocityBounce

      #if the hitter is moving, give the ball a little spin
      spin = hitter.yVelocity * @velocityShare
      if hitter.yVelocity > 1
        @vector -= spin
      else if hitter.yVelocity < 1
        @vector += spin

    #stop the ball bouncing up and down the screen
    @correctParallels()

    #update the ball's X and Y coordinates
    @yVelocity = @calcYVelocity()
    @xVelocity = @calcXVelocity()


  ###
  Bounce the ball on the given surface. The surface is specified by it's perpendicular angle.
  ###
  bounce: (normal) ->
    #calculate the angle between the current vector and the normal angle
    o = @vector - 180 - normal
    #calculate the angle between the normal angle and the bounced angle
    m = normal - o
    #make sure that the calculated angle is between 1 and 360
    if m <= 0
      m += 360
    else if m > 360
      m -= 360

    #assign the new vector
    @vector = m

  ###
  Stop the ball getting stuck moving in vertical lines
  ###
  correctParallels: ->
    if @vector > 265 and @vector <= 270 or @vector > 85 and @vector <= 90
      @vector -= 1
    else if @vector > 270 and @vector <= 275 or @vector > 90 and @vector <= 95
      @vector += 1

  ###
  Calculates the Y coordinate from the velocity and vector
  ###
  calcYVelocity: ->
    @velocity * Math.sin @degreesToRadians(@vector)

  ###
  Calculates the X coordinate from the velocity and vector
  ###
  calcXVelocity: ->
    @velocity * Math.cos @degreesToRadians(@vector)

  ###
  Set the initial state for the ball.
  ###
  reset: ->
    #start the ball in the centre
    @x = game.width / 2 - @width
    @y = game.height / 2 - @height

    #we want a the ball either to go left or right, randomly
    minVelocity = -6
    maxVelocity = 6
    randVelocity = if Math.random() > 0.5 then maxVelocity else  minVelocity

    #start the ball moving within a 50 degree arc, randomly
    minVector = -25
    maxVector = 25
    randVector = Math.floor Math.random() * (maxVector - minVector + 1) + minVector

    #set the random velocity and vector
    @velocity = randVelocity
    @vector = 0 + randVector

    #if the random vecolicty was negative (moving to the right), make the velocity
    # positive and flip the vector 180 degrees (this is the same overall, but the
    # maths in easier).
    if @velocity < 0
      @velocity = -@velocity
      @vector += 180

    #transform the speed and angular to X and Y coordinates.
    @yVelocity = @calcYVelocity()
    @xVelocity = @calcXVelocity()
