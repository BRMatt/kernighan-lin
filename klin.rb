
class Klin
  attr_reader :nodes, :edges, :node_edges

  def initialize(nodes, edges)
    @nodes = Array(nodes)
    @edges = Array(edges)
    @node_edges = {}

    @edges.each do |edge|
      source,target,cost = edge
      @node_edges[source] ||= []
      @node_edges[target] ||= []

      @node_edges[source] << {:target => target, :cost => cost}
      @node_edges[target] << {:target => source, :cost => cost}
    end
  end

  def calculate
  puts "calling calculate"
    a = nodes.select { |node| node % 2 == 0 }
    b = Array(nodes) - a
    g_max = 0
    bzy = 0

    begin
      puts ""
      bzy += 1
      a_temp, b_temp = a.dup, b.dup
      d = calculate_d(a, b)
      swaps = []
      swapped_nodes = []

      for i in 0..((nodes.length/2).ceil - 1) do
        power_set = all_pairs(a_temp, b_temp, swapped_nodes)

        swap, g = find_best_swap(power_set, d)

        best_a,best_b = swap

        swaps[i] = {:a => best_a, :b => best_b, :g => g}

        swapped_nodes << best_a
        swapped_nodes << best_b

        puts "Set a: #{a_temp}"
        puts "Set b: #{b_temp}"

        a_temp.delete(best_a)
        b_temp.delete(best_b)

        a_temp << best_b
        b_temp << best_a

        puts "Set a: #{a_temp}"
        puts "Set b: #{b_temp}"

        d = calculate_d(a_temp, b_temp)
      end

      puts "Swaps: ", swaps

      k, g_max = maximise_gain_of_swaps(swaps)

      puts "K: #{k}, Gmax: #{g_max}"

      if bzy > 3
        exit
       end

      for i in 0..k do
        a.delete(swaps[i][:a])
        b.delete(swaps[i][:b])

        a << swaps[i][:b]
        b << swaps[i][:a]
      end

    end while g_max > 0

    puts "A:", a, "B:", b
  end

  private

  def maximise_gain_of_swaps(swaps)
    max_gain = 0
    max_i = 0

    swaps.each_index do |index|
      swap = swaps[index]
      new_gain = max_gain + swap[:g]

      puts "Looking at swap #{index}"
      puts "Gain_max: #{max_gain}, new gain: #{new_gain}"

      if (max_gain + swap[:g]) > max_gain
        max_i = index
        max_gain += swap[:g]
      end
    end

    [max_i, max_gain]
  end

  def find_best_swap(pairs, differences)
    puts
    puts "Trying with #{pairs.length}"

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

      puts "Cost of #{a}->#{b} is #{g} #{g > max ? 'max' : 'not max'} (#{differences[a]} + #{differences[b]} - 2*#{cost}"
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
      if edge[:target] == b
        return edge[:cost]
      end
    end
    nil
  end

  def all_pairs(set_a, set_b, nodes_to_ignore)
    a_nodes = set_a - nodes_to_ignore
    b_nodes = set_b - nodes_to_ignore

    [].tap  do |pairs|
      a_nodes.each do |a|
        b_nodes.each do |b|
          pairs << [a,b]
        end
      end
    end
  end

  def calculate_d(a, b)
    nodes.map do |node|
      if a.include? node
        internal_nodes = a
        external_nodes = b
      else
        internal_nodes = b
        external_nodes = a
      end

      internal_cost = 0
      external_cost = 0

      Array(node_edges[node]).each do |link|
        if internal_nodes.include? link[:target]
          internal_cost += link[:cost]
        else
          external_cost += link[:cost]
        end
      end

      external_cost - internal_cost
    end		
  end
end

Klin.new([0,1,2,3,4,5,6,7], [[0,5,120],[1,2,80],[2,7,30],[3,1,300],[4,3,100],[5,2,100],[6,0,100],[7,0,100]]).calculate
