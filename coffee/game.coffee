class Game
  fps: 60
  constructor: (@canvas, @fps = 60) ->
    @context = @canvas.getContext '2d'
    @width = @canvas.width
    @height = @canvas.height
    @entities = []

    # Keep track of key states
    @keyPressed = {}

    $(@canvas).on 'keydown keyup', (event) =>
      keyName = Game.keys[event.which]

      if keyName
        @keyPressed[keyName] = event.type is 'keydown'
        event.preventDefault()

  start: ->
    @frame =>
      @loop()

  frame: (callFrame) ->
    if window.requestAnimationFrame
      requestAnimationFrame =>
        callFrame()
        @frame callFrame
    else
      interval = 1000 / @fps
      setInterval =>
        callFrame()
      , interval


  loop: ->
    @update()
    @draw()

  update: ->
    for entity in @entities
      entity.update() if entity.update

  draw: ->
    for entity in @entities
      entity.draw @context if entity.draw

  @keys:
    32: 'space'
    37: 'left'
    38: 'up'
    39: 'right'
    40: 'down'
