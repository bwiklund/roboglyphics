# hello


class Vec
  constructor: (@x=0,@y=0) ->
  add: (o) -> 
    @x+=o.x
    @y+=o.y


pos = null


age = 0

angle = 0
dAngle = 0
ddAngle = 0
dampDAngle = 0.99
dampDDAngle = 0.9
changeDirectionChance = 0
noOverlap = false
maxLength = Number.POSITIVE_INFINITY
weight = 2

j = 0
h = 50
resetPoint = ->
  age = 0
  j+=10
  pos = new Vec j,h#@canvas.width * Math.random(), @canvas.height * Math.random()
  if j > @canvas.width
    j = j%@canvas.width
    h+=40
  changeDirection()

changeDirection = ->
  # #pube mode
  # angle  = Math.random() * Math.PI * 2
  # dAngle = 0.5*(Math.random() - 0.5)
  # ddAngle = 0.01*(Math.random() - 0.5)
  # changeDirectionChance = 0.01
  angle = Math.random() * Math.PI * 2
  dAngle = 0.1*(Math.random() - 0.5)
  ddAngle = 0
  changeDirectionChance = 0.001
  dampDAngle = 1
  dampDDAngle = 0
  if Math.random() < 0.1 then angle = dAngle = 0
  maxLength = 200 + Math.random()*100

checkPixel = (x,y) ->
  data = @context.getImageData(x, y, 1, 1).data
  data[3] > 100


framework = cq().framework
  onRender: ->
    if pos == null
      resetPoint.call @

    @.fillStyle 'rgba(0,0,0,0.9)'

    for i in [0..500]
      age++
      pos.x += 0.1*Math.cos angle
      pos.y += 0.1*Math.sin angle

      dAngle += ddAngle
      angle += dAngle

      dAngle *= dampDAngle
      ddAngle *= dampDDAngle

      if Math.random() < changeDirectionChance
        changeDirection()

      @.save()
      @.translate pos.x, pos.y
      @.beginPath()
      @.arc 0,0,3,weight,0,Math.PI*2,true
      @.fill()
      @.restore()

      if age > maxLength
        resetPoint.call this

      if noOverlap
        if checkPixel.call this, pos.x, pos.y
          resetPoint.call this

      if pos.x < 0 || pos.y < 0 || pos.x > @canvas.width || pos.y > @canvas.height
        resetPoint.call this





$ -> framework.appendTo('body')