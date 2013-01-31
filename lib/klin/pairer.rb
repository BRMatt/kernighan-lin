
module Klin
  class Pairer
    def pairs(set_a, set_b, nodes_to_ignore = [])
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
  end
end
