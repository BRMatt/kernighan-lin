
module Klin
  class Partition
    def self.denormalize_edges(edges)
      node_edges = {}

      edges.each do |edge|
        node_edges[edge.source] ||= []
        node_edges[edge.target] ||= []

        node_edges[edge.source] << edge
        node_edges[edge.target] << edge
      end

      node_edges
    end

    attr_reader :nodes, :edges, :node_edges

    def initialize(nodes, edges)
      @nodes      = Array(nodes).map { |node| Node(node) }
      @edges      = Array(edges).map { |edge| Edge(edge) }
      @node_edges = self.class.denormalize_edges(@edges)
    end

    def calculate
      set_a,set_b = random_partition(nodes)

      begin
        set_a_temp, set_b_temp = set_a.dup, set_b.dup
        swapped_nodes = []
        swaps = []

        differences  = node_weights.calculate(set_a_temp, set_b_temp)

        for i in 0..[set_a_temp.length, set_b_temp.length].min do
          # Generate all pairs of nodes (a,b) excluding the nodes in swapped_nodes
          all_pairs = pairer.pairs(set_a_temp, set_b_temp, swapped_nodes)

          if swap = swap_scorer.find_best_swap(all_pairs, differences)
            swaps[i] = swap

            swapped_nodes << swap.node_from_a
            swapped_nodes << swap.node_from_b

            set_a_temp.delete(swap.node_from_a)
            set_b_temp.delete(swap.node_from_b)

            set_a_temp << swap.node_from_b
            set_b_temp << swap.node_from_a

            differences = node_weights.calculate(set_a_temp, set_b_temp)
          end
        end

        index_of_max, g_max = gain_maximiser.maximise(swaps)

        for i in 0..index_of_max do
          set_a.delete(swaps[i].node_from_a)
          set_b.delete(swaps[i].node_from_b)

          set_a << swaps[i].node_from_b
          set_b << swaps[i].node_from_a
        end

      end while g_max > 0

      [set_a.sort, set_b.sort]
    end


    private
    def random_partition(nodes, number_partitions = 2)
      partitions = []
      (0..(number_partitions-1)).each do |i|
        partitions[i] = []
      end

      nodes.each_index do |i|
        partition = (i % number_partitions)

        partitions[partition] << nodes[i]
      end

      partitions
    end

    def costs
      @costs ||= PartitionCosts.new(all_nodes, node_edges)
    end

    def pairer
      @pairer ||= Pairer.new
    end

    def swap_scorer
      @swap_scorer ||= SwapScorer.new(node_edges)
    end

    def gain_maximiser
      @gain_maximiser ||= GainMaximiser.new
    end

    def node_weights
      @node_weights ||= NodeWeightings.new(nodes, node_edges)
    end
  end
end
