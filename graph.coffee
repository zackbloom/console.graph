class Renderer

class Graph
  constructor: ->
    @points = []
  
  add: (vals...) ->
    @points.push.apply @points, vals
    
  render: ->

class BarGraph extends Graph
  constructor: (@options={}) ->
    super

    @options.resolution ?= 1
    @options.height ?= 200
    @options.extraStyles ?= ''

  _inspectorHeight: ->
    window.outerHeight - window.innerHeight - 180

  render: ->
    inspectorHeight = @_inspectorHeight()
    inspectorWidth = window.innerWidth

    console.log "%c ", "font-size: #{ inspectorHeight }px"
    console.log "%c ", "padding-bottom: #{ @options.height }px"

    steps = inspectorWidth / @options.resolution

    xScaling = Math.min(steps / @points.length, 1)

    pointMax = Math.max @points...
    yScaling = pointMax / @options.height
    console.log pointMax, @options.height, yScaling

    spaces = ""
    styles = []
    for i in [0..Math.min(steps, @points.length)]
      point = @points[Math.floor(i / xScaling)]

      spaces += "%c "

      styles.push "font-size: #{ @options.resolution }px; background-color: blue; padding-bottom: #{ point / yScaling }px; #{ @options.extraStyles }"

    console.log spaces, styles...

graph = new BarGraph
  extraStyles: 'text-shadow: 1px 1px 1px grey; border: 1px solid #CCC'

last = 500
j = 0
intv = setInterval ->
  j++

  last = Math.min(1000, Math.max(0, Math.floor(last + (Math.random() * 300 - 150))))
  graph.add last
  graph.render()

  if j >= 2000
    clearInterval intv
, 100

