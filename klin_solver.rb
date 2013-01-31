$:.unshift File.join(File.dirname(__FILE__),'lib')

require 'klin/data_structures'
require 'klin/pairer'
require 'klin/partition'
require 'klin/partition_costs'
require 'klin/swap_scorer'
require 'klin/gain_maximiser'
require 'klin/node_weightings'

def Node(node)
  if node.respond_to? :to_node
    node.to_node
  else
    Klin::Node.new(node)
  end
end

def Edge(*args)
  if args.size == 1 && args.first.respond_to?(:to_edge)
    args.first.to_edge
  else
    edge = if args.size > 1 then args else Array(args.first) end

    unless edge.length == 3
      raise "Unknown edge, #{edge}"
    end

    Klin::Edge.new(*edge)
  end
end

if __FILE__ == $0

end
