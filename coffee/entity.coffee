class Entity
  constructor: ->
    @x =  0
    @y =  0
    @width = 0
    @height = 0
    @xVelocity = 0
    @yVelocity = 0

  update: ->
    @x += @xVelocity
    @y += @yVelocity

  draw: (context) ->
    context.fillStyle = '#fff'
    context.fillRect @x, @y, @width, @height

  intersect: (other) ->
    @y + @height > other.y and @y < other.y + other.height and @x + @width > other.x and @x < other.x + other.width
