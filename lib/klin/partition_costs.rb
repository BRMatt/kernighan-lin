
module Klin
  # Calculates the costs of all nodes due to the specified partition
  PartitionCosts = Struct.new(:all_nodes, :node_edges) do
    def calculate(set_a, set_b)
      nodes.map do |node|
        internal_nodes = partition_for_node(node, set_a, set_b)

        internal_cost = 0
        external_cost = 0

        Array(node_edges[node]).each do |edge|
          if edge.within_partition?(int_nodes)
            internal_cost += edge.cost
          else
            external_cost += edge.cost
          end
        end

        external_cost - internal_cost
      end
    end

    private
    def internal_external_nodes(node, set_a, set_b)
      if set_a.include? node
        [set_a, set_b]
      else
        [set_b, set_a]
      end
    end

    def external_nodes

    end
  end
end
