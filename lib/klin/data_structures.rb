
module Klin

  class Node
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def inspect
      "Node(#{String(@id)})"
    end

    def eql?(other)
      other.id == @id
    end
    alias_method :==, :eql?

    def to_node
      self
    end
  end

  class Edge
    attr_reader :source, :target, :cost
    def initialize(source, target, cost)
      @source = Node(source)
      @target = Node(target)
      @cost   = Integer(cost)
    end
    def to_edge; self; end

    def incident_to?(raw_node)
      nodes.include? Node(raw_node)
    end

    def nodes
      [@source, @target]
    end

    def within_partition(partition)
      partition.include?(@source) && partition.include?(@target)
    end
  end
end
