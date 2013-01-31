
class Klin::Swap
  attr_reader :pair, :g

  def initialize(pair, g)
    @pair = pair
    @g = g
  end

  def eql?(other)
    other.respond_to?(:pair) && @pair.eql?(other.pair) && @g.eql?(other.g)
  end
  alias_method :==, :eql?
end
class Klin::SwapScorer
  attr_reader :node_edges

  def initialize(node_edges)
    @node_edges = node_edges
  end

  def find_best_swap(pairs, differences)
    find_all_best_swaps(pairs, differences).first
  end


  def find_all_best_swaps(pairs, differences)
    #puts
    #puts "Trying with #{pairs.length}"

    max = -999999999999
    max_pairs = []

    pairs.each do |pair|
      a,b = pair

      g = differences[a] + differences[b]

      if cost = cost_of_edge_between(a, b)
        g = g - (2*cost)
      else
        cost = 0
      end

      #puts "Cost of #{a}->#{b} is #{g} #{g > max ? 'max' : 'not max'} (#{differences[a]} + #{differences[b]} - 2*#{cost}"
      if g == max
        max_pairs << Klin::Swap.new(pair, g)
      elsif g > max
        max = g
        max_pairs = [Klin::Swap.new(pair, g)]
      end
    end

    max_pairs
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
