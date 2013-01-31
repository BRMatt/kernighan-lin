require_relative '../spec_helper'

describe Klin::GainMaximiser do
  def swap(node_from_a, node_from_b, gain)
    Klin::Swap.new([node_from_a, node_from_b], gain)
  end

  describe "#maximise" do
    subject(:maximised_gain) { described_class.new.maximise(swaps) }

    context "when there is a local minimum" do
      let(:swaps) {
        [
          swap(Node(:a), Node(:b), 2),
          swap(Node(:c), Node(:d), -2),
          swap(Node(:d), Node(:e), 20)
        ] 
      }

      specify { expect(maximised_gain).to eql([2, 20]) }
    end

    context "when there is a local maximum" do
      let(:swaps) {
        [
          swap(Node(:a), Node(:b), 2),
          swap(Node(:c), Node(:d), -2),
          swap(Node(:d), Node(:e), 0)
        ] 
      }

      specify { expect(maximised_gain).to eql([0, 2]) }
    end
  end
end
