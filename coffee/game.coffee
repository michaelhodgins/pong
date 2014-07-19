###
Game is a class for coordinating the drawing surface, game entities and game loop.
###
class Game
  ###
  Construct the game with the given drawing surface. If fps is given, it is only used if the
  browser doesn't support a native FPS system.
  ###
  constructor: (@canvas, @fps = 60) ->
    @context = @canvas.getContext '2d'
    @width = @canvas.width
    @height = @canvas.height
    @entities = []
    @desiredStep = 1000 / @fps
    @debug = false #set to true to see debug information about the game on the screen

    @keyPressed = {}

    #monitor the keys that are pressed.
    $(@canvas).on 'keydown keyup', (event) =>
      keyName = Game.keys[event.which]

      if keyName
        @keyPressed[keyName] = event.type is 'keydown'
        event.preventDefault()

  ###
  Called to start the game loop
  ###
  start: ->
    @recordUpdate()
    @frame =>
      @loop()

  ###
  Sets up the mechanism for repeatedly updating and drawing the game.
  ###
  frame: (callFrame) ->
    # does the browser have a native FPS system?
    if window.requestAnimationFrame
      window.requestAnimationFrame =>
        callFrame()
        @frame callFrame
    # no, so fall back on using setInterval()
    else
      interval = 1000 / @fps
      setInterval ->
        callFrame()
      , interval

  ###
  Execute one update and drawing loop.
  ###
  loop: ->
    #calculate how much time has passed since the last update
    startTime = new Date().getTime()
    timePassed = startTime - @lastUpdate
    steps = @desiredStep / timePassed
    @update steps
    @draw()
    @recordUpdate()

  ###
  Update all the entities once.
  ###
  update: (steps) ->
    for entity in @entities
      entity.update steps if entity.update

    # Output some interesting data if @debug is true
    if @debug
      $("#vector").html "Ball Vector: #{@ball.vector.toFixed 1}°"
      $("#velocity").html "Ball Velocity: #{(@ball.velocity * @fps).toFixed 1} Pixels per second (#{@ball.velocity.toFixed 1} per frame)"
      $("#player-velocity").html "Player Velocity #{(@player.yVelocity * @fps).toFixed 1} Pixels per second (#{@player.yVelocity.toFixed 1} per frame)"
      $("#player-y").html "Player Y: #{@player.y.toFixed 1}"
      $("#bot-velocity").html "Bot Velocity #{(@bot.yVelocity * @fps).toFixed 1} Pixels per second (#{@bot.yVelocity.toFixed 1} per frame)"
      $("#bot-y").html "Bot Y: #{@bot.y.toFixed 1}"

  ###
  Draw each entity.
  ###
  draw: ->
    for entity in @entities
      entity.draw @context if entity.draw

  ###
  Call to record when an update cycle was completed
  ###
  recordUpdate: ->
    @lastUpdate = new Date().getTime()

  ###
  Constants for some keys we're interesting in
  ###
  @keys:
    32: 'space'
    37: 'left'
    38: 'up'
    39: 'right'
    40: 'down'
