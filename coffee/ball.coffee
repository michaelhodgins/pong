class Ball extends Entity
  constructor: ->
    super()
    @width = 20
    @height = 20
    @velocityShare = 4
    @velocityBounce = 1.05
    @velocity = 0
    @vector = 0
    @reset()

  update: (steps) ->
    super steps
    @yVelocity *= -1 if @y > game.height - @height or @y < 0

    if @x > game.width
      game.player.score++
      @reset()
    if @x < 0
      game.bot.score++
      @reset()

    if @intersect game.bot
      hitter = game.bot
    else if @intersect game.player
      hitter = game.player

    if hitter
      @xVelocity *= -@velocityBounce
      if hitter.yVelocity
        @yVelocity *= -@velocityBounce
        @yVelocity += hitter.yVelocity / @velocityShare


  calcYVelocity: ->
    @velocity * Math.sin @degreesToRadians(@vector)

  calcXVelocity: ->
    @velocity * Math.cos @degreesToRadians(@vector)


  reset: ->
    @x = game.width / 2 - @width
    @y = game.height / 2 - @height

    minVelocity = -5
    maxVelocity = 5
    randVelocity = if Math.random() > 0.5 then maxVelocity else  minVelocity

    minVector = -25
    maxVector = 25
    randVector = Math.floor Math.random() * (maxVector - minVector + 1) + minVector

    @velocity = randVelocity
    @vector = randVector

    @yVelocity = @calcYVelocity()
    @xVelocity = @calcXVelocity()
