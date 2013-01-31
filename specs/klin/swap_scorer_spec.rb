
describe Klin::SwapScorer do
  # Nodes a,b are on one side, c,d on the other
  let(:nodes) { [Node(:a), Node(:b), Node(:c), Node(:d)] }
  let(:edges) {
    [
      Edge(:a, :b, 2),
      Edge(:a, :c, 10),
      Edge(:b, :c, 4),
      Edge(:c, :d, 1)
    ]
  }
  # External cost - Internal cost
  let(:differences) { {
      Node(:a) => 8,
      Node(:b) => 2,
      Node(:c) => 13,
      Node(:d) => -1
    }
  }
  let(:node_edges) { Klin::Partition.denormalize_edges(edges) }
  let(:pairs) do
    [
      [Node(:a), Node(:c)],
      [Node(:a), Node(:d)],
      [Node(:b), Node(:c)],
      [Node(:b), Node(:d)]
    ]
  end

  subject(:scorer) { described_class.new(node_edges) }

  describe "#find_best_swap" do
    subject(:best_swap) { scorer.find_best_swap(pairs, differences) }
    let(:acceptable_swaps) { [[Node(:a), Node(:d)], [Node(:b), Node(:c)]] }

    specify { expect(acceptable_swaps).to include(best_swap) }
  end
end
