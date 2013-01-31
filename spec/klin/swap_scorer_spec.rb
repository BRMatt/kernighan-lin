
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
  let(:acceptable_swaps) { [
      Klin::Swap.new([Node(:a), Node(:d)], 7),
      Klin::Swap.new([Node(:b), Node(:c)], 7)
    ]
  }

  subject(:scorer) { described_class.new(node_edges) }

  describe "#find_best_swap" do
    subject(:best_swap) { scorer.find_best_swap(pairs, differences) }

    specify { expect(acceptable_swaps).to include(best_swap) }
  end

  describe "#find_all_best_swaps" do
    subject(:best_swap) { scorer.find_all_best_swaps(pairs, differences) }

    specify { expect(acceptable_swaps).to eql(best_swap) }
  end

  describe "#cost_of_edge_between" do
    subject(:cost) { scorer.cost_of_edge_between(node_a, node_b) }

    context "for two nodes that are connected" do
      let(:node_a) { Node(:a) }
      let(:node_b) { Node(:c) }

      specify { expect(cost).to be(10) }
    end
    context "for two nodes that are not connected" do
      let(:node_a) { Node(:a) }
      let(:node_b) { Node(:d) }

      specify { expect(cost).to be_nil }
    end
  end
end
