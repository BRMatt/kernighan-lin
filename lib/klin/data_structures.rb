
module Klin

  class Node
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def inspect
      "Node(#{String(@id)})"
    end
    alias_method :to_s, :inspect

    def eql?(other)
      other.respond_to?(:id) && other.id == @id
    end
    alias_method :==, :eql?

    def <=>(other)
      @id <=> other.id
    end

    def hash
      @id.hash
    end

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

    def within_partition?(partition)
      partition.include?(@source) && partition.include?(@target)
    end

    def inspect
      "Edge(#{@source.inspect}-#{@target.inspect}, cost=#{@cost})"
    end
    alias_method :to_s, :inspect
  end
end
