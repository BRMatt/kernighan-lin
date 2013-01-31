$:.unshift File.join(File.dirname(__FILE__),'lib')

require 'klin/data_structures'
require 'klin/pairer'
require 'klin/partition'
require 'klin/partition_costs'

def Node(node)
  if node.respond_to? :to_node
    node.to_node
  else
    Klin::Node.new(node)
  end
end

def Edge(edge)
  if edge.respond_to? :to_edge
    edge.to_edge
  else
    a_edge = Array(edge)

    unless a_edge.length == 3
      raise "Unknown edge, #{edge}"
    end

    Klin::Edge.new(a_edge)
  end
end

if __FILE__ == $0

end
