
class Klin::NodeWeightings
  attr_reader :nodes, :node_edges

  def initialize(nodes, node_edges)
    @nodes = nodes
    @node_edges = node_edges
  end

  def calculate(set_a, set_b)
    differences = {}
    nodes.each do |node|
      internal_nodes = internal_partition_for_node(node, set_a, set_b)

      internal_cost = 0
      external_cost = 0

      Array(node_edges[node]).each do |edge|
        if edge.within_partition?(internal_nodes)
          internal_cost += edge.cost
        else
          external_cost += edge.cost
        end
      end

      differences[node] = external_cost - internal_cost
    end

    differences
  end

  private
  def internal_partition_for_node(node, set_a, set_b)
    if set_a.include? node
      internal_nodes = set_a
      external_nodes = set_b
    else
      internal_nodes = set_b
      external_nodes = set_a
    end
  end
end
