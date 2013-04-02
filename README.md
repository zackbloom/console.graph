console.graph
=============

Graph in the Chrome console.

[Demo](http://zackbloom.github.com/console.graph)

Overview
--------

The Google Chrome console supports a subset of CSS in its console.log messages.
By giving characters a background color, it is possible to draw a graph using
these messages.

Usage
-----

`console.graph(options)` - Draw a graph to the console, options:

  - `points` - An array of data points.  Scaling is automatically handled.
  - `barWidth` - The resolution of the bar chart.  Higher numbers will result in
      more performant graphing.
  - `height` - The height in the console of the graph.
  - `interval` - The maximum rendering interval when in watch-mode.
  - `extraStyles` - Additional CSS you wish to apply to the graph elements.  Note that
      most block-level CSS is not accepted.

Returns a `BarGraph` object which has the methods:

  - `add(point1, point2, ...)` - Adds one or more points.  Rescaling is handled 
      automatically to fit in the console.
  - `clear()` - Clear the points
  - `render()` - Render the graph to the console.
  - `watch()` - Automatically rerender the graph when new points get added, never
      more frequently than `options.interval` milliseconds.
  - `stop()` - Stop watching

