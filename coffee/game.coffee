class Game
  fps: 60
  constructor: (@canvas, @fps = 60) ->
    @context = @canvas.getContext '2d'
    @width = @canvas.width
    @height = @canvas.height
    @entities = []
    @desiredStep = 1000 / @fps

    window.requestAnimationFrame = window.requestAnimationFrame or window.mozRequestAnimationFrame or window.webkitRequestAnimationFrame or window.msRequestAnimationFrame

    # Keep track of key states
    @keyPressed = {}

    $(@canvas).on 'keydown keyup', (event) =>
      keyName = Game.keys[event.which]

      if keyName
        @keyPressed[keyName] = event.type is 'keydown'
        event.preventDefault()

  start: ->
    @recordUpdate()
    @frame =>
      @loop()

  frame: (callFrame) ->
    if window.requestAnimationFrame
      window.requestAnimationFrame =>
        callFrame()
        @frame callFrame
    else
      interval = 1000 / @fps
      setInterval ->
        callFrame()
      , interval


  loop: ->
    startTime = new Date().getTime()
    timePassed = startTime - @lastUpdate
    steps = @desiredStep / timePassed
    @update steps
    @draw()
    @recordUpdate()

  update: (steps) ->
    for entity in @entities
      entity.update steps if entity.update

  draw: ->
    for entity in @entities
      entity.draw @context if entity.draw

  recordUpdate: ->
    @lastUpdate = new Date().getTime()


  @keys:
    32: 'space'
    37: 'left'
    38: 'up'
    39: 'right'
    40: 'down'
