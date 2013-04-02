console.clear()

graph = new console.graph.BarGraph
graph.watch()

last = 500
j = 0
intv = setInterval ->
  j++

  last = Math.min(1000, Math.max(0, Math.floor(last + (Math.random() * 300 - 150))))
  graph.add last

  if j >= 2000
    clearInterval intv
, 100
