###
A base class for objects that move around the game area. The can be updated and drawn.
###
class Entity
  constructor: ->
    @x =  0
    @y =  0
    @width = 0
    @height = 0
    @xVelocity = 0
    @yVelocity = 0

  ###
  Update the entity by the given number of steps.
  ###
  update: (steps) ->
    @x += @xVelocity * steps
    @y += @yVelocity * steps

  ###
  Draw the entity on the given drawing surface.
  ###
  draw: (context) ->
    context.fillStyle = '#fff'
    context.fillRect @x, @y, @width, @height

  ###
  Does this entity intersect with the given other entity?
  ###
  intersect: (other) ->
    @y + @height > other.y and @y < other.y + other.height and @x + @width > other.x and @x < other.x + other.width

  ###
  A helper method to transform degrees to radians
  ###
  degreesToRadians: (degrees) ->
    degrees * Math.PI / 180

  ###
  A helper method to transform radians to degrees.
  ###
  radiansToDegrees: (radians) ->
    radians * 180 / Math.PI
