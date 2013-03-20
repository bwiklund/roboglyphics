# hello

# some utility functions
randAngle = ->
  Math.random() * Math.PI * 2

rand = ->
  (Math.random() - 0.5)*2

class Vec
  constructor: (@x=0,@y=0) ->
  add: (o) -> 
    @x+=o.x
    @y+=o.y


class Pen 
  constructor: (@canvas) ->
    @initDefaults()
    @onSetup?()
    @resetPoint()

  initDefaults: ->
    @scale = 1
    @age = 0
    @angle = 0
    @dAngle = 0
    @ddAngle = 0
    @dampDAngle = 1
    @dampDDAngle = 1
    @changeDirectionChance = 0
    @maxLength = Number.POSITIVE_INFINITY
    @weight = 2

    @margin = Math.min 100, 0.1 * @canvas.width
    @lineHeight = 30
    @letterSpacing = 10
    @baseX = Number.POSITIVE_INFINITY
    @baseY = @margin-@lineHeight

  angleFilter: ->
    @angle

  resetPoint: ->
    @age = 0

    @pos = new Vec @baseX, @baseY
    @newLineIfNeeded()
    @changeDirection()

  newLineIfNeeded: ->
    @baseX += @letterSpacing * @scale
    if @baseX > @canvas.width - @margin
      @baseX = @margin
      @baseY += @lineHeight * @scale
    if @baseY > @canvas.height - @margin
      @done = true

  changeDirection: ->
    @angle = randAngle()
    @dAngle = 0.005*rand()
    @ddAngle = 0.0005*rand()
    @changeDirectionChance = 0.001
    @dampDAngle = 1
    @dampDDAngle = 1
    @maxLength = 200 + Math.random()*100


  step: ->
    @onStep?()

    if @age > @maxLength
      @resetPoint()

    if @pos.x < 0 || @pos.y < 0 || @pos.x > @canvas.width || @pos.y > @canvas.height
      @resetPoint()
      
    @age++
    @pos.x += @scale*0.1*Math.cos @angleFilter()
    @pos.y += @scale*0.1*Math.sin @angleFilter()

    @dAngle += @ddAngle
    @angle += @dAngle

    @dAngle *= @dampDAngle
    @ddAngle *= @dampDDAngle

    if Math.random() < @changeDirectionChance
      @changeDirection()



modes = []
MODE = (klass) -> modes.push klass


MODE class Roboglypics extends Pen
  angleFilter: ->
    mult = Math.PI/3
    Math.round(@angle/mult)*mult


MODE class Loopy extends Pen
  changeDirection: ->
    @angle = randAngle()
    @dAngle = 0.005*rand()
    @ddAngle = 0.0005*rand()
    @changeDirectionChance = 0.001
    @dampDAngle = 1
    @dampDDAngle = 1
    @maxLength = 200 + Math.random()*100


MODE class Giraffes extends Pen
  changeDirection: ->
    @angle = -Math.PI/2#randAngle()
    @dAngle = 0.005*rand()
    @ddAngle = 0.0005*rand()
    @changeDirectionChance = 0.005
    @dampDAngle = 1
    @dampDDAngle = 1
    @maxLength = 200 + Math.random()*100


MODE class Leonardo extends Pen
  changeDirection: ->
    @angle = randAngle()
    @dAngle = 0.02*rand()*0.5
    @ddAngle = 0.01*rand()*0.5
    @changeDirectionChance = 0.008
    @dampDAngle = 0.99
    @dampDDAngle = 0.99
    @maxLength = 200 + Math.random()*600


MODE class Fantasy extends Pen
  changeDirection: ->
    @angle = randAngle()
    @dAngle = 0.005 + 0.06*Math.random()
    @ddAngle = 0
    @changeDirectionChance = 0
    @dampDAngle = 1
    @dampDDAngle = 1
    @maxLength = 200 + Math.random()*600


MODE class Clef extends Pen
  onSetup: ->
    @scale = 2

  angleFilter: ->
    Math.PI * 2 * Math.sin @angle * 100

  onStep: ->
    @weight = @age / @maxLength

  changeDirection: ->
    @angle = randAngle()
    @dAngle = 0.0005*rand()
    @ddAngle = 0
    @changeDirectionChance = 0.001
    @dampDAngle = 1
    @dampDDAngle = 1
    @maxLength = 500 + Math.random()*600


MODE class BassClef extends Pen
  onSetup: ->
    @scale = 2

  angleFilter: ->
    Math.PI * 2 * Math.sin @angle * 100

  onStep: ->
    @weight = 2*(1 - @age / @maxLength)

  changeDirection: ->
    @angle = randAngle()
    @dAngle = 0.0005*rand()
    @ddAngle = 0
    @changeDirectionChance = 0.001
    @dampDAngle = 1
    @dampDDAngle = 1
    @maxLength = 500 + Math.random()*600


MODE class Stacatto extends Pen
  onSetup: ->
    @scale = 2.5

  angleFilter: ->
    Math.PI * 2 * Math.sin @angle * 100

  onStep: ->
    @weight = 2*(1 - @age / @maxLength)
    if @age % 200 < 100
      @weight = 0.5

  changeDirection: ->
    @angle = randAngle()
    @dAngle = 0.0005*rand()
    @ddAngle = 0
    @changeDirectionChance = 0.001
    @dampDAngle = 1
    @dampDDAngle = 1
    @maxLength = 500 + Math.random()*600


MODE class Madman extends Pen
  angleFilter: ->
    if @age % 70 < 60
      Math.PI * 2 * Math.cos @angle
    else
      rand()*Math.PI

  changeDirection: ->
    @weight = Math.random()
    @angle = randAngle()
    @dAngle = 0.005*rand()
    @ddAngle = 0.001*rand()
    @changeDirectionChance = 0.1
    @dampDAngle = 0.9
    @dampDDAngle = 0.9
    @maxLength = 500 + Math.random()*600


    
    
    



  


app = angular.module 'demoControls', [], ->

app.controller 'MainCtrl', ($scope) ->
  $scope.modes = modes
  $scope.currentMode = Clef
  $scope.speed = 400

  # bootstrap out thing
  pen = null
  running = true

  framework = cq().framework
    onRender: ->
      
      @.fillStyle $scope.color#'rgba(0,0,0,0.9)'

      for i in [0..$scope.speed]

        # reset if the control panel has changed something
        if !pen?
          @clear()
          pen ?= new $scope.currentMode @canvas

        pen.step()
        return if pen.done
        
        @.save()
        @.translate pen.pos.x, pen.pos.y
        @.beginPath()
        @.arc 0,0,3,pen.weight * pen.scale,0,Math.PI*2,true
        @.fill()
        @.restore()

  framework.appendTo('.demoCanvas')


  $scope.$watch 'currentMode', (nval) ->
    pen = null #the render loop will pick up the actual value next time around
