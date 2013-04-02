class Graph
  constructor: (@options={}) ->
    @options.height ?= 200
    @options.interval ?= 100
    @options.extraStyles ?= ''

    @points = []
  
  add: (vals...) ->
    @points.push.apply @points, vals

    @renderIfWatching()
  
  clear: ->
    @points = []

    @renderIfWatching()

  watch: (opts) ->
    @watching = true

  stop: ->
    @watching = false
    clearTimeout @timeout

  renderIfWatching: ->
    if @watching
      if not @lastRender?
        timeToNext = 0
      else
        timeSinceLast = +(new Date) - @lastRender
        timeToNext = @options.interval - timeSinceLast

      @timeout = setTimeout =>
        @render()
      , Math.max(timeToNext, 0)

  render: ->
    @lastRender = +(new Date)

class BarGraph extends Graph
  constructor: (@options={}) ->
    super

    @options.barWidth ?= 3

  _inspectorHeight: ->
    window.outerHeight - window.innerHeight - @options.height

  render: ->
    super

    inspectorHeight = @_inspectorHeight()
    inspectorWidth = window.innerWidth
    
    # Shift the graph down
    console.log "%c ", "font-size: #{ inspectorHeight }px"

    # Allocate enough space for the height
    console.log "%c ", "padding-bottom: #{ @options.height + @options.barWidth }px"

    steps = inspectorWidth / @options.barWidth

    xScaling = Math.min(steps / @points.length, 1)

    pointMax = Math.max @points...
    yScaling = pointMax / @options.height

    spaces = ""
    styles = []
    for i in [0..Math.min(steps, @points.length)]
      point = @points[Math.floor(i / xScaling)]

      spaces += "%c "

      # We need to shift the points down by the bar width, as we're setting the width with the font size, so the entire block will extend
      # barWidth over the bottom of the text line.  We can't hide the text line, so we'll use it to represent the max.
      height = (point / yScaling) + @options.barWidth

      styles.push "font-size: #{ @options.barWidth }px; background-color: #444; padding-bottom: #{ height }px; #{ @options.extraStyles }"

    @options.step?()

    console.log spaces, styles...


window.console.graph = (options) ->
  graph = new BarGraph options

  if options.points?
    graph.add options.points...

  graph.render()

  graph

console.graph.Graph = Graph
console.graph.BarGraph = BarGraph
