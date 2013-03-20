modes = []
MODE = (klass) -> modes.push klass


MODE class Clef extends window.rg.Pen
  onSetup: ->
    @scale = 2

  angleFilter: ->
    Math.PI * 2 * Math.sin @angle * 100

  onStep: ->
    @weight = @age / @maxLength

  changeDirection: ->
    @angle = @randAngle()
    @dAngle = 0.0005*@rand()
    @ddAngle = 0
    @changeDirectionChance = 0.001
    @dampDAngle = 1
    @dampDDAngle = 1
    @maxLength = 500 + Math.random()*600


    
MODE class Roboglyph extends window.rg.Pen
  angleFilter: ->
    mult = Math.PI/3
    Math.round(@angle/mult)*mult


MODE class Loopy extends window.rg.Pen
  changeDirection: ->
    @angle = @randAngle()
    @dAngle = 0.005*@rand()
    @ddAngle = 0.0005*@rand()
    @changeDirectionChance = 0.001
    @dampDAngle = 1
    @dampDDAngle = 1
    @maxLength = 200 + Math.random()*100


MODE class Giraffes extends window.rg.Pen
  changeDirection: ->
    @angle = -Math.PI/2#@randAngle()
    @dAngle = 0.005*@rand()
    @ddAngle = 0.0005*@rand()
    @changeDirectionChance = 0.005
    @dampDAngle = 1
    @dampDDAngle = 1
    @maxLength = 200 + Math.random()*100


MODE class Leonardo extends window.rg.Pen
  changeDirection: ->
    @angle = @randAngle()
    @dAngle = 0.02*@rand()*0.5
    @ddAngle = 0.01*@rand()*0.5
    @changeDirectionChance = 0.008
    @dampDAngle = 0.99
    @dampDDAngle = 0.99
    @maxLength = 200 + Math.random()*600


MODE class Fantasy extends window.rg.Pen
  changeDirection: ->
    @angle = @randAngle()
    @dAngle = 0.005 + 0.06*Math.random()
    @ddAngle = 0
    @changeDirectionChance = 0
    @dampDAngle = 1
    @dampDDAngle = 1
    @maxLength = 200 + Math.random()*600




MODE class BassClef extends window.rg.Pen
  onSetup: ->
    @scale = 2

  angleFilter: ->
    Math.PI * 2 * Math.sin @angle * 100

  onStep: ->
    @weight = 2*(1 - @age / @maxLength)

  changeDirection: ->
    @angle = @randAngle()
    @dAngle = 0.0005*@rand()
    @ddAngle = 0
    @changeDirectionChance = 0.001
    @dampDAngle = 1
    @dampDDAngle = 1
    @maxLength = 500 + Math.random()*600


MODE class Stacatto extends window.rg.Pen
  onSetup: ->
    @scale = 2.5

  angleFilter: ->
    Math.PI * 2 * Math.sin @angle * 100

  onStep: ->
    @weight = 2*(1 - @age / @maxLength)
    if @age % 200 < 100
      @weight = 0.5

  changeDirection: ->
    @angle = @randAngle()
    @dAngle = 0.0005*@rand()
    @ddAngle = 0
    @changeDirectionChance = 0.001
    @dampDAngle = 1
    @dampDDAngle = 1
    @maxLength = 500 + Math.random()*600


MODE class Madman extends window.rg.Pen
  angleFilter: ->
    if @age % 70 < 60
      Math.PI * 2 * Math.cos @angle
    else
      @rand()*Math.PI

  changeDirection: ->
    @weight = Math.random()
    @angle = @randAngle()
    @dAngle = 0.005*@rand()
    @ddAngle = 0.001*@rand()
    @changeDirectionChance = 0.1
    @dampDAngle = 0.9
    @dampDDAngle = 0.9
    @maxLength = 500 + Math.random()*600


window.rgSamples = modes