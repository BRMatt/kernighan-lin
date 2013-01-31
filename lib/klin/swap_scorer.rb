
class Klin::SwapScorer
  attr_reader :node_edges

  def initialize(node_edges)
    @node_edges = node_edges
  end

  def find_best_swap(pairs, differences)
    #puts
    #puts "Trying with #{pairs.length}"

    max = -999999999999
    max_pair = []

    pairs.each do |pair|
      a,b = pair

      g = differences[a] + differences[b]

      if cost = cost_of_edge_between(a, b)
        g = g - (2*cost)
      else
        cost = 0
      end

      #puts "Cost of #{a}->#{b} is #{g} #{g > max ? 'max' : 'not max'} (#{differences[a]} + #{differences[b]} - 2*#{cost}"
      if g > max
        max = g
        max_pair = pair
      end
    end
    puts [max_pair, max].to_s
    [max_pair, max]
  end

  def cost_of_edge_between(a, b)
    node_edges[a].each do |edge|
      if edge.incident_to? b
        return edge.cost
      end
    end
    nil
  end
end
