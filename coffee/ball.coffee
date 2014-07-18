class Ball extends Entity
  constructor: ->
    super()
    @width = 20
    @height = 20
    @velocityShare = 4
    @velocityBounce = 0.2
    @velocity = 0
    @vector = 0
    @reset()

  update: (steps) ->
    super steps
    if @y >= game.height - @height
      @y = game.height - @height
      @bounce 270
    else if @y < 0
      @y = 0
      @bounce 90

    if @x > game.width
      game.player.score++
      @reset()
    if @x < 0
      game.bot.score++
      @reset()

    if @intersect game.bot
      hitter = game.bot
      @x = game.bot.x - @width
      @bounce 180

    else if @intersect game.player
      @x = game.player.x + game.player.width
      hitter = game.player
      @bounce 360

    if hitter
      spin = hitter.yVelocity * 1.5
      @velocity += 0.2
      if hitter.yVelocity > 0
        @vector -= spin
      else if hitter.yVelocity < 0
        @vector += spin

    @yVelocity = @calcYVelocity()
    @xVelocity = @calcXVelocity()


  bounce: (normal) ->
    console.log "bounce"
    o = @vector - 180 - normal
    m = normal - o
    if m < 0
      m += 360
    else if m > 360
      m -= 360
    @vector = m


  calcYVelocity: ->
    @velocity * Math.sin @degreesToRadians(@vector)

  calcXVelocity: ->
    @velocity * Math.cos @degreesToRadians(@vector)


  reset: ->
    @x = game.width / 2 - @width
    @y = game.height / 2 - @height

    minVelocity = -6
    maxVelocity = 6
    randVelocity = if Math.random() > 0.5 then maxVelocity else  minVelocity

    minVector = -25
    maxVector = 25
    randVector = Math.floor Math.random() * (maxVector - minVector + 1) + minVector

    @velocity = randVelocity
    @vector = 0 + randVector

    if @velocity < 0
      @velocity = -@velocity
      @vector += 180

    @yVelocity = @calcYVelocity()
    @xVelocity = @calcXVelocity()
