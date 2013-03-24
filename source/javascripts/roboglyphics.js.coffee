# roboglyphics #

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

  randAngle: ->
    Math.random() * Math.PI * 2

  rand: ->
    (Math.random() - 0.5)*2

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
    @angle = @randAngle()
    @dAngle = 0.005*@rand()
    @ddAngle = 0.0005*@rand()
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

  draw: (a) ->
    a.save()
    a.translate @pos.x, @pos.y
    a.beginPath()
    a.arc 0,0,3,@weight * @scale,0,Math.PI*2,true
    a.fill()
    a.restore()



class Roboglypics
  constructor: (@canvasEl, @settings) ->
    @pen = null
    @a = canvasEl.getContext('2d')
    @canvasEl.width = @canvasEl.offsetWidth
    @canvasEl.height = @canvasEl.offsetHeight
    window.requestAnimationFrame @onRender

  reset: ->
    @a.clearRect(0,0,@canvasEl.width,@canvasEl.height)

  setPen: (penCtor) ->
    @pen = new penCtor @canvasEl

  onRender: =>
    
    @a.fillStyle = 'black'#$scope.color#'rgba(0,0,0,0.9)'

    if @pen?
      for i in [0..@settings.speed]
        @pen.step()
        break if @pen.done
        @pen.draw @a

    window.requestAnimationFrame @onRender




window.rg =
  Roboglypics: Roboglypics
  Pen: Pen
  Vec: Vec
