
module KLin

  Node        = Struct.new(:id) { def to_node; self; end }
  class FullEdge
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
