# Implementation of Kernighan-Lin algorithm

From [wikipedia](http://en.wikipedia.org/wiki/Kernighan%E2%80%93Lin_algorithm):

> Kernighan–Lin is a O(n2 log n ) heuristic algorithm for solving the graph partitioning problem. The algorithm has important applications in the layout of digital circuits and components in VLSI.


Usage:

    require 'klin_solver.rb'

    nodes = [Node(:a), Node(:b), Node(:c), Node(:d)]
    edges = [Edge(:a, :b, 2), Edge(:a, :c, 10), Edge(:b, :c, 10), Edge(:c, :d, 1)]

    partitioner = Klin::Partitioner.new(nodes, edges)
    puts partitioner.calculate { |partition| puts "Partition: ",partition }
